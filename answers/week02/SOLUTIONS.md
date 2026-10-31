# Week 2 exam assignments

## Task 01

---

## Task 02

---

## Task 03

> Do the coding warmup on slide 20. (optional)
>   1. Fix the race condition bug on page 13 with a std::mutex

The bug was fixed by adding a mutex `mtx` and locking it for the calculation of pi.

``` cpp
...
#include <mutex>
...

int main() {
  ...
  mutex mtx;
  ...
#pragma omp parallel num_threads(4)
  {
    ...
    mtx.lock();
    pi += sum_local * 4 * width;
    mtx.unlock();
    ...
  }
  ...
}
```

>   2. Reduce the runtime of the image denoising program on slide 16 by adding an appropriate schedule

Since the workload was unbalanced I tried dynamic scheduling with different chunk sizes.
Out of 64, 32, 16, 8, 4, 2, 1 chunk size 1 was by far the best.
A possible explanation for this is that the work per iteration grows quadratically (`denoised_images[i] = denoise_image(images[i], i * i);`).

``` cpp
...
#pragma omp parallel for num_threads(4) schedule(dynamic, 1)
...
```

> 3. What schedule on slide 18 produces the following (bad) pattern?

Since the output shows that thread 0 works on 22 consecutive iterations, the schedule used is either `static, 22` or `dynamic, 22`.

---

## Task 04

> Rewrite the program for estimating $\pi$ from the last lecture (`pi_numerical_integration.cpp`) so that it is parallelized with the `#pragma omp for` construct.

Since the sum needs `#pragma omp atomic` to avoid the race condition on `sum`, the overhead outweighs the effect of parallelization.
On my machine, the unparallelized version was done after 0.361928 seconds but the version with the default of 8 threads (no `num_threads` set) needed 16.7398 seconds.

```cpp
...
int main() {
  ...
#pragma omp parallel
  {
#pragma omp for
    for (int i = 0; i < num_steps; i++) {
      double x = (i + 0.5) * width;  // midpoint
#pragma omp atomic
      sum = sum + (1.0 / (1.0 + x * x));  // add new height of a rectangle
    }
  }
  ...
}
```

In contrast the version in week 1's coding warmup with reduction was an improvement over the baseline version.
Instead of `atomic`, the reductio gives each thread a private partial sum that OpenMP combines at the end:

```cpp
#pragma omp parallel for reduction(+ : sum)
for (int i = 0; i < num_steps; i++) {
  double x = (i + 0.5) * width;  // midpoint
  sum += 1.0 / (1.0 + x * x);    // add new height of a rectangle
}
```

With this, the run took about 0.06 seconds (8 threads), roughly 6 times faster than the serial version (about 0.35 seconds) and several hundred times faster than the `atomic` version.

---

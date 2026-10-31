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

---

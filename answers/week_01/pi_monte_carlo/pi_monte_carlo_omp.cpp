#include <omp.h>

#include <iostream>
#include <random>

using namespace std;

int main() {
  unsigned int seed = 0;

  uniform_real_distribution<double> zero_to_one{0.0, 1.0};

  int n = 100000000;  // number of points to generate
  int counter =
      0;  // counter for points lying in the first quadrant of a unit circle
  auto start_time =
      omp_get_wtime();  // omp_get_wtime() is an OpenMP library routine

#pragma omp parallel
  {
    int thread_id =
        omp_get_thread_num();  // thread id for local seed + start val
    int thread_num = omp_get_num_threads();  // number of threads for step size

    int local_counter = 0;  // local counter for each thread
    default_random_engine re{seed + thread_id};  // local re

    // compute n points and test if they lie within the first quadrant of a unit
    // circle
    for (int i = thread_id; i < n; i += thread_num) {
      auto x = zero_to_one(re);  // generate random number between 0.0 and 1.0
      auto y = zero_to_one(re);  // generate random number between 0.0 and 1.0
      if (x * x + y * y <=
          1.0) {  // if the point lies in the first quadrant of a unit circle

        ++local_counter;
      }
#pragma omp atomic
      counter += local_counter;  // add up local counters
    }
  }

  auto run_time = omp_get_wtime() - start_time;
  auto pi = 4 * (double(counter) / n);

  cout << "pi: " << pi << endl;
  cout << "run_time: " << run_time << " s" << endl;
  cout << "n: " << n << endl;
}

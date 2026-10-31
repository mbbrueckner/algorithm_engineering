#include <omp.h>

#include <iomanip>
#include <iostream>
#include <vector>

using namespace std;

int main() {
  int num_steps = 1000000000;              // number of rectangles
  double width = 1.0 / double(num_steps);  // width of a rectangle

  int max_num_threads = omp_get_max_threads();
  vector<double> local_sums(
      max_num_threads, 0.0);  // local sum vector, for every possible thread num

  double sum = 0.0;  // for summing up all heights of rectangles

  double start_time = omp_get_wtime();  // wall clock time in seconds
#pragma omp parallel
  {
    int num_threads = omp_get_num_threads();  // step size for loop
    int thread_id = omp_get_thread_num();     // start value for loop
    double& local_sum = local_sums[thread_id];
    for (int i = thread_id; i < num_steps; i += num_threads) {
      double x = (i + 0.5) * width;        // midpoint
      local_sum += (1.0 / (1.0 + x * x));  // add new height of a rectangle
    }
  }

  for (double ls : local_sums) sum += ls;

  double pi = sum * 4 * width;   // compute pi
  volatile double pi_sink = pi;  // keeps -Ofast from removing the loop
  double run_time = omp_get_wtime() - start_time;

  cout << setprecision(6) << run_time
       << " sec.";  // short output or comparison script

  // cout << "pi with " << num_steps << " steps is " << setprecision(17) << pi
  //      << " in " << setprecision(6) << run_time << " seconds\n";
}

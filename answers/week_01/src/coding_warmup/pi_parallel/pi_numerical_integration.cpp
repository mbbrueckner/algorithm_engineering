#include <omp.h>

#include <iomanip>
#include <iostream>

using namespace std;

int main() {
  int num_steps = 1000000000;              // number of rectangles
  double width = 1.0 / double(num_steps);  // width of a rectangle
  double sum = 0.0;  // for summing up all heights of rectangles

  double start_time = omp_get_wtime();  // wall clock time in seconds
  for (int i = 0; i < num_steps; i++) {
    double x = (i + 0.5) * width;       // midpoint
    sum = sum + (1.0 / (1.0 + x * x));  // add new height of a rectangle
  }
  double pi = sum * 4 * width;  // compute pi
  volatile double pi_sink = pi;  // keeps -Ofast from removing the loop
  double run_time = omp_get_wtime() - start_time;

  cout << setprecision(6) << run_time
       << " sec.";  // short output or comparison script

  // cout << "pi with " << num_steps << " steps is " << setprecision(17)
  //      << pi << " in " << setprecision(6) << run_time << " seconds\n";
}

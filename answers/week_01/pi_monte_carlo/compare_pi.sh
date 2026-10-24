#!/bin/bash

make clean && make all

BUILD_DIR="./build"
OUTPUT_FILE="comparison_results.txt"

{
  echo "Serial:         $($BUILD_DIR/pi_monte_carlo | grep run_time)"
  echo "Serial (Ofast): $($BUILD_DIR/pi_monte_carlo_ofast | grep run_time)"
  echo ""

  printf "%-8s %-25s %-25s %-25s %-25s\n" "Threads" "OpenMP" "OpenMP (Ofast)" "OpenMP v2" "OpenMP v2 (Ofast)"

  for threads in {1..8}; do
    omp=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_monte_carlo_omp | grep run_time)
    omp_ofast=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_monte_carlo_omp_ofast | grep run_time)
    omp_v2=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_monte_carlo_omp_v2 | grep run_time)
    omp_v2_ofast=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_monte_carlo_omp_ofast_v2 | grep run_time)
    printf "%-8d %-25s %-25s %-25s %-25s\n" "$threads" "$omp" "$omp_ofast" "$omp_v2" "$omp_v2_ofast"
  done
} | tee "$OUTPUT_FILE"

#!/bin/bash

make clean && make all

BUILD_DIR="./build"
OUTPUT_FILE="comparison_results.txt"

echo ""
{
  echo "Non-Parallel Benchmark"
  echo "======================="
  echo "Serial:  $($BUILD_DIR/pi_numerical_integration 2>&1 | tail -1)"
  echo "Serial (Ofast): $($BUILD_DIR/pi_numerical_integration_ofast 2>&1 | tail -1)"
  echo ""

  echo "Parallel Comparison (v1 vs v2 vs v3)"
  echo "===================================="
  echo ""

  printf "%-8s %-15s %-15s %-15s %-15s %-15s %-15s\n" \
    "Threads" "v1" "v1_ofast" "v2" "v2_ofast" "v3" "v3_ofast"
  printf "%-8s %-15s %-15s %-15s %-15s %-15s %-15s\n" \
    "-------" "---------------" "---------------" "---------------" "---------------" "---------------" "---------------"

  for threads in {1..8}; do
    v1_result=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v1 2>&1 | tail -1)
    v1_ofast_result=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v1_ofast 2>&1 | tail -1)
    v2_result=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v2 2>&1 | tail -1)
    v2_ofast_result=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v2_ofast 2>&1 | tail -1)
    v3_result=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v3 2>&1 | tail -1)
    v3_ofast_result=$(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v3_ofast 2>&1 | tail -1)

    printf "%-8d %-15s %-15s %-15s %-15s %-15s %-15s\n" \
      "$threads" "$v1_result" "$v1_ofast_result" "$v2_result" "$v2_ofast_result" "$v3_result" "$v3_ofast_result"
  done
} | tee "$OUTPUT_FILE"
#!/bin/bash

make clean && make all

BUILD_DIR="./build"

echo "Non-Parallel Benchmark"
echo "======================="
echo "Serial:  $($BUILD_DIR/pi_numerical_integration 2>&1 | tail -1)"
echo "Serial (Ofast): $($BUILD_DIR/pi_numerical_integration_ofast 2>&1 | tail -1)"
echo ""

echo "Parallel Comparison (v1 vs v2)"
echo "==============================="

for threads in {1..8}; do
  echo "Threads: $threads"
  echo "  v1:        $(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v1 2>&1 | tail -1)"
  echo "  v1_ofast:  $(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v1_ofast 2>&1 | tail -1)"
  echo "  v2:        $(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v2 2>&1 | tail -1)"
  echo "  v2_ofast:  $(OMP_NUM_THREADS=$threads $BUILD_DIR/pi_openmp_v2_ofast 2>&1 | tail -1)"
  echo ""
done

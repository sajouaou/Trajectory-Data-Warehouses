#!/bin/bash


for scalefactor in {0.005,0.05,0.2,1.0}
do
  echo $scalefactor
  ./berlinmod_runall.sh -s $scalefactor ;
  python3 benchmark_requests.py > "benchmark_${scalefactor}.txt";
done
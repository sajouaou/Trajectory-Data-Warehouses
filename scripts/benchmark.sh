#!/bin/bash

resultpath=../result

for scalefactor in {0.005,0.05,0.2,1.0}
do
  echo $scalefactor
  ./berlinmod_runall.sh -s $scalefactor
  ./run_request.sh > output.txt
  python3 benchmark_requests.py > "${resultpath}/benchmark_${scalefactor}.tex";
done
#!/bin/bash

./install_dependance.sh
git clone https://github.com/MobilityDB/MobilityDB
mkdir MobilityDB/build
cd MobilityDB/build
cmake ..
make
sudo make install
cd ../../
rm -r --force MobilityDB
./setup_postgresql.sh
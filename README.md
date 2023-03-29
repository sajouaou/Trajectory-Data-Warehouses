Trajectory Data Warehouses for MobilityDB
==================================

<img src="MobilityDB-BerlinMOD/doc/images/mobilitydb-logo.svg" width="200" alt="MobilityDB Logo" />

[MobilityDB](https://github.com/ULB-CoDE-WIT/MobilityDB) is an open source software program that adds support for temporal and spatio-temporal objects to the [PostgreSQL](https://www.postgresql.org/) database and its spatial extension [PostGIS](http://postgis.net/).
This repository contains code and the documentation for running an implementation of a Trajectory Data Warehouse into [MobilityDB](https://github.com/ULB-CoDE-WIT/MobilityDB) using [MobilityDB-BerlinMOD](https://github.com/MobilityDB/MobilityDB-BerlinMOD) to generate data.

Warning
-------------
In order to begin with this project you can configure our scripts (in the folder scripts of the repository) in order to be compliant 
with your internal configuration. Make sure to not let your password visible in deployment and change it. Here for an educational 
purpose passwords are simple but do not take those scripts as secure. 


How to use
-------------

As a requirement you need [MobilityDB-BerlinMOD](https://github.com/MobilityDB/MobilityDB-BerlinMOD).

#Data generation
In order to generate data with our conceptual model you can use this command with parameter s to define the scalefactor

* Change directory to the scripts one 
   cd scripts
* Run the scripts with a defined scalefactor (0.005 if not defined)
   ./berlinmod_runall.sh -s $scalefactor
#!/bin/bash

source ../../scripts/creditentials
sudo service postgresql start
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${password}';"
sudo service postgresql stop

#!/bin/bash
# A script to run the requests

source creditentials
scriptpath=../request
export PGPASSWORD=$password


for i in {1..7}
do
psql -h $host -p $port -U $dbowner -d $database -c '\timing' -f $scriptpath/${i}.sql > output${i}.txt
done

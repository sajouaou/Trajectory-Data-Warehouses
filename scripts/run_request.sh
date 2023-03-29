#!/bin/bash
# A script to run the requests

source creditentials
scriptpath=../request
export PGPASSWORD=$password


for i in {1..8}
do
psql -h $host -p $port -U $dbowner -d $database -c '\timing' -f $scriptpath/${i}.sql
done

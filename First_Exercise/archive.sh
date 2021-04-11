#!/bin/bash
gcc matrix.c -o matrix
mkdir -p time_files
echo 'Number;Time(s)' > time_files/c_ji_file.csv 
echo 'Number;Time(s)' > time_files/c_ij_file.csv
for value in $(python values_generator.py 38000 True)
do
    echo $(./matrix $value false) >> time_files/c_ji_file.csv
    echo $(./matrix $value true) >> time_files/c_ij_file.csv
done
rm matrix
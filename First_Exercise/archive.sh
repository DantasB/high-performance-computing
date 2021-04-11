#!/bin/bash

TIME_DIR=time_files
IMAGE_DIR=image_files
IJ_FILENAME=ij
JI_FILENAME=ji
IMAGE_FILENAME=matrix

C_IJ_PATH=$TIME_DIR/C/$IJ_FILENAME.csv
C_JI_PATH=$TIME_DIR/C/$JI_FILENAME.csv
C_IMAGE_PATH=$IMAGE_DIR/C/$IMAGE_FILENAME.png

F_IJ_PATH=$TIME_DIR/Fortran/$IJ_FILENAME.csv
F_JI_PATH=$TIME_DIR/Fortran/$JI_FILENAME.csv
F_IMAGE_PATH=$IMAGE_DIR/Fortran/$IMAGE_FILENAME.png

mkdir -p $TIME_DIR/C
mkdir -p $TIME_DIR/Fortran
mkdir -p $IMAGE_DIR/C
mkdir -p $IMAGE_DIR/Fortran


echo 'Number;Time(s)' > $C_IJ_PATH
echo 'Number;Time(s)' > $C_JI_PATH
echo 'Number;Time(s)' > $F_IJ_PATH
echo 'Number;Time(s)' > $F_JI_PATH

gcc c_files/matrix.c -o matrix
for value in $(python python_files/values_generator.py 38000 True)
do
    echo $(./matrix $value true) >> $C_IJ_PATH 
    echo $(./matrix $value false) >> $C_JI_PATH 
done
rm matrix

echo $(python python_files/graph_generator.py $C_IMAGE_PATH $C_IJ_PATH $C_JI_PATH)

gfortran fortran_files/matrix.f95 -o matrix
for value in $(python python_files/values_generator.py 38000 True)
do
    echo $(./matrix $value 1) >> $F_IJ_PATH 
    echo $(./matrix $value 0) >> $F_JI_PATH 
done
rm matrix

echo $(python python_files/graph_generator.py $F_IMAGE_PATH $F_IJ_PATH $F_JI_PATH)

rm -rf $TIME_DIR
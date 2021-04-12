#!/bin/bash

TIME_DIR=time_files
IMAGE_DIR=image_files
IJ_FILENAME=external_i
JI_FILENAME=external_j
IMAGE_FILENAME=matrix

C_IJ_PATH=$TIME_DIR/C/$IJ_FILENAME.csv
C_JI_PATH=$TIME_DIR/C/$JI_FILENAME.csv
C_IMAGE_PATH=$IMAGE_DIR/C/$IMAGE_FILENAME.png

F_IJ_PATH=$TIME_DIR/Fortran/$IJ_FILENAME.csv
F_JI_PATH=$TIME_DIR/Fortran/$JI_FILENAME.csv
F_IMAGE_PATH=$IMAGE_DIR/Fortran/$IMAGE_FILENAME.png

#Initializing directories
mkdir -p $TIME_DIR/C
mkdir -p $IMAGE_DIR/C
mkdir -p $TIME_DIR/Fortran
mkdir -p $IMAGE_DIR/Fortran

#Initializing csv files
echo 'Number;Time(s)' > $C_IJ_PATH
echo 'Number;Time(s)' > $C_JI_PATH
echo 'Number;Time(s)' > $F_IJ_PATH
echo 'Number;Time(s)' > $F_JI_PATH

#Generating CSV Files
echo 'Generating CSV Files'

gcc c_files/matrix.c -o c_matrix
gfortran fortran_files/matrix.f95 -o fortran_matrix
for value in $(python python_files/values_generator.py 38000 True)
do
    echo $(./c_matrix $value 1) >> $C_IJ_PATH 
    echo $(./c_matrix $value 0) >> $C_JI_PATH 
    echo $(./fortran_matrix $value 1) >> $F_IJ_PATH 
    echo $(./fortran_matrix $value 0) >> $F_JI_PATH 
done

#Generating Graph images
echo $(python python_files/graph_generator.py $C_IMAGE_PATH $C_IJ_PATH $C_JI_PATH)
echo $(python python_files/graph_generator.py $F_IMAGE_PATH $F_IJ_PATH $F_JI_PATH)

#Removing unnecessary files
rm c_matrix
rm fortran_matrix
rm -rf $TIME_DIR
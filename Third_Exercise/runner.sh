export OMP_NUM_THREADS=2

CPP_DIR=cpp_files
INPUT_DIR=input_file
BASE_PROGRAM=laplace.cxx
OPTIMIZED_PROGRAM=laplace_openmp.cxx
INPUT_FILE=input.txt
EXECUTOR=runner

BASE_PROGRAM_PATH=$CPP_DIR/$BASE_PROGRAM
OPTIMIZED_PROGRAM_PATH=$CPP_DIR/$OPTIMIZED_PROGRAM
INPUT_PATH=$INPUT_DIR/$INPUT_FILE

#g++ $BASE_PROGRAM_PATH  -o $EXECUTOR 
g++ $OPTIMIZED_PROGRAM_PATH -fopenmp -o $EXECUTOR 
for counter in {1..6};
do
    export OMP_NUM_THREADS=$counter
    for nx in 512 1024 2048;
    do
        mkdir -p $INPUT_DIR
        echo $nx 1000 0.000000000000001 > $INPUT_PATH
        echo $(./$EXECUTOR < $INPUT_PATH)
        rm $INPUT_PATH
    done
done

rm $EXECUTOR
rmdir $INPUT_DIR
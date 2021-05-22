export OMP_NUM_THREADS=2

CPP_DIR=cpp_files
INPUT_DIR=input_file
PROGRAM=laplace_openmp.cxx
INPUT_FILE=input.txt
EXECUTOR=runner
PROGRAM_PATH=$CPP_DIR/$PROGRAM
INPUT_PATH=$INPUT_DIR/$INPUT_FILE

g++ $PROGRAM_PATH -fopenmp -o $EXECUTOR 
for counter in {1..6};
do
    export OMP_NUM_THREADS=$counter
    for nx in 512 1024 2048;
    do
        mkdir -p $INPUT_DIR
        echo $nx 1000 0.00000000000000001 > $INPUT_PATH
        echo $(./$EXECUTOR < $INPUT_PATH)
        rm $INPUT_PATH
    done
done

rm $EXECUTOR

INPUT_DIR=input_file
INPUT_FILE=input.txt

OUTPUT_DIR=output_file
OUTPUT_FILE=output.csv

CPP_DIR=cpp_files
BASE_PROGRAM=laplace.cxx
OPTIMIZED_PROGRAM=laplace_openmp.cxx

EXECUTOR=runner

BASE_PROGRAM_PATH=$CPP_DIR/$BASE_PROGRAM
OPTIMIZED_PROGRAM_PATH=$CPP_DIR/$OPTIMIZED_PROGRAM
INPUT_PATH=$INPUT_DIR/$INPUT_FILE
OUTPUT_PATH=$OUTPUT_DIR/$OUTPUT_FILE

mkdir -p $INPUT_DIR
mkdir -p $OUTPUT_DIR

MAX_THREADS=$(python -c "import psutil; print(psutil.cpu_count(logical=True))")

echo 'Result;Nx;Time(s);Flags;Thread(s)' > $OUTPUT_PATH

echo "Starting the base program without flags"
g++ $BASE_PROGRAM_PATH -o $EXECUTOR 
for nx in 512 1024 2048;
do
    echo $nx 1000 0.000000000000001 "None" > $INPUT_PATH
    echo $(./$EXECUTOR < $INPUT_PATH >> $OUTPUT_PATH) "Nx used was $nx"
done

echo "Starting the base program with O3 flag"
g++ $BASE_PROGRAM_PATH -O3 -o $EXECUTOR
for nx in 512 1024 2048;
do
    echo $nx 1000 0.000000000000001 "O3" > $INPUT_PATH
    echo $(./$EXECUTOR < $INPUT_PATH >> $OUTPUT_PATH) "Nx used was $nx"
done

echo "Starting the openmp program without flags"
g++ $OPTIMIZED_PROGRAM_PATH -fopenmp -o $EXECUTOR 
for counter in $(seq 1 $MAX_THREADS);
do
    echo "Actual number of used threads is $counter"
    export OMP_NUM_THREADS=$counter
    for nx in 512 1024 2048;
    do
        echo $nx 1000 0.000000000000001 "fopenmp" > $INPUT_PATH
        echo $(./$EXECUTOR < $INPUT_PATH >> $OUTPUT_PATH) "Nx used was $nx"
    done
done

echo "Starting the openmp program with O3 flag"
g++ $OPTIMIZED_PROGRAM_PATH -O3 -fopenmp -o $EXECUTOR 
for counter in $(seq 1 $MAX_THREADS);
do
    echo "Actual number of used threads is $counter"
    export OMP_NUM_THREADS=$counter
    for nx in 512 1024 2048;
    do
        echo $nx 1000 0.000000000000001 "O3 and fopenmp" > $INPUT_PATH
        echo $(./$EXECUTOR < $INPUT_PATH >> $OUTPUT_PATH) "Nx used was $nx"
    done
done

rm $EXECUTOR
rmdir $INPUT_DIR
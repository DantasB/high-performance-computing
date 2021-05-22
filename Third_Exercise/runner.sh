INPUT_DIR=input_file
INPUT_FILE=input.txt

CPP_DIR=cpp_files
BASE_PROGRAM=laplace.cxx
OPTIMIZED_PROGRAM=laplace_openmp.cxx

OUTPUT_DIR=output_files
EXECUTOR=runner

BASE_PROGRAM_PATH=$CPP_DIR/$BASE_PROGRAM
OPTIMIZED_PROGRAM_PATH=$CPP_DIR/$OPTIMIZED_PROGRAM
INPUT_PATH=$INPUT_DIR/$INPUT_FILE

MAX_THREADS=$(python -c "import psutil; print(psutil.cpu_count(logical=True))")

g++ $BASE_PROGRAM_PATH -o $EXECUTOR 
THREAD_DIR=$OUTPUT_DIR/BASE/
mkdir -p $THREAD_DIR
for nx in 512 1024 2048;
do
    mkdir -p $INPUT_DIR
    echo $nx 1000 0.000000000000001 > $INPUT_PATH
    echo $(./$EXECUTOR < $INPUT_PATH > $THREAD_DIR/${nx}".txt")
    rm $INPUT_PATH
done

g++ $BASE_PROGRAM_PATH -O3 -o $EXECUTOR
THREAD_DIR=$OUTPUT_DIR/BASE_O3/
mkdir -p $THREAD_DIR
for nx in 512 1024 2048;
do
    mkdir -p $INPUT_DIR
    echo $nx 1000 0.000000000000001 > $INPUT_PATH
    echo $(./$EXECUTOR < $INPUT_PATH > $THREAD_DIR/${nx}".txt")
    rm $INPUT_PATH
done

g++ $OPTIMIZED_PROGRAM_PATH -fopenmp -o $EXECUTOR 
for counter in $(seq 1 $MAX_THREADS);
do
    THREAD_DIR=$OUTPUT_DIR/OPENMP/${counter}"_thread(s)"
    mkdir -p $THREAD_DIR
    export OMP_NUM_THREADS=$counter
    for nx in 512 1024 2048;
    do
        mkdir -p $INPUT_DIR
        echo $nx 1000 0.000000000000001 > $INPUT_PATH
        echo $(./$EXECUTOR < $INPUT_PATH > $THREAD_DIR/${nx}".txt")
        rm $INPUT_PATH
    done
done

g++ $OPTIMIZED_PROGRAM_PATH -O3 -fopenmp -o $EXECUTOR 
for counter in $(seq 1 $MAX_THREADS);
do
    THREAD_DIR=$OUTPUT_DIR/"OPENMP_O3"/${counter}"_thread(s)"
    mkdir -p $THREAD_DIR
    export OMP_NUM_THREADS=$counter
    for nx in 512 1024 2048;
    do
        mkdir -p $INPUT_DIR
        echo $nx 1000 0.000000000000001 > $INPUT_PATH
        echo $(./$EXECUTOR < $INPUT_PATH > $THREAD_DIR/${nx}".txt")
        rm $INPUT_PATH
    done
done

rm $EXECUTOR
rmdir $INPUT_DIR
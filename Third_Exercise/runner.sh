export OMP_NUM_THREADS=2

CPP_PATH=cpp_files
PROGRAM=laplace_openmp.cxx
EXECUTOR=runner
PROGRAM_PATH=$CPP_PATH/$PROGRAM


g++ $PROGRAM_PATH -fopenmp -o $EXECUTOR 
for counter in {1..6};
do
    export OMP_NUM_THREADS=$counter
    echo $(./$EXECUTOR)
done

rm $EXECUTOR

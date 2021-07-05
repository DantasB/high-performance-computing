#!/bin/bash

if [ -d "HPL-test/" ] 
then
    echo $(rm -rf HPL-test/)
fi

git clone https://github.com/jvencels/HPL-test

cd HPL-test/

INPUT_FILE=HPL.dat
OUTPUT_DIR=output
FINAL_OUTPUT=result
MAX_THREADS=$(python -c "import psutil; print(psutil.cpu_count(logical=False))")
P_ARRAY=(1 2)
Q_ARRAY=($MAX_THREADS $(($MAX_THREADS / 2)) )

mkdir -p $OUTPUT_DIR 

for nbs in 32 64 128 256;
do
	for index in 0 1;
	do
		for pmap in 0 1;
		do
			for pfacts in 0 1 2;
			do
				echo "Current Parameters:"
				echo "nbs    = $nbs;"
				echo "P      = ${P_ARRAY[$index]};"
				echo "Q      = ${P_ARRAY[$index]};"
				echo "PMAP   = $pmap;"
				echo "PFACTS = $pfacts;"

				OUTPUT_FILE="$OUTPUT_DIR/NBS=$nbs:P=${P_ARRAY[$index]}:Q=${Q_ARRAY[$index]}:PMAP=$pmap:PFACTS=$pfacts.out"

				echo 'HPLinpack benchmark input file' > $INPUT_FILE
				echo 'Innovative Computing Laboratory, University of Tennessee'>> $INPUT_FILE
				echo 'HPL.out      output file name (if any)'>> $INPUT_FILE
				echo '6            device out (6=stdout,7=stderr,file)'>> $INPUT_FILE
				echo '1            # of problems sizes (N)'>> $INPUT_FILE
				echo '14464        Ns'>> $INPUT_FILE
				echo '1            # of NBs'>> $INPUT_FILE
				echo "$nbs NBs"	>> $INPUT_FILE
				echo "$pmap            PMAP process mapping (0=Row-,1=Column-major)" >> $INPUT_FILE
				echo '1            # of process grids (P x Q)'>> $INPUT_FILE
				echo "${P_ARRAY[$index]}            Ps">> $INPUT_FILE
				echo "${Q_ARRAY[$index]}            Qs">> $INPUT_FILE
				echo '16.0         threshold'>> $INPUT_FILE
				echo '1            # of panel fact'>> $INPUT_FILE
				echo "$pfacts            PFACTs (0=left, 1=Crout, 2=Right)">> $INPUT_FILE
				echo '1            # of recursive stopping criterium'>> $INPUT_FILE
				echo '4            NBMINs (>= 1)'>> $INPUT_FILE
				echo '1            # of panels in recursion'>> $INPUT_FILE
				echo '2            NDIVs'>> $INPUT_FILE
				echo '1            # of recursive panel fact.'>> $INPUT_FILE
				echo '1            RFACTs (0=left, 1=Crout, 2=Right)'>> $INPUT_FILE
				echo '1            # of broadcast'>> $INPUT_FILE
				echo '1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)'>> $INPUT_FILE
				echo '1            # of lookahead depth'>> $INPUT_FILE
				echo '1            DEPTHs (>=0)'>> $INPUT_FILE
				echo '2            SWAP (0=bin-exch,1=long,2=mix)'>> $INPUT_FILE
				echo '64           swapping threshold'>> $INPUT_FILE
				echo '0            L1 in (0=transposed,1=no-transposed) form'>> $INPUT_FILE
				echo '0            U  in (0=transposed,1=no-transposed) form'>> $INPUT_FILE
				echo '1            Equilibration (0=no,1=yes)'>> $INPUT_FILE
				echo '8            memory alignment in double (> 0)'>> $INPUT_FILE
				echo '##### This line (no. 32) is ignored (it serves as a separator). ######'>> $INPUT_FILE
				echo '0                               Number of additional problem sizes for PTRANS'>> $INPUT_FILE
				echo '1200 10000 30000                values of N'>> $INPUT_FILE
				echo '0                               number of additional blocking sizes for PTRANS'>> $INPUT_FILE
				echo '40 9 8 13 13 20 16 32 64        values of NB'>> $INPUT_FILE
				
				echo $(docker run -v ${PWD}:/usr/local/hpl-2.2/HPLtest ashael/hpl HPLtest/run.sh -n $MAX_THREADS -t 3) > tmp.out
				echo $(cp log.out $OUTPUT_FILE)

				echo 'Finished writing the output file.'
			done
		done
	done
done

cd output/ && ls | xargs grep -e 'e+' | cut -d' ' -f1,48-52 > ../../$FINAL_OUTPUT.txt

cd ../../ && rm -rf HPL-test/

echo 'Starting the file treatment'

python python_files/grep_parser.py $FINAL_OUTPUT.txt >> $FINAL_OUTPUT.csv

echo 'File treatment finished'

rm $FINAL_OUTPUT.txt

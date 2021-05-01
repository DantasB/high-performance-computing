# Second Exercise

![demonstration](https://cdn.discordapp.com/attachments/539836343094870016/838093576582856724/unknown.png)

## Table of Contents

<!--ts-->

- [About](#about)
- [Requirements](#requirements)
- [How to use](#how-to-use)
  - [Setting up Program](#program-setup)
  - [Interpreting the Results](#interpreting-results)
- [Technologies](#technologies)
<!--te-->

## About

This repository is a study about High Computing Performance, where i was developing a project for an UFRJ class, where i also studied Fortran and how to develop a bash script.

In this exercise i've learned how to use the gprof and about some code optimizations.

## Requirements

To run this repository by yourself you will need to install the gcc compiler in your machine to run the code bellow.

## How to use

### Program Setup

```bash
# Clone this repository
$ git clone <https://github.com/DantasB/Computacao-de-Alto-Desempenho>

# Access the project page on your terminal
$ cd Computacao-de-Alto-Desempenho/Second_Exercise/

# Compile the c++ code using the pg flag
$ g++ -pg laplace.cxx -o laplace

# Execute the laplace code
$ ./laplace

# Use the following parameters: 500 100 0.000000000000001
Enter nx n_iter eps --> 500 100 0.000000000000001

# The code execution will generate a gmon.out archive. Now execute gprof
$ gprof laplace gmon.out > output.txt

# The profiler will run and store it in the output.txt file.
```

![demonstration](https://cdn.discordapp.com/attachments/539836343094870016/838092024472272936/unknown.png)

### Interpreting Results

The code in this repository is not in the optimal way. You will need to figure out how to optimize and them decrease the execution time of it.

In the [answers](https://github.com/DantasB/High-Performance-Computing/blob/main/Second_Exercise/Respostas.pdf) you will find some of the optimizations that i made.

I've also included the gprof archive of the 2 codes [main](https://github.com/DantasB/High-Performance-Computing/blob/main/Second_Exercise/main_code.txt) and [refactored](https://github.com/DantasB/High-Performance-Computing/blob/main/Second_Exercise/refactored_code.txt) containing all the gprof output for those 2 executions.

## Technologies

- C++
- gprof

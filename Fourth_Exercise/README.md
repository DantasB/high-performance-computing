# Fourth Exercise

![demonstration](https://cdn.discordapp.com/attachments/539836343094870016/855296126223777792/unknown.png)

## Table of Contents

<!--ts-->
   * [About](#about)
   * [Requirements](#requirements)
   * [How to use](#how-to-use)
      * [Setting up Program](#program-setup)
   * [Technologies](#technologies)
<!--te-->

## About

This repository is a study about High Computing Performance, where i was developing a project for an UFRJ class, where i've learn how to run a benchmark and more about bash scripts.

## Requirements

To run this repository by yourself you will need to install python3 in your machine.

Also you will need to have docker on your machine to run the benchmark correctly.

## How to use

### Program Setup

```bash
# Clone this repository
$ git clone <https://github.com/DantasB/Computacao-de-Alto-Desempenho>

# Access the project page on your terminal
$ cd Computacao-de-Alto-Desempenho/Fourth_Exercise/

# Clone the benchmark docker repository
$ git clone <https://github.com/jvencels/HPL-test>

# Move the runner.sh to to the HPL-test directory
$ cp runner.sh HPL-test/

# Access the HPL directory on your terminal
$ cd HPL-test/

# Set the bash script permission to executable
$ chmod +x runner

# Execute the main program
$ ./runner.sh

# The code will start and them you will generate a single file with all GFLOPS measured by the benchmark 
```
![demonstration](https://cdn.discordapp.com/attachments/539836343094870016/855297429423521802/unknown.png)


## Technologies

* Bash
* Docker
# Fifth Exercise

![demonstration](https://cdn.discordapp.com/attachments/539836343094870016/888202854890868757/unknown.png)

## Table of Contents

<!--ts-->
   * [About](#about)
   * [Requirements](#requirements)
   * [How to use](#how-to-use)
      * [Setting up Program](#program-setup)
      * [Performance Analysis](#performance-analysis)
   * [Technologies](#technologies)
<!--te-->

## About

This repository is a study about High Computing Performance, where i was developing a project for an UFRJ class, where i've learn how to build a roofline graph and its importance for a code. You can see more information about this project in the [Tutorial](Tutorial.pdf) file

## Requirements

To run this repository by yourself you will need to install the [roofline toolkit](https://bitbucket.org/berkeleylab/cs-roofline-toolkit/src/master/),collect your application performance using SDE, VTune, LIKWID, Advisor, or any other application and gnuplot.


## How to use

### Program Setup

```bash
# Clone this repository
$ git clone <https://github.com/DantasB/Computacao-de-Alto-Desempenho>

# Access the project page on your terminal
$ cd Computacao-de-Alto-Desempenho/Fifth_Exercise/

# Clone the ert project from the bitbucket url
$ git clone https://bitbucket.org/berkeleylab/cs-roofline-toolkit/src/master/

# Access the ERT-1.1.0 directory
$ cd cs-roofline-toolkit/Empirical_Roofline_Tool-1.1.0

# Run the ert code using the config file in the Fifth_Exercise folder
$ ./ert ../../Config/config.modified

# The code will start and them you will generate a a folder containing a .pd archive with the roofline result
```
![demonstration](https://cdn.discordapp.com/attachments/539836343094870016/888207845764501544/unknown.png)


### Performance Analysis

To run the performance analysis i've downloaded the VTune profiler to help me during the code analysis. The [memory-consumption](https://cdn.discordapp.com/attachments/539836343094870016/888207845764501544/unknown.png) image contains some information about the memory consumption of this code.

## Technologies

* Python
* C
* C++

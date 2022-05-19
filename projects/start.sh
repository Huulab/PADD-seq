#!/bin/bash
#Usage: bash ./Smlist.sh && bash main.sh <snakefile> <cores> 1>main.log 2>&1

bash ./Smlist.sh && bash main.sh main.snakefile 10 1>main.log 2>&1


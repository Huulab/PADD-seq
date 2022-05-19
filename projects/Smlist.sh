#!/bin/bash
ls ./fastq |grep Sample|while read id;do echo ${id##*_} ;done > ./conf/sm.list

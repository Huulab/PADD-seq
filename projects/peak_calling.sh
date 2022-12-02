#!/bin/bash
macs2 callpeak -t ../../Bed/R22048397-ZYC220927-A549H3k9aCis90C1_Final_center_sequence.bed \
-c ../../Bed/R22048397-ZYC220927-A549H3k9aCis90I1_Final_center_sequence.bed \
-g hs -p 0.01 -n A549H3k9aCis90C1 --nomodel -f BED -B --SPMR >> R22048397-ZYC220927-A549H3k9aCis90C1.log 2>&1

macs2 callpeak -t ../../Bed/R22048397-ZYC220927-A549H3k9aCis90C2_Final_center_sequence.bed \
-c ../../Bed/R22048397-ZYC220927-A549H3k9aCis90I2_Final_center_sequence.bed \
-g hs -p 0.01 -n A549H3k9aCis90C2 --nomodel -f BED -B --SPMR >> R22048397-ZYC220927-A549H3k9aCis90C2.log 2>&1

macs2 callpeak -t ../../Bed/R22047893-ZYC220924-A549H3k9aCis90P1_GGAG.bed \
-c ../../Bed/R22048397-ZYC220927-A549H3k9aCis90I1_Final_center_sequence.bed \
-g hs -p 0.01 -n A549H3k9aCis90P1 --nomodel -f BED -B --SPMR >> R22048397-ZYC220927-A549H3k9aCis90P1.log 2>&1

macs2 callpeak -t ../../Bed/R22047893-ZYC220924-A549H3k9aCis90P2_GGAG.bed \
-c ../../Bed/R22048397-ZYC220927-A549H3k9aCis90I2_Final_center_sequence.bed \
-g hs -p 0.01 -n A549H3k9aCis90P2 --nomodel -f BED -B --SPMR >> R22048397-ZYC220927-A549H3k9aCis90P2.log 2>&1

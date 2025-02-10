#!/bin/csh -f

cd /home/szaynutd/Desktop/chipdevio_questions/edge_detector

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/usr/caen/vcs-2022.06/linux64/bin/vcselab $* \
    -o \
    sim \
    -nobanner \
    +vcs+lic+wait \

cd -


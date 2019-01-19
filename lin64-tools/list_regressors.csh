#!/bin/csh

if ($#argv < 1) exit
if (! -e $1) exit
@ ncol = `cat $1 | awk 'NR==1{print NF}'`
echo $1 $ncol | awk '{printf("%-40s %3d regressors\n", $1, $2)}'

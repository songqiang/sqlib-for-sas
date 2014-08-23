#! /bin/bash
#
# search for macro or macro variable definitions
# Song, Qiang <keeyang@ustc.edy> 2014 
#

if [ $# == 0 ];
then
    echo "Usage: findmac macro_name <dir>";
elif [ $# == 1 ];
then
    macname=$1;
    wd=;
else
    macname=$1;
    wd=$2;
fi

egrep --line-number --color \
    --recursive --include=\*.{sas,mac,inc} \
    --ignore-case "%macro[ \t]+$macname" $wd;

if [ $? -ne 0 ];
then
    egrep --line-number --color \
        --recursive --include=\*.{sas,mac,inc} \
        --ignore-case "%let[ \t]+$macname[ \t]*=" $wd;
fi

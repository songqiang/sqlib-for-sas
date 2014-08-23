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

found=$(egrep --line-number --color \
    --recursive --include=\*.{sas,mac,inc} \
    --ignore-case "%macro[ \t]+$macname" $wd);

if [ -n "$found" ];
then
    echo $found;
    f=$(echo $found|cut -f1 -d:);
    cat $f|awk 'BEGIN {IGNORECASE = 1;} /%macro[ \t]+'$macname'/,/%mend/ {print $0;}';
fi
    
if [ -z "$found" ];
then
    found=$(egrep --line-number --color \
        --recursive --include=\*.{sas,mac,inc} \
        --ignore-case "%let[ \t]+$macname" $wd);
fi

if [ -n "$found" ];
then
    echo $found;
    f=$(echo $found|cut -f1 -d:);
    cat $f|awk 'BEGIN {IGNORECASE = 1;} /%let[ \t]+'$macname'/,/;/ {print $0;}';
fi



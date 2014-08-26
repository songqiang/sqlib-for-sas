#! /bin/bash
#
# search for error and warning messages from SAS log
# Song, Qiang <keeyang@ustc.edu> 2014
#
# with valuable inputs from Andre de Souza: http://pages.stern.nyu.edu/~adesouza/sasfinphd/index/node77.html

if [ $# == 0 ];
then
    echo "Usage: saslogparser.sh logfile";
    exit 0;
fi

egrep --color --line-number --ignore-case \
    -e "ERROR" \
    -e "WARNING" \
    -e "invalid" \
    -e "uninitialized" \
    -e "not found" \
    -e "overwrit" \
    -e "no observations" \
    -e "has more than one data set with" \
    -e "have been converted" \
    -e "went to a new line" \
    -e "Missing values were generated" \
    -e "operation on missing values" \
    -e "never been referenced" \
    -e "has 0 observations" \
    -e "out of proper order" \
    -e "format was too small" \
    -e "truncated to" \
    -e "LOST CARD" \
    -e "not executed" \
    -e "Multiple lengths were specified" \
    -e "Division by zero" \
    -e "stopped due to looping" \
    $1;
    

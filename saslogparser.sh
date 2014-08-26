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

grep --color --line-number --ignore-case \
    "\(ERROR\|WARNING\|uninitialized\|not found\|overwritten\|no observations\|has more than one data set with\|have been converted\)" \
    $1;
    

    


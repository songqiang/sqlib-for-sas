#! /bin/bash
#
# search for error and warning messages from SAS log
# Song, Qiang <keeyang@ustc.edu> 2014
#
# with valuable inputs from Andre de Souza: http://pages.stern.nyu.edu/~adesouza/sasfinphd/index/node77.html


function show_help
{
    echo 'Usage: saslogparser logfile
        -f print input/out file and dataset flowchart
        -h print this help message
'
}

function highlight_err_warnings # logfile
{
    logfile=$1;
    egrep --color --line-number --ignore-case \
        -e "ERROR" \
        -e "WARNING" \
        -e "invalid" \
        -e "uninitialized" \
        -e "not found" \
        -e "not resolved" \
        -e "overwrit" \
        -e "no observations" \
        -e "has more than one data set with" \
        -e "have been converted" \
        -e "went to a new line" \
        -e "Missing values were generated" \
        -e "operation on missing values" \
        -e "have been set to missing values" \
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
        -e "was not long enough" \
        -e "has the same name as" \
        $logfile;
}        
    
function io_flowchart # logfile
{
    logfile=$1;
    egrep --color --ignore-case $logfile \
        -e "records were read from" \
        -e "records were written to" \
        -e "There were [0-9]+ observations read from the dataset" \
        -e "The data set [^ ]+ has [0-9]+ observations and [0-9]+ variables" \
        -e "Total process time" \
        |sed '/Total process time/a "--------------------------------"';
}



if [ $# == 0 ];
then
    echo "Usage: saslogparser.sh logfile";
    exit 0;
fi

IO_FLOWCHART_WANTED="N";
OPTIND=1;
while getopts "hf" opt;
do
    case "$opt" in
        h)
            show_help;
            exit 0;
            ;;
        f) 
            IO_FLOWCHART_WANTED="Y";
            ;;
    esac
done

logfile=$1

highlight_err_warnings $logfile
if [ "$IO_FLOWCHART_WANTED" == "Y" ];
then
    io_flowchart $logfile
fi


#! /bin/bash
#
# search for error and warning messages from SAS log
# Song, Qiang <keeyang@ustc.edu> 2014
#
# with valuable inputs from Andre de Souza: http://pages.stern.nyu.edu/~adesouza/sasfinphd/index/node77.html

function show_help
{
echo '
Usage: saslogparser.sh [-f] logfile
    -f output input/output file/dataset flowchrt
    -t output time use report
    -h print this help message
'
}

function io_flowchart # logfile
{
    logfile=$1;
     egrep --color --ignore-case $logfile \
         -e "There were.*observations read from" \
         -e "The data set .* has [0-9]+ observations" \
         -e "Total process time" \
         -e "records were read from the infile" \
         -e "records were written to" \
         -e "were written to file" \
         |sed '/^.*Total process time.*/a ---------------------------'
}

function session_time_report # logfile
{
    logfile=$1;
    grep  "\(process time\|real time\|SAS initialization used\|The SAS System used\)" $logfile
}


function highlight_err_warnings # lgofile
{
    logfile=$1;
    egrep --invert-match --line-number $logfile \
        -e "^[0-9]+" \
        -e "^MPRINT" \
        -e "^MLOGIC" \
        -e "^SYMBOLGEN" \
        -e "^NOTE: .*Training error=" \
        -e "^NOTE: .*Average Error for target" \
      |egrep --color  --ignore-case  \
        -e "ERROR" \
        -e "WARNING" \
        -e "invalid" \
        -e "Syntax error" \
        -e "uninitialized" \
        -e "not found" \
        -e "not resolved" \
        -e "not assigned" \
        -e "overwrit" \
        -e "no observations" \
        -e "has more than one data set with" \
        -e "have been converted" \
        -e "went to a new line" \
        -e "out of range" \
        -e "Missing values were generated" \
        -e "operation on missing values" \
        -e "operations could not be performed" \
        -e "have been set to missing values" \
        -e "never been referenced" \
        -e "has 0 observations" \
        -e " 0 variables" \
        -e "out of proper order" \
        -e "format was too small" \
        -e "truncated to" \
        -e "LOST CARD" \
        -e "not executed" \
        -e "Multiple lengths were specified" \
        -e "Division by zero" \
        -e "stopped due to looping" \
        -e "was not long enough" \
        -e "exceeded record length" \
        -e "has the same name as" \
        -e "does not exist" \
        -e "might change in a future SAS release" \
        -e "is not the same type" \
        -e "do not comply with integrity constraint" \
        -e "failed while attempting to" \
        -e "misspelled as";
}

# main program

if [ $# == 0 ];
then
    show_help;
    exit 0;
fi

IO_FLOWCHART_WANTED="N";
TIMEREPORT_WANTED="N";
OPTIND=1;
while getopts "hft" opt;
do
    case "$opt" in
        h)
            show_help;
            exit 0;
            ;;
        f)
            IO_FLOWCHART_WANTED="Y";
            shift;
            ;;
        t)
            TIMEREPORT_WANTED="Y";
            shift;
            ;;
    esac
done

logfile=$1
highlight_err_warnings $logfile

if [ "$IO_FLOWCHART_WANTED" == "Y" ];
then
    io_flowchart $logfile
fi

if [ "$TIMEREPORT_WANTED" == "Y" ];
then
    session_time_report $logfile
fi




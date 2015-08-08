/*
 * Utility Macros for SAS Programming
 * Song Qiang <keeyang@ustc.edu> 2015
 *
 */

%macro assert(__cond__);
    if not(%str(__cond__)) then do;
        error "ERROR: assertion failed: &__cond__";
    end;
%mend assert;


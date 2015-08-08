/*
 * Utility Macros for SAS Programming
 * Song Qiang <keeyang@ustc.edu> 2015
 *
 */

%macro assertAlmostEqual(lhs, rhs);
    if not(round(%str(&lhs) - %str(&rhs), 0.000001) = 0) then do;
        error "ERROR: assertion failed: &lhs almost equal &rhs";
    end;
%mend assertAlmostEqual;


/*
 * Utility Macros for SAS Programming
 * Song Qiang <keeyang@ustc.edu> 2016
 *
 */

%macro print_percentiles(dsn = , vars = , percentiles = 0 to 100 by 5);
/* print detailed percentile report for numeric variables in an SAS dataset */

%if %str(&vars) eq %then %do;
    proc contents noprint
        data = &dsn
        out = _print_percentiles_var_list(keep = name varnum type);
    run;

    proc sql noprint;
        select name into :vars separated by ' '
        from _print_percentiles_var_list
        where type = 1;

        drop table _print_percentiles_var_list;
    quit;
%end;

%local n i v;
%let n = %sysfunc(countw(&vars));

%do i = 1 %to &n;
    %let v = %scan(&vars, &i);

    proc univariate noprint
        data = &dsn(keep = &v);
        var &v;
        output out = pctls pctlpre= PCT_ pctlpts = &percentiles;
    run;

    proc transpose data = pctls out = pctls;

    proc print label data = pctls;
        var _name_ COL1;
        label _name_ = 'Percentiles';
        label COL1 = "&v";
    run;
%end;

%mend;

/*
 * Macro to assign the result of arbitrary experssion to a macro variable
 * avoid using cumbersome %eval, %sysfunc, %sysevalf for such purposes 
 * Song Qiang <keeyang@ustc.edu> 2014
 */
 
%macro assign_macvar(___var___, ___val___, scope = F);
    data _null_;
        call symputx("&___var___", &___val___, "&scope");
        stop;
    run;
%mend;

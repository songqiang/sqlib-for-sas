/*
 * Utility Macros for SAS Programming
 * Song Qiang <keeyang@ustc.edu> 2015
 *
 */

%macro apply_template(__lst__, __templ__);
    %local _i_ _n_;
    %let _n_ = %sysfunc(countw(&__lst__));

    %do _i_ = 1 %to &_n_;
        %local _e_;
        %let _e_ = %scan(&__lst__, &_i_);

        %sysfunc(tranwrd(%nrbquote(&__templ__), {}, &_e_))
    %end;
%mend;

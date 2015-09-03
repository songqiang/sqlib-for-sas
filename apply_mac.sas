/*
 * Utility Macros for SAS Programming
 * Song Qiang <keeyang@ustc.edu> 2015
 *
 */

%macro apply_mac(__lst__, __mac__)  ;
    %local _i_ _n_;
    %let _i_ = 1;
    %let _n_ = %sysfunc(countw(&__lst__));

    %do _i_ = 1 %to &_n_;
        %local _e_;
        %let _e_ = %scan(&__lst__, &_i_);

        %&__mac__(&_e_)
    %end;
%mend;


/*
 * Macro for simple exploratory data analysis; listing each variable and their percent 
 * of missing values
 *
 * Song Qiang <keeyang@ustc.edu> 2015
 */

%macro missing_table(dsn = );

data _missing_table_tmp_(keep = _varname_ _missing_ind_) / view = _missing_table_tmp_;
    set &dsn;

    array an {*} _numeric_;
    array ac {*} _character_;

    length _varname_ $120 _missing_ind_ $1;
    do i = 1 to dim(an);
        _varname_ = vname(an[i]);
        _missing_ind_ = ifc(missing(an[i]), '', '0');
        output;
    end;

    do i = 1 to dim(ac);
        _varname_ = vname(ac[i]);
        _missing_ind_ = ifc(missing(ac[i]), '', '0');
        output;
    end;
run;

proc sql;
    select
        _varname_ as Varname,
        count(_missing_ind_) as N,
        nmiss(_missing_ind_) as NMiss,
        (calculated N + calculated NMiss) as Total,
        calculated NMiss / calculated Total as Missing_Percent format = percent8.2
    from _missing_table_tmp_
    group by _varname_;
run;

%mend missing_table;

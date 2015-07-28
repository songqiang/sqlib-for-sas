
/*
 * Macro to declare a hash table
 * Song Qiang <keeyang@ustc.edu> 2015
 */
 
%macro declare_hash(hash = , key = , data = , dsn = , option = );

    %local n_key n_data i;
    %let n_key = %sysfunc(countw(&key));
    %let n_data = %sysfunc(countw(%str(&data)));
    if _n_ = 1 then do;
        if 0 then set &dsn(keep = &key &data);

        declare hash &hash(dataset:"&dsn(keep = &key &data)"
                           %if &option ne %then %do; %str(,) %str(&option) %end;);

        &hash..definekey("%scan(&key, 1)"
                         %do i = 2 %to &n_key; %str(,) "%scan(&key, &i)" %end;);

        %if &data ne %then %do;
            &hash..definedata("%scan(&data, 1)"
                              %do i = 2 %to &n_data; %str(,) "%scan(&data, &i)" %end;);
        %end;

        &hash..definedone();

        call missing(
            %scan(&key, 1) %do i = 2 %to &n_key;  %str(,) %scan(&key, &i) %end;
            %do i = 1 %to &n_data; %str(,) %scan(&data, &i) %end;
            );
    end;
%mend;

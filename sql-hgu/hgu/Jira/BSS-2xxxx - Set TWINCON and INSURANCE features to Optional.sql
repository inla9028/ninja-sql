/*
** List all TWINCON/DESCRIPTION and INSURANCE/IMEI features.
*/
select a.*
  from feature_parameters a
 where (a.soc            like 'TWINC%'
    and a.parameter_code like 'DESC%'
    )
    or (a.soc            like 'INS%'
   and a.parameter_code    = 'IMEI'
   )
order by a.soc, a.feature_code, a.parameter_code
;

/*
** Update TWINCON/DESCRIPTION.
*/
update feature_parameters a
   set a.mandatory         = 'N'
 where a.soc            like 'TWINC%'
   and a.parameter_code like 'DESC%'
;

/*
** Update INSURANCE/IMEI.
*/
update feature_parameters a
   set a.mandatory         = 'N'
 where a.soc            like 'INS%'
   and a.parameter_code    = 'IMEI'
;

/*
** List all TWINCON/DESCRIPTION and INSURANCE/IMEI features.
*/
select a.*
  from feature_parameters a
 where (a.soc            like 'TWINC%'
    and a.parameter_code like 'DESC%'
    )
    or (a.soc            like 'INS%'
   and a.parameter_code    = 'IMEI'
   )
order by a.soc, a.feature_code, a.parameter_code
;
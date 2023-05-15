/*
** 1) Update/correct the Homerun parameter's default values.
*/
/*
-- 1a) Update...
update feature_parameters a
   set a.default_value   = decode(a.parameter_code
        , 'HOMEZONE', '000901'
        , 'LOCATION', '0000'
        , a.default_value)
 where a.feature_code    = 'S-WLAN'
   and a.parameter_code IN ( 'HOMEZONE', 'LOCATION' )
;

-- 1b) Display the (updated) features)
select a.*
  from feature_parameters a
 where a.feature_code IN ( 'S-WLAN' )
order by 1,2,3
;
*/

/*
** 2) Add the MSISDN feature to the feature codes 'B-DATM','ISD96M','B-FAXM'.
*/
-- 2a) Insert...
insert into feature_parameters
select r.soc
     , r.feature_code
     , 'MSISDN'       AS "PARAMETER_CODE"
     , 'CTN'          AS "PARAMETER_TYPE"
     , 'Y'            AS "MANDATORY"
     , 'N'            AS "DISPLAYABLE"
     , ':MAIN_NUMBER' AS "DEFAULT_VALUE"
     , NULL           AS "VALIDATION_ID"
     , 'Y'            AS "IS_CLONEABLE"
     , 'N'            AS "MODIFIABLE"
  from rated_feature@fokus r
 where r.feature_code in ( 'B-DATM', 'ISD96M', 'B-FAXM' )
   and SYSDATE        < NVL(r.expiration_date, SYSDATE + 1)
   and 0              = (select count(1)
                           from feature_parameters fp
                          where r.soc          =  fp.soc
                            and r.feature_code = fp.feature_code)
order by 1,2
;

-- 2b) Display the (new content)
select a.*
  from feature_parameters a
 where a.feature_code IN ( 'B-DATM','ISD96M','B-FAXM' )
order by 2,1,3
;


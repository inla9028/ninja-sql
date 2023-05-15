select a.*
  from feature_parameters a
 where a.feature_code IN ( 'B-DATM','ISD96M','B-FAXM' )
order by 2,1,3
;

-- b) Insert...
insert into feature_parameters
select RTRIM(r.soc)          AS "SOC"
     , RTRIM(r.feature_code) AS "FEATURE_CODE"
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
   and RTRIM(r.soc)   = s.soc
   and 0              = (select count(1)
                           from feature_parameters fp
                          where RTRIM(r.soc)   = fp.soc
                            and r.feature_code = fp.feature_code)
order by 1,2
;

-- c) Display the (new) content
select a.*
  from feature_parameters a
 where a.feature_code IN ( 'B-DATM','ISD96M','B-FAXM' )
order by 2,1,3
;
 


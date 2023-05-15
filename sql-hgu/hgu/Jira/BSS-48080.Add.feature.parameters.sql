INSERT INTO feature_parameters (soc,feature_code,parameter_code,parameter_type,mandatory,displayable,default_value,validation_id,is_cloneable,modifiable)
VALUES ('PKOK','S-PPR','AMOUNT','AMT','Y','N','0',null,'N','Y')
;

INSERT INTO feature_parameters (soc,feature_code,parameter_code,parameter_type,mandatory,displayable,default_value,validation_id,is_cloneable,modifiable)
VALUES ('PKOL','S-PPR','AMOUNT','AMT','Y','N','0',null,'N','Y')
;


INSERT INTO socs_features (soc,feature_code,feature_type) VALUES ('PKOK','S-PPR','REGULAR');
INSERT INTO socs_features (soc,feature_code,feature_type) VALUES ('PKOL','S-PPR','REGULAR');

INSERT INTO FEAT_PARMS_PARM_DESC (soc,feature_code,parameter_code,parameter_name_id,language_code) VALUES ('PKOK','S-PPR','AMOUNT','10','NO');
INSERT INTO FEAT_PARMS_PARM_DESC (soc,feature_code,parameter_code,parameter_name_id,language_code) VALUES ('PKOK','S-PPR','AMOUNT','25','EN');
INSERT INTO FEAT_PARMS_PARM_DESC (soc,feature_code,parameter_code,parameter_name_id,language_code) VALUES ('PKOL','S-PPR','AMOUNT','10','NO');
INSERT INTO FEAT_PARMS_PARM_DESC (soc,feature_code,parameter_code,parameter_name_id,language_code) VALUES ('PKOL','S-PPR','AMOUNT','25','EN');

select a.*
  from feature_parameters a
-- where a.soc IN ( 'PKOL', 'PKOK', 'PKOA', 'PW10' )
-- where a.soc like 'P%'
 where a.feature_code IN ('B-DATM','ISD96M','B-FAXM')
order by 1,2,3
;

select a.*
  from feat_parms_parm_desc a
 where 1 = 1
--   and a.soc IN ( 'PKOL', 'PKOK' )
   and a.feature_code like 'S-PPR'
;

select a.*
  from feature_parameter_desc a
 where a.PARAMETER_NAME_ID IN ( 10, 25 )
;

SELECT *
  FROM socs_features
 WHERE FEATURE_CODE = 'S-PPR'
ORDER BY SOC, FEATURE_CODE
 
;
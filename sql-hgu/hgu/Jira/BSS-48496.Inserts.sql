-- Insert default value...
Insert into feature_parameter_defaults (DEALER_CODE,SOC,FEATURE_CODE,PARAMETER_CODE,DEFAULT_VALUE,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS)
values ('NWCO','HPTSP02','D-DBS','rcDA','5002',TRUNC(SYSDATE),to_date('4700-12-31 00:00','YYYY-MM-DD HH24:MI'),'Added by Håkan at ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') || '.');

-- Set the default for all...
update feature_parameters a
   set a.default_value  = '5002'
 where a.soc            = 'HPTSP02'
   and a.feature_code   = 'D-DBS'
   and a.parameter_code = 'rcDA'
;

-- Insert SPM mappings
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS)
values ('DATA_BUCKET_FWA','DATA_SHAPING','HPTSP02',TRUNC(SYSDATE),to_date('4700-12-31 00:00','YYYY-MM-DD HH24:MI'),null);

Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE)
values ('DATA_BUCKET_FWA','DA_LIMIT_CODE','daLimitCode','N',null);


-- Check everything...
select a.*
  from feature_parameter_defaults a
 where a.soc         LIKE 'HPTSP0%'
   and a.feature_code   = 'D-DBS'
   and a.parameter_code = 'rcDA'
order by a.default_value
;

select a.*
  from feature_parameters a
 where a.soc         LIKE 'HPTSP0%'
   and a.feature_code   = 'D-DBS'
   and a.parameter_code = 'rcDA'
order by a.default_value
;

select a.*
  from spm_service_mapping a
 where a.sp_code LIKE 'DATA_BUCKET%'
order by 1
;

select a.*
  from spm_feature_mapping a
 where a.sp_service_code like 'DATA_BUCKET%'
order by 1
;
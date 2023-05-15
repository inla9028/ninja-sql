--
-- Mission: Roll back HPTSP02
select a.*
  from feature_parameters a
 where a.soc like 'HPTSP0_'
   and a.parameter_code in ( 'daLimitCode', 'rcDA' )
order by 1,2,3,4
;

select a.*
  from feature_parameter_defaults a
 where a.soc like 'HPTSP0_'
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;

select a.*
  from feature_parameter_mappings a
 where a.param_type IN ( 'DA_LIMIT_CODE', 'RC_DA' )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;

-- Upsi.... The 20TB profile is missing...
select a.*
  from feature_parameter_mappings a
 where a.param_type like 'RC_DA%'
   and '5024' in ( a.param_value, a.new_value )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;


select a.*
  from spm_feature_mapping a
 where a.sp_param_code = 'DA_LIMIT_CODE'
;

-- SP_SERVICE_CODE	SP_PARAM_CODE	NINJA_PARAMETER_CODE	MANDATORY_IND
-- ---------------	-------------	--------------------	-------------
-- DATA_BUCKET		DA_LIMIT_CODE	daLimitCode				N
-- DATA_BUCKET_FWA	DA_LIMIT_CODE	daLimitCode				N
-- ---------------	-------------	--------------------	-------------

select a.*
  from spm_service_mapping a
 where a.sp_code IN ( 'DATA_BUCKET', 'DATA_BUCKET_FWA' )
;

-- SP_CODE          SOC_TYPE      SOC_GROUP  EFFECTIVE_DATE   EXPIRATION_DATE                                                                                                                        
-- ---------------  ------------  ---------  ---------------- ----------------
-- DATA_BUCKET      DATA_SHAPING  HPTSP01    2019-03-07 00:00 4700-12-31 00:00
-- DATA_BUCKET_FWA  DATA_SHAPING  HPTSP02    2020-02-13 00:00 4700-12-31 00:00
-- ---------------  ------------  ---------  ---------------- ----------------

--
-- 1. Configure the rcDA as modifiable and the daLimitCode as not modifiable.
--
update feature_parameters a
   set a.displayable = decode(a.parameter_code, 'daLimitCode', 'Y', 'N')
     , a.modifiable  = decode(a.parameter_code, 'daLimitCode', 'Y', 'N')
 where a.soc like 'HPTSP02'
   and a.parameter_code in ( 'daLimitCode', 'rcDA' )
;

--
-- 2a. Make daLimitCode validated by fp mappings
--
update feature_parameters a
   set a.validation_id = 'FP_MAPPINGS', a.default_value = '1GB'
 where a.soc like 'HPTSP02'
   and a.parameter_code in ( 'daLimitCode' )
;

--
-- 2b. Change the rcDA; default; no fp mappings. 
--
update feature_parameters a
   set a.validation_id = 'DIGITS', a.default_value = '5002'
 where a.soc like 'HPTSP02'
   and a.parameter_code in ( 'rcDA' )
;


--
-- 3. Unexpire feature parameter mappings for DA_LIMIT_CODE
--
select a.*
  from feature_parameter_mappings a
 where a.param_type IN ( 'DA_LIMIT_CODE' )
   and to_date('2022-03-24', 'YYYY-MM-DD') between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;

update feature_parameter_mappings a
   set a.expiration_date = to_date('4700-12-31', 'YYYY-MM-DD'), a.comments = 'BSSNO-49538: Keep for HPTSP02'
 where a.param_type IN ( 'DA_LIMIT_CODE' )
   and to_date('2022-03-24', 'YYYY-MM-DD') between a.effective_date and nvl(a.expiration_date, sysdate + 1)
;

--
-- 4. Update SPM mappings to point point SPM's DA_LIMIT_CODE to the actual rcDA.
--
update spm_feature_mapping a
   set a.ninja_parameter_code = 'daLimitCode'
 where a.sp_param_code        = 'DA_LIMIT_CODE'
   and a.sp_service_code      = 'DATA_BUCKET_FWA'
;


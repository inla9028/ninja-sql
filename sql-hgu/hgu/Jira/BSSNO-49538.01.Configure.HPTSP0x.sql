select a.*
  from feature_parameters a
 where a.soc like 'HPTSP0_'
   and a.parameter_code in ( 'daLimitCode', 'rcDA' )
order by 1,2,3,4
;

select a.*
  from feature_parameter_defaults a
 where a.param_type IN ( 'DA_LIMIT_CODE', 'RC_DA' )
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

--
-- 1. Configure the rcDA as modifiable and the daLimitCode as not modifiable.
--
update feature_parameters a
   set a.displayable = decode(a.parameter_code, 'rcDA', 'Y', 'N')
     , a.modifiable  = decode(a.parameter_code, 'rcDA', 'Y', 'N')
 where a.soc like 'HPTSP0_'
   and a.parameter_code in ( 'daLimitCode', 'rcDA' )
;

--
-- 2a. Make rcDA validated by fp mappings
--
update feature_parameters a
   set a.validation_id = 'FP_MAPPINGS'
 where a.soc like 'HPTSP0_'
   and a.parameter_code in ( 'rcDA' )
;

--
-- 2b. Change the daLimitCode; no default; no fp mappings. 
--
update feature_parameters a
   set a.validation_id = NULL, a.default_value = ':EMPTY_STRING'
 where a.soc like 'HPTSP0_'
   and a.parameter_code in ( 'daLimitCode' )
;

--
-- 2c. Update the defaults of rcDA
--
update feature_parameters a
   set a.default_value = '1GB'
 where a.soc like 'HPTSP0_'
   and a.parameter_code in ( 'rcDA' )
;

--
-- 3. Add feature parameter mappings for RC_DA
--
-- Write...
--
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '1GB', 'W', '5011', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '2GB', 'W', '5012', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '3GB', 'W', '5013', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5GB', 'W', '5014', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '8GB', 'W', '5015', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '10GB', 'W', '5016', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '15GB', 'W', '5017', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '30GB', 'W', '5018', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '40GB', 'W', '5019', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '50GB', 'W', '5020', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '80GB', 'W', '5021', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '200GB', 'W', '5022', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '300GB', 'W', '5023', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', 'Unlimited', 'W', '5024', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
--
-- Read
--
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5011', 'R', '1GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5012', 'R', '2GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5013', 'R', '3GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5014', 'R', '5GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5015', 'R', '8GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5016', 'R', '10GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5017', 'R', '15GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5018', 'R', '30GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5019', 'R', '40GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5020', 'R', '50GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5021', 'R', '80GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5022', 'R', '200GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5023', 'R', '300GB', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');
insert into feature_parameter_mappings (PARAM_TYPE, PARAM_VALUE, OPERATION, NEW_VALUE, EFFECTIVE_DATE, EXPIRATION_DATE, COMMENTS) values ('RC_DA', '5024', 'R', 'Unlimited', TRUNC(SYSDATE), NULL, 'BSSNO-49538: Map limit code as profile id');

--
-- 3b. Expire DA_LIMIT_CODE fp mappings.
--
update feature_parameter_mappings a
   set a.expiration_date = TRUNC(SYSDATE)
 where a.param_type IN ( 'DA_LIMIT_CODE' )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
;

--
-- 4. Update SPM mappings to point point SPM's DA_LIMIT_CODE to the actual rcDA.
--
update spm_feature_mapping a
   set a.ninja_parameter_code = 'rcDA'
 where a.sp_param_code        = 'DA_LIMIT_CODE'
;


/*

PT:

select s.*
  from spm_service_mapping s
 where s.effective_date IN ( to_date('2021-12-16', 'YYYY-MM-DD'), to_date('2021-12-17', 'YYYY-MM-DD') )
order by 2,3
;

*/
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_100GB_10MBPS_EU',           'SPVOC',        'SPVOC68',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_100GB_100MBPS_EU',          'SPVOC',        'SPVOC69',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_100GB_200MBPS_EU',          'SPVOC',        'SPVOC70',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_100GB_1000MBPS_EU',         'SPVOC',        'SPVOC71',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_150GB_200MBPS_EU',          'SPVOC',        'SPVOC72',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_150GB_1000MBPS_EU',         'SPVOC',        'SPVOC73',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_1000GB_UNLIMITED_SPEED_EU', 'SPVOC',        'SPVOC74',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_3MBPS',                     'SP_SPEED_LIM', 'SPCH003',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_200MBPS',                   'SP_SPEED_LIM', 'SPCH200',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_300MBPS',                   'SP_SPEED_LIM', 'SPCH300',   to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);
Insert into SPM_SERVICE_MAPPING (SP_CODE,SOC_TYPE,SOC_GROUP,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS) values ('DATA_CHILI_UNLIMITED_SPEED',           'SP_SPEED_LIM', 'SPCHNOLIM', to_date('2022-01-01','YYYY-MM-DD'), to_date('4700-12-31','YYYY-MM-DD'), null);

/*

PT:

select f.*
  from spm_feature_mapping f, spm_service_mapping s
 where f.sp_service_code = s.sp_code
   and s.effective_date IN ( to_date('2021-12-16', 'YYYY-MM-DD'), to_date('2021-12-17', 'YYYY-MM-DD') )
order by 1,2
;

*/

Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_200MBPS',         'BANDWIDTHDOWN', 'BANDWIDTHDOWN', 'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_200MBPS',         'BANDWIDTHUP',   'BANDWIDTHUP',   'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_200MBPS',         'IP',            'IP',            'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_200MBPS',         'NAME',          'NAME',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_200MBPS',         'TYPE',          'TYPE',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_200MBPS',         'VPLMN',         'VPLMN',         'N', null);

Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_300MBPS',         'BANDWIDTHDOWN', 'BANDWIDTHDOWN', 'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_300MBPS',         'BANDWIDTHUP',   'BANDWIDTHUP',   'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_300MBPS',         'IP',            'IP',            'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_300MBPS',         'NAME',          'NAME',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_300MBPS',         'TYPE',          'TYPE',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_300MBPS',         'VPLMN',         'VPLMN',         'N', null);

Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_3MBPS',           'BANDWIDTHDOWN', 'BANDWIDTHDOWN', 'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_3MBPS',           'BANDWIDTHUP',   'BANDWIDTHUP',   'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_3MBPS',           'IP',            'IP',            'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_3MBPS',           'NAME',          'NAME',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_3MBPS',           'TYPE',          'TYPE',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_3MBPS',           'VPLMN',         'VPLMN',         'N', null);


Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_UNLIMITED_SPEED', 'BANDWIDTHDOWN', 'BANDWIDTHDOWN', 'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_UNLIMITED_SPEED', 'BANDWIDTHUP',   'BANDWIDTHUP',   'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_UNLIMITED_SPEED', 'IP',            'IP',            'N', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_UNLIMITED_SPEED', 'NAME',          'NAME',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_UNLIMITED_SPEED', 'TYPE',          'TYPE',          'Y', null);
Insert into SPM_FEATURE_MAPPING (SP_SERVICE_CODE,SP_PARAM_CODE,NINJA_PARAMETER_CODE,MANDATORY_IND,NINJA_FEATURE_CODE) values ('DATA_CHILI_UNLIMITED_SPEED', 'VPLMN',         'VPLMN',         'N', null);

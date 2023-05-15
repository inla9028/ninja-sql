INSERT INTO features VALUES ('D-DBS');

INSERT INTO socs_features VALUES ('HPTSP01','D-DBS','REGULAR');

/*
IDATA_INCL_GB=999
ISHAPE_LIMIT_GB=999
daAllowTopup=yes
daLimitCode=10GB
daNotify=yes
daQos=NULL
daRedirect=yes
daShapedProfile=1011
rcAllowTopup=yes
rcDA=5001
*/

INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','rcDA',             'RC_DA',          'N', 'Y', '5001',          'DIGITS', 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','rcAllowTopup',     'ALLOW_TOPUP',    'N', 'Y', 'yes',           NULL, 'N', 'Y');
--INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','rcMusic',          'RC_MUSIC',       'N', 'Y', 'false',         NULL, 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','daAllowTopup',     'ALLOW_TOPUP',    'N', 'Y', 'yes',           NULL, 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','daLimitCode',      'DA_LIMIT_CODE',  'N', 'Y', '10GB',          NULL, 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','daNotify',         'DA_NOTIFY',      'N', 'Y', 'yes',           NULL, 'N', 'N');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','daQos',            'QOS',            'N', 'Y', 'NULL',          NULL, 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','daRedirect',       'DA_REDIRECT',    'N', 'Y', 'yes',           NULL, 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','daShapedProfile',  'DA_SHAPED_PROF', 'N', 'Y', '1011',          'DIGITS', 'N', 'Y');

--INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','Priority',         '', 'N', 'Y', 'xxx', NULL, 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','IDATA_INCL_GB',    'GB',             'N', 'Y', '999',           'DIGITS', 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','ISHAPE_LIMIT_GB',  'GB',             'N', 'Y', '999',           'DIGITS', 'N', 'Y');
--INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','qosProfile',       '', 'N', 'Y', 'xxx', NULL, 'N', 'Y');
--INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','maxBandwidthUp',   '', 'N', 'Y', 'xxx', NULL, 'N', 'Y');
--INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','maxBandwidthDown', '', 'N', 'Y', 'xxx', NULL, 'N', 'Y');
--INSERT INTO feature_parameters VALUES ('HPTSP01','D-DBS','qos',              '', 'N', 'Y', 'xxx', NULL, 'N', 'Y');

-- IDATA_INCL_GB=999@ISHAPE_LIMIT_GB=999@daAllowTopup=yes@daLimitCode=10GB@daNotify=yes@daQos=@daRedirect=@daShapedProfile=1011@rcAllowTopup=yes@rcDA=5001@

--HPTSP01
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket rcDA'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','rcDA',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket rcDA'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','rcDA',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket rcAllowTopup'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','rcAllowTopup',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket rcAllowTopup'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','rcAllowTopup',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

/*
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket rcMusic'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','rcMusic',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket rcMusic'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','rcMusic',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc; 
*/

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket daAllowTopup'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daAllowTopup',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket daAllowTopup'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daAllowTopup',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket daLimitCode'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daLimitCode',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket daLimitCode'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daLimitCode',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket daNotify'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daNotify',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket daNotify'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daNotify',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket daQos'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daQos',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket daQos'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daQos',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket daRedirect'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daRedirect',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket daRedirect'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daRedirect',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket daShapedProfile'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daShapedProfile',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket daShapedProfile'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','daShapedProfile',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket IDATA_INCL_GB'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','IDATA_INCL_GB',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket IDATA_INCL_GB'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','IDATA_INCL_GB',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Data Bucket ISHAPE_LIMIT_GB'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','ISHAPE_LIMIT_GB',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Data Bucket ISHAPE_LIMIT_GB'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPTSP01','D-DBS','ISHAPE_LIMIT_GB',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

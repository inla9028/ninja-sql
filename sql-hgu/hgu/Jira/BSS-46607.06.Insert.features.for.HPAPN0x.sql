/*
** From Olav:
**
** For speed:
** NAME=telia@TYPE=ipv4@VPLMN=false@BANDWIDTHDOWN=1000000@BANDWIDTHUP=1000000@
**
*/

SELECT a.soc, a.feature_code, a.parameter_code, a.parameter_type,
       a.mandatory, a.displayable, a.default_value, a.validation_id,
       a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc LIKE 'HPAPN0_'
ORDER BY 1,2,3
;

/*
** HPAPN01 :: S-AP01
*/
INSERT INTO feature_parameters VALUES ('HPAPN01', 'S-AP01', 'BANDWIDTHDOWN', 'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPAPN01', 'S-AP01', 'BANDWIDTHUP',   'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Downstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN01','S-AP01','BANDWIDTHDOWN',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Nedlasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN01','S-AP01','BANDWIDTHDOWN',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Upstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN01','S-AP01','BANDWIDTHUP',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Opplasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN01','S-AP01','BANDWIDTHUP',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

/*
** HPAPN02 :: S-AP02
*/
INSERT INTO feature_parameters VALUES ('HPAPN02', 'S-AP02', 'BANDWIDTHDOWN', 'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPAPN02', 'S-AP02', 'BANDWIDTHUP',   'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Downstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN02','S-AP02','BANDWIDTHDOWN',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Nedlasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN02','S-AP02','BANDWIDTHDOWN',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Upstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN02','S-AP02','BANDWIDTHUP',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Opplasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN02','S-AP02','BANDWIDTHUP',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

/*
** HPAPN03 :: S-AP03
*/
INSERT INTO feature_parameters VALUES ('HPAPN03', 'S-AP03', 'BANDWIDTHDOWN', 'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPAPN03', 'S-AP03', 'BANDWIDTHUP',   'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Downstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN03','S-AP03','BANDWIDTHDOWN',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Nedlasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN03','S-AP03','BANDWIDTHDOWN',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Upstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN03','S-AP03','BANDWIDTHUP',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Opplasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN03','S-AP03','BANDWIDTHUP',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

/*
** HPAPN04 :: S-AP04
*/
INSERT INTO feature_parameters VALUES ('HPAPN04', 'S-AP04', 'BANDWIDTHDOWN', 'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPAPN04', 'S-AP04', 'BANDWIDTHUP',   'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Downstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN04','S-AP04','BANDWIDTHDOWN',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Nedlasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN04','S-AP04','BANDWIDTHDOWN',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Upstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN04','S-AP04','BANDWIDTHUP',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Opplasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN04','S-AP04','BANDWIDTHUP',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

/*
** HPAPN05 :: S-AP05
*/
INSERT INTO feature_parameters VALUES ('HPAPN05', 'S-AP05', 'BANDWIDTHDOWN', 'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');
INSERT INTO feature_parameters VALUES ('HPAPN05', 'S-AP05', 'BANDWIDTHUP',   'BANDWIDTH', 'N', 'Y', '314572800', 'DIGITS', 'N', 'Y');

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Downstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN05','S-AP05','BANDWIDTHDOWN',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Nedlasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN05','S-AP05','BANDWIDTHDOWN',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'EN', 'Bandwidth Upstream'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN05','S-AP05','BANDWIDTHUP',MAX(parameter_name_id), 'EN'
       FROM feature_parameter_desc;
INSERT INTO feature_parameter_desc
     SELECT MAX(parameter_name_id) + 1, 'NO', 'Båndbredde Opplasting'
       FROM feature_parameter_desc;
INSERT INTO feat_parms_parm_desc 
     SELECT 'HPAPN05','S-AP05','BANDWIDTHUP',MAX(parameter_name_id), 'NO'
       FROM feature_parameter_desc;

/*
** Review...
*/
SELECT a.soc, a.feature_code, a.parameter_code, a.parameter_type,
       a.mandatory, a.displayable, a.default_value, a.validation_id,
       a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc LIKE 'HPAPN0_'
ORDER BY 1,2,3
;

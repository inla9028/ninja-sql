SELECT a.soc, a.feature_code, a.parameter_code, a.parameter_type,
       a.mandatory, a.displayable, a.default_value, a.validation_id,
       a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc = 'HPTSP01'
ORDER BY 1,2,3
;

/*
** From Olav:
**
** For speed:
** NAME=telia@TYPE=ipv4@VPLMN=false@BANDWIDTHDOWN=1000000@BANDWIDTHUP=1000000@
**
** For bucket:
** IDATA_INCL_GB=999@rcAllowTopup=no@rcDA=5001@daAllowTopup=no@daLimitCode=10GB@ISHAPE_LIMIT_GB=999@daNotify=yes@daShapedProfile=1011@daQos=NULL@daRedirect=yes@
**
*/
UPDATE feature_parameters SET validation_id = 'FP_MAPPINGS', parameter_type = 'DA_LIMIT_CODE'            WHERE soc = 'HPTSP01' AND feature_code = 'D-DBS' AND parameter_code = 'daLimitCode';
UPDATE feature_parameters SET validation_id = 'FP_MAPPINGS', parameter_type = 'YES_OR_NO_LONG_LOWERCASE' WHERE soc = 'HPTSP01' AND feature_code = 'D-DBS' AND parameter_code = 'daAllowTopup';
UPDATE feature_parameters SET validation_id = 'FP_MAPPINGS', parameter_type = 'YES_OR_NO_LONG_LOWERCASE' WHERE soc = 'HPTSP01' AND feature_code = 'D-DBS' AND parameter_code = 'daNotify';
UPDATE feature_parameters SET validation_id = 'FP_MAPPINGS', parameter_type = 'YES_OR_NO_LONG_LOWERCASE' WHERE soc = 'HPTSP01' AND feature_code = 'D-DBS' AND parameter_code = 'daRedirect';
UPDATE feature_parameters SET validation_id = 'FP_MAPPINGS', parameter_type = 'YES_OR_NO_LONG_LOWERCASE' WHERE soc = 'HPTSP01' AND feature_code = 'D-DBS' AND parameter_code = 'rcAllowTopup';

UPDATE feature_parameters
   SET displayable    = 'N'
 WHERE soc            = 'HPTSP01'
   AND feature_code   = 'D-DBS'
   AND parameter_code IN ( 'IDATA_INCL_GB', 'ISHAPE_LIMIT_GB', 'daAllowTopup', 'daNotify', 'daQos', 'daRedirect', 'daShapedProfile', 'rcAllowTopup', 'rcDA' )
;

UPDATE feature_parameters
   SET modifiable     = 'N'
 WHERE soc            = 'HPTSP01'
   AND feature_code   = 'D-DBS'
   AND parameter_code IN ( 'IDATA_INCL_GB', 'ISHAPE_LIMIT_GB', 'daAllowTopup', 'daNotify', 'daQos', 'daRedirect', 'daShapedProfile', 'rcAllowTopup', 'rcDA' )
;


/*
DELETE
  FROM feature_parameters a
 WHERE a.soc            = 'HPTSP01'
   AND a.feature_code   = 'D-DBS'
   AND a.parameter_code IN ( 'IDATA_INCL_GB', 'ISHAPE_LIMIT_GB' )
;
*/

SELECT a.soc, a.feature_code, a.parameter_code, a.parameter_type,
       a.mandatory, a.displayable, a.default_value, a.validation_id,
       a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc = 'HPTSP01'
ORDER BY 1,2,3
;


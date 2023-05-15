CREATE TABLE spm_feature_mapping (
    sp_service_code                VARCHAR2(64 CHAR) NOT NULL,
    sp_param_code                  VARCHAR2(64 CHAR) NOT NULL,
    ninja_parameter_code           VARCHAR2(20 CHAR) NOT NULL,
    mandatory_ind                  VARCHAR2(1 BYTE),
    ninja_feature_code             VARCHAR2(6 CHAR)
  )
/

-- Grants for Table
GRANT SELECT ON spm_feature_mapping TO ninjarstaging
/
GRANT ALTER ON spm_feature_mapping TO ninjamaster
/
GRANT DELETE ON spm_feature_mapping TO ninjamaster
/
GRANT INDEX ON spm_feature_mapping TO ninjamaster
/
GRANT INSERT ON spm_feature_mapping TO ninjamaster
/
GRANT SELECT ON spm_feature_mapping TO ninjamaster
/
GRANT UPDATE ON spm_feature_mapping TO ninjamaster
/
GRANT REFERENCES ON spm_feature_mapping TO ninjamaster
/
GRANT ON COMMIT REFRESH ON spm_feature_mapping TO ninjamaster
/
GRANT QUERY REWRITE ON spm_feature_mapping TO ninjamaster
/
GRANT DEBUG ON spm_feature_mapping TO ninjamaster
/
GRANT FLASHBACK ON spm_feature_mapping TO ninjamaster
/
GRANT ALTER ON spm_feature_mapping TO ninjamain
/
GRANT DELETE ON spm_feature_mapping TO ninjamain
/
GRANT INDEX ON spm_feature_mapping TO ninjamain
/
GRANT INSERT ON spm_feature_mapping TO ninjamain
/
GRANT SELECT ON spm_feature_mapping TO ninjamain
/
GRANT UPDATE ON spm_feature_mapping TO ninjamain
/
GRANT REFERENCES ON spm_feature_mapping TO ninjamain
/
GRANT ON COMMIT REFRESH ON spm_feature_mapping TO ninjamain
/
GRANT QUERY REWRITE ON spm_feature_mapping TO ninjamain
/
GRANT DEBUG ON spm_feature_mapping TO ninjamain
/
GRANT FLASHBACK ON spm_feature_mapping TO ninjamain
/
GRANT SELECT ON spm_feature_mapping TO backupninjarules
/
GRANT SELECT ON spm_feature_mapping TO ninjarstaging2
/

COMMENT ON COLUMN spm_feature_mapping.sp_service_code IS 'The SP code for a product, such as ''VOICEMAIL'' or ''BAR_CALLS_ALL'' etc.'
/

COMMENT ON COLUMN spm_feature_mapping.sp_param_code IS 'The SP parameter code, such as ''EMAIL'' or ''IMEI'' etc.'
/

COMMENT ON COLUMN spm_feature_mapping.ninja_parameter_code IS 'The Ninja feature parameter code, to which this should be mapped'
/

COMMENT ON COLUMN spm_feature_mapping.mandatory_ind IS 'IF ''Y'', this parameter is mandatory.'
/

COMMENT ON COLUMN spm_feature_mapping.ninja_feature_code IS 'The feature code in Ninja. Empty in 5.5% of the cases...'
/

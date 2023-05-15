CREATE TABLE feature_parameter_mappings (
    param_type                     VARCHAR2(100 CHAR),
    param_value                    VARCHAR2(100 CHAR),
    operation                      VARCHAR2(1 CHAR),
    new_value                      VARCHAR2(100 CHAR),
    effective_date                 DATE,
    expiration_date                DATE,
    comments                       VARCHAR2(1000 CHAR)
)
/


-- Grants for Table
GRANT ALTER ON feature_parameter_mappings TO ninjamain_pt
/
GRANT ALTER ON feature_parameter_mappings TO ninjaconfig_pt
/
GRANT ALTER ON feature_parameter_mappings TO ninjadata_pt
/
GRANT DELETE ON feature_parameter_mappings TO ninjamain_pt
/
GRANT DELETE ON feature_parameter_mappings TO ninjaconfig_pt
/
GRANT DELETE ON feature_parameter_mappings TO ninjadata_pt
/
GRANT INDEX ON feature_parameter_mappings TO ninjamain_pt
/
GRANT INDEX ON feature_parameter_mappings TO ninjaconfig_pt
/
GRANT INDEX ON feature_parameter_mappings TO ninjadata_pt
/
GRANT INSERT ON feature_parameter_mappings TO ninjamain_pt
/
GRANT INSERT ON feature_parameter_mappings TO ninjaconfig_pt
/
GRANT INSERT ON feature_parameter_mappings TO ninjadata_pt
/
GRANT SELECT ON feature_parameter_mappings TO ninjamain_pt
/
GRANT SELECT ON feature_parameter_mappings TO ninjaconfig_pt
/
GRANT SELECT ON feature_parameter_mappings TO ninjadata_pt
/
GRANT UPDATE ON feature_parameter_mappings TO ninjamain_pt
/
GRANT UPDATE ON feature_parameter_mappings TO ninjaconfig_pt
/
GRANT UPDATE ON feature_parameter_mappings TO ninjadata_pt
/
GRANT REFERENCES ON feature_parameter_mappings TO ninjamain_pt
/
GRANT REFERENCES ON feature_parameter_mappings TO ninjaconfig_pt
/
GRANT REFERENCES ON feature_parameter_mappings TO ninjadata_pt
/
GRANT ON COMMIT REFRESH ON feature_parameter_mappings TO ninjamain_pt
/
GRANT QUERY REWRITE ON feature_parameter_mappings TO ninjamain_pt
/
GRANT DEBUG ON feature_parameter_mappings TO ninjamain_pt
/
GRANT FLASHBACK ON feature_parameter_mappings TO ninjamain_pt
/

ALTER TABLE feature_parameter_mappings
ADD CONSTRAINT feature_parameters_map_pk PRIMARY KEY (param_type, param_value, operation)
/

ALTER TABLE feature_parameter_mappings
ADD CONSTRAINT feature_parameter_map_con1 CHECK ( operation IN  ( 'R', 'W' ))
ENABLE NOVALIDATE
/

CREATE OR REPLACE TRIGGER feature_parameter_map_trg1
    BEFORE INSERT OR UPDATE
    ON feature_parameter_mappings
    REFERENCING NEW AS new OLD AS old
    FOR EACH ROW
DECLARE
    v_cnt   NUMBER DEFAULT 0;
BEGIN

    IF :new.effective_date IS NULL
    THEN
        :new.effective_date := TRUNC(SYSDATE);
    ELSE
        :new.effective_date := TRUNC(:new.effective_date);
    END IF;

    IF :new.expiration_date IS NULL
    THEN
        :new.expiration_date := TO_DATE('4700-12-31','YYYY-MM-DD');
    ELSE
        :new.expiration_date := TRUNC(:new.expiration_date);
    END IF;
    
END;
/

COMMENT ON TABLE feature_parameter_mappings IS 'Holds feature parameter mappings, for validation and transformation'
/
COMMENT ON COLUMN feature_parameter_mappings.param_type IS 'The FP type, should equal the PARAMETER_TYPE in table FEATURE_PARAMETERS'
/
COMMENT ON COLUMN feature_parameter_mappings.param_value IS 'Allowed value for the feature paramters of the specified type.'
/
COMMENT ON COLUMN feature_parameter_mappings.operation IS 'R=Read, W=Write'
/
COMMENT ON COLUMN feature_parameter_mappings.new_value IS 'If not empty, this value replaces the new value to use instead of the current feature parameter'
/


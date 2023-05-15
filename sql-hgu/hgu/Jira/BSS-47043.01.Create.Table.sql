CREATE TABLE feature_parameter_defaults (
    dealer_code                    VARCHAR2(5 CHAR),
    soc                            VARCHAR2(9 CHAR),
    feature_code                   VARCHAR2(6 CHAR),
    parameter_code                 VARCHAR2(20 CHAR),
    default_value                  VARCHAR2(100 CHAR),
    effective_date                 DATE,
    expiration_date                DATE,
    comments                       VARCHAR2(200 CHAR)
)
/

-- Grants for Table
GRANT ALTER ON feature_parameter_defaults TO ninjamain_pt
/
GRANT ALTER ON feature_parameter_defaults TO ninjaconfig_pt
/
GRANT ALTER ON feature_parameter_defaults TO ninjadata_pt
/
GRANT DELETE ON feature_parameter_defaults TO ninjamain_pt
/
GRANT DELETE ON feature_parameter_defaults TO ninjaconfig_pt
/
GRANT DELETE ON feature_parameter_defaults TO ninjadata_pt
/
GRANT INDEX ON feature_parameter_defaults TO ninjamain_pt
/
GRANT INDEX ON feature_parameter_defaults TO ninjaconfig_pt
/
GRANT INDEX ON feature_parameter_defaults TO ninjadata_pt
/
GRANT INSERT ON feature_parameter_defaults TO ninjamain_pt
/
GRANT INSERT ON feature_parameter_defaults TO ninjaconfig_pt
/
GRANT INSERT ON feature_parameter_defaults TO ninjadata_pt
/
GRANT SELECT ON feature_parameter_defaults TO ninjamain_pt
/
GRANT SELECT ON feature_parameter_defaults TO ninjaconfig_pt
/
GRANT SELECT ON feature_parameter_defaults TO ninjadata_pt
/
GRANT UPDATE ON feature_parameter_defaults TO ninjamain_pt
/
GRANT UPDATE ON feature_parameter_defaults TO ninjaconfig_pt
/
GRANT UPDATE ON feature_parameter_defaults TO ninjadata_pt
/
GRANT REFERENCES ON feature_parameter_defaults TO ninjamain_pt
/
GRANT REFERENCES ON feature_parameter_defaults TO ninjaconfig_pt
/
GRANT REFERENCES ON feature_parameter_defaults TO ninjadata_pt
/
GRANT ON COMMIT REFRESH ON feature_parameter_defaults TO ninjamain_pt
/
GRANT QUERY REWRITE ON feature_parameter_defaults TO ninjamain_pt
/
GRANT DEBUG ON feature_parameter_defaults TO ninjamain_pt
/
GRANT FLASHBACK ON feature_parameter_defaults TO ninjamain_pt
/

ALTER TABLE feature_parameter_defaults
ADD CONSTRAINT feature_parameters_def_pk PRIMARY KEY (dealer_code, soc, feature_code, parameter_code)
/

CREATE OR REPLACE TRIGGER feature_parameters_def_trg1
    BEFORE INSERT OR UPDATE
    ON feature_parameter_defaults
    REFERENCING NEW AS new OLD AS old
    FOR EACH ROW
DECLARE
    v_cnt   NUMBER DEFAULT 0;
BEGIN

    IF :new.default_value LIKE ':%'
    THEN
        SELECT COUNT (*)
          INTO v_cnt
          FROM system_defaults
         WHERE key = :new.default_value;

        IF v_cnt = 0
        THEN
            raise_application_error (-20001, 'Illegal bind variable: ''' || :new.default_value || '''');
        END IF;
    END IF;

    IF :new.effective_date IS NULL
    THEN
        :new.effective_date := TRUNC(SYSDATE);
    ELSE
        :new.effective_date := TRUNC(:new.effective_date);
    END IF;

    IF :new.expiration_date IS NULL
    THEN
        :new.expiration_date := TO_DATE('47001231','YYYYMMDD');
    ELSE
        :new.expiration_date := TRUNC(:new.expiration_date);
    END IF;
    
END;
/

-- Comments for FEATURE_PARAMETERS

COMMENT ON TABLE feature_parameter_defaults IS 'Holds additional default feature parameter values per dealer'
/
COMMENT ON COLUMN feature_parameter_defaults.default_value IS 'Default value for parameter'
/
COMMENT ON COLUMN feature_parameter_defaults.feature_code IS 'Foreign key column from SOCS_FEATURES'
/
COMMENT ON COLUMN feature_parameter_defaults.parameter_code IS 'Parameter code'
/
COMMENT ON COLUMN feature_parameter_defaults.soc IS 'Foreign key column from SOCS_FEATURES'
/


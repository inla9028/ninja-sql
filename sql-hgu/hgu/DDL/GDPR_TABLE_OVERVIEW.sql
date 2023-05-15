CREATE TABLE GDPR_TABLE_OVERVIEW (
    schema_name                     VARCHAR2(30 CHAR) NOT NULL,
    table_name                      VARCHAR2(30 CHAR) NOT NULL,
    column_name                     VARCHAR2(30 CHAR),
    data_type                       VARCHAR2(30 CHAR),
    retention_column                VARCHAR2(30 CHAR),
    retention_days                  NUMBER(6,0),
    effective_date                  DATE              NOT NULL,
    expiration_date                 DATE,
    comments                        VARCHAR2(200 CHAR)
)
/

-- Grants for Table
GRANT ALTER ON GDPR_TABLE_OVERVIEW TO ninjarules
/
GRANT DELETE ON GDPR_TABLE_OVERVIEW TO ninjarules
/
GRANT INDEX ON GDPR_TABLE_OVERVIEW TO ninjarules
/
GRANT INSERT ON GDPR_TABLE_OVERVIEW TO ninjarules
/
GRANT SELECT ON GDPR_TABLE_OVERVIEW TO ninjarules
/
GRANT UPDATE ON GDPR_TABLE_OVERVIEW TO ninjarules
/
GRANT REFERENCES ON GDPR_TABLE_OVERVIEW TO ninjarules
/
GRANT ALTER ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT DELETE ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT INDEX ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT INSERT ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT SELECT ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT UPDATE ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT REFERENCES ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT ON COMMIT REFRESH ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT QUERY REWRITE ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT DEBUG ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT FLASHBACK ON GDPR_TABLE_OVERVIEW TO ninjamain
/
GRANT ALTER ON GDPR_TABLE_OVERVIEW TO ninjadata
/
GRANT DELETE ON GDPR_TABLE_OVERVIEW TO ninjadata
/
GRANT INDEX ON GDPR_TABLE_OVERVIEW TO ninjadata
/
GRANT INSERT ON GDPR_TABLE_OVERVIEW TO ninjadata
/
GRANT SELECT ON GDPR_TABLE_OVERVIEW TO ninjadata
/
GRANT UPDATE ON GDPR_TABLE_OVERVIEW TO ninjadata
/
GRANT REFERENCES ON GDPR_TABLE_OVERVIEW TO ninjadata
/
GRANT SELECT ON GDPR_TABLE_OVERVIEW TO ninjacstaging
/

-- Trigger...

CREATE OR REPLACE TRIGGER gdpr_table_overview_trg1
 BEFORE
  INSERT OR UPDATE
 ON gdpr_table_overview
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
    BEGIN
        IF INSERTING OR UPDATING
        THEN
            --
            -- Set effective_date if not specified...
            --
            IF :NEW.effective_date IS NULL
            THEN
                SELECT TRUNC(SYSDATE)
                  INTO :NEW.effective_date
                  FROM dual;
            END IF;
            --
            -- Validate that the columns needed are populated.
            --
            IF (:NEW.column_name IS NULL OR :NEW.data_type IS NULL) AND (:NEW.retention_column IS NULL OR :NEW.retention_days IS NULL)
            THEN
                RAISE_APPLICATION_ERROR( 
                    -20001, 
                    'Either COLUMN_NAME and DATA_TYPE needs to have values or RETENTION_COLUMN and RETENTION_DAYS' 
                );
            END IF;
        END IF;
    END;
/

-- Comments for GDPR_TABLE_OVERVIEW
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.SCHEMA_NAME      IS 'The schema name';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.TABLE_NAME       IS 'The table name';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.COLUMN_NAME      IS 'The column name';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.DATA_TYPE        IS 'The data type, either "BAN", "CTN" or "SIM';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.RETENTION_COLUMN IS 'The column containing the date for which to compare age/retention';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.RETENTION_DAYS   IS 'The number of days to allow records in table';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.EFFECTIVE_DATE   IS 'The effective date of this rule';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.EXPIRATION_DATE  IS 'The expiration date of this rule, NULL = Forever';
COMMENT ON COLUMN GDPR_TABLE_OVERVIEW.COMMENTS         IS 'Comments, similar to this one. Ey, a comment about a comment!';


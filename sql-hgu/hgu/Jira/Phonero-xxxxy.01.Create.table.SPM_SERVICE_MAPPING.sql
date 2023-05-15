CREATE TABLE spm_service_mapping (
    sp_code          VARCHAR2(64 CHAR),
    soc_type         VARCHAR2(15 CHAR),
    soc_group        VARCHAR2(15 CHAR),
    effective_date   DATE,
    expiration_date  DATE,
    comments         VARCHAR2(128 CHAR)
  )
/

-- Grants for Table
GRANT SELECT ON spm_service_mapping TO ninjarstaging
/
GRANT ALTER ON spm_service_mapping TO ninjamaster
/
GRANT DELETE ON spm_service_mapping TO ninjamaster
/
GRANT INDEX ON spm_service_mapping TO ninjamaster
/
GRANT INSERT ON spm_service_mapping TO ninjamaster
/
GRANT SELECT ON spm_service_mapping TO ninjamaster
/
GRANT UPDATE ON spm_service_mapping TO ninjamaster
/
GRANT REFERENCES ON spm_service_mapping TO ninjamaster
/
GRANT ON COMMIT REFRESH ON spm_service_mapping TO ninjamaster
/
GRANT QUERY REWRITE ON spm_service_mapping TO ninjamaster
/
GRANT DEBUG ON spm_service_mapping TO ninjamaster
/
GRANT FLASHBACK ON spm_service_mapping TO ninjamaster
/
GRANT ALTER ON spm_service_mapping TO ninjamain
/
GRANT DELETE ON spm_service_mapping TO ninjamain
/
GRANT INDEX ON spm_service_mapping TO ninjamain
/
GRANT INSERT ON spm_service_mapping TO ninjamain
/
GRANT SELECT ON spm_service_mapping TO ninjamain
/
GRANT UPDATE ON spm_service_mapping TO ninjamain
/
GRANT REFERENCES ON spm_service_mapping TO ninjamain
/
GRANT ON COMMIT REFRESH ON spm_service_mapping TO ninjamain
/
GRANT QUERY REWRITE ON spm_service_mapping TO ninjamain
/
GRANT DEBUG ON spm_service_mapping TO ninjamain
/
GRANT FLASHBACK ON spm_service_mapping TO ninjamain
/
GRANT SELECT ON spm_service_mapping TO backupninjarules
/
GRANT SELECT ON spm_service_mapping TO ninjarstaging2
/

ALTER TABLE spm_service_mapping
ADD CHECK ("SP_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE spm_service_mapping
ADD CHECK ("SOC_TYPE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE spm_service_mapping
ADD CHECK ("SOC_GROUP" IS NOT NULL)
ENABLE NOVALIDATE
/

CREATE OR REPLACE TRIGGER spm_service_mapping_trg1
 BEFORE
  INSERT
 ON spm_service_mapping
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  v_success_count     NUMBER DEFAULT 0;
  v_error_count       NUMBER DEFAULT 0;
  v_tmp_trans_seq     NUMBER DEFAULT 0;

 BEGIN
  IF INSERTING
  THEN
   IF :new.effective_date IS NULL
   THEN
     :new.effective_date := TRUNC(SYSDATE);
   END IF;
   
   IF :new.expiration_date IS NULL
   THEN
     :new.expiration_date := TO_DATE('4700-12-31', 'YYYY-MM-DD');
   END IF;

  END IF;
 END;
/

COMMENT ON COLUMN spm_service_mapping.sp_code IS 'The SP code for a product, such as ''VOICEMAIL'' or ''BAR_CALLS_ALL'' etc.'
/

COMMENT ON COLUMN spm_service_mapping.soc_type IS 'The soc-type in Ninja'
/

COMMENT ON COLUMN spm_service_mapping.soc_group IS 'The soc-group in Ninja'
/

COMMENT ON COLUMN spm_service_mapping.effective_date IS 'Effective date...'
/

COMMENT ON COLUMN spm_service_mapping.expiration_date IS 'Expiration date...'
/

COMMENT ON COLUMN spm_service_mapping.comments IS 'This is a comment on a column named comments... That''s funny! ;-)'
/


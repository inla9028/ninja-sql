CREATE TABLE spm_priceplan_mapping (
    service_provider_code          VARCHAR2(15 CHAR),
    sp_priceplan_code              VARCHAR2(64 CHAR),
    soc_code                       VARCHAR2(9 CHAR),
    effective_date                 DATE,
    expiration_date                DATE,
    comments                       VARCHAR2(128 CHAR)
  )
/

-- Grants for Table
GRANT SELECT ON spm_priceplan_mapping TO ninjarstaging
/
GRANT ALTER ON spm_priceplan_mapping TO ninjamaster
/
GRANT DELETE ON spm_priceplan_mapping TO ninjamaster
/
GRANT INDEX ON spm_priceplan_mapping TO ninjamaster
/
GRANT INSERT ON spm_priceplan_mapping TO ninjamaster
/
GRANT SELECT ON spm_priceplan_mapping TO ninjamaster
/
GRANT UPDATE ON spm_priceplan_mapping TO ninjamaster
/
GRANT REFERENCES ON spm_priceplan_mapping TO ninjamaster
/
GRANT ON COMMIT REFRESH ON spm_priceplan_mapping TO ninjamaster
/
GRANT QUERY REWRITE ON spm_priceplan_mapping TO ninjamaster
/
GRANT DEBUG ON spm_priceplan_mapping TO ninjamaster
/
GRANT FLASHBACK ON spm_priceplan_mapping TO ninjamaster
/
GRANT ALTER ON spm_priceplan_mapping TO ninjamain
/
GRANT DELETE ON spm_priceplan_mapping TO ninjamain
/
GRANT INDEX ON spm_priceplan_mapping TO ninjamain
/
GRANT INSERT ON spm_priceplan_mapping TO ninjamain
/
GRANT SELECT ON spm_priceplan_mapping TO ninjamain
/
GRANT UPDATE ON spm_priceplan_mapping TO ninjamain
/
GRANT REFERENCES ON spm_priceplan_mapping TO ninjamain
/
GRANT ON COMMIT REFRESH ON spm_priceplan_mapping TO ninjamain
/
GRANT QUERY REWRITE ON spm_priceplan_mapping TO ninjamain
/
GRANT DEBUG ON spm_priceplan_mapping TO ninjamain
/
GRANT FLASHBACK ON spm_priceplan_mapping TO ninjamain
/
GRANT SELECT ON spm_priceplan_mapping TO backupninjarules
/
GRANT SELECT ON spm_priceplan_mapping TO ninjarstaging2
/

ALTER TABLE spm_priceplan_mapping
ADD CHECK ("SERVICE_PROVIDER_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE spm_priceplan_mapping
ADD CHECK ("SP_PRICEPLAN_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE spm_priceplan_mapping
ADD CHECK ("SOC_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

CREATE OR REPLACE TRIGGER spm_priceplan_mapping_trg1
 BEFORE
  INSERT
 ON spm_priceplan_mapping
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

COMMENT ON COLUMN spm_priceplan_mapping.service_provider_code IS 'The SP code, matching ninjaconfig.service_providers'
/

COMMENT ON COLUMN spm_priceplan_mapping.sp_priceplan_code IS 'The SP code for a priceplan, such as ''VOICE'' or ''PREPAID'' etc.'
/

COMMENT ON COLUMN spm_priceplan_mapping.soc_code IS 'The corresponding Priceplan SOC-code in Fokus'
/

COMMENT ON COLUMN spm_priceplan_mapping.effective_date IS 'Effective date...'
/

COMMENT ON COLUMN spm_priceplan_mapping.expiration_date IS 'Expiration date...'
/

COMMENT ON COLUMN spm_priceplan_mapping.comments IS 'This is a comment on a column named comments... That''s funny! ;-)'
/


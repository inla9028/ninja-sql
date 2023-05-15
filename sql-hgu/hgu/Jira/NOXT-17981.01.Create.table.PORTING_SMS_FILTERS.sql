CREATE TABLE porting_sms_filters (
    activity_code                  VARCHAR2(32),
    filter_type                    VARCHAR2(32),
    filter_value                   VARCHAR2(64),
    effective_date                 DATE,
    expiration_date                DATE,
    comments                       VARCHAR2(64)
)
/


-- Grants for Table
GRANT ALTER ON porting_sms_filters TO ninjateam
/
GRANT DELETE ON porting_sms_filters TO ninjateam
/
GRANT INDEX ON porting_sms_filters TO ninjateam
/
GRANT INSERT ON porting_sms_filters TO ninjateam
/
GRANT SELECT ON porting_sms_filters TO ninjateam
/
GRANT UPDATE ON porting_sms_filters TO ninjateam
/
GRANT REFERENCES ON porting_sms_filters TO ninjateam
/
GRANT ALTER ON porting_sms_filters TO ninjamaster
/
GRANT DELETE ON porting_sms_filters TO ninjamaster
/
GRANT INDEX ON porting_sms_filters TO ninjamaster
/
GRANT INSERT ON porting_sms_filters TO ninjamaster
/
GRANT SELECT ON porting_sms_filters TO ninjamaster
/
GRANT UPDATE ON porting_sms_filters TO ninjamaster
/
GRANT REFERENCES ON porting_sms_filters TO ninjamaster
/
GRANT ON COMMIT REFRESH ON porting_sms_filters TO ninjamaster
/
GRANT QUERY REWRITE ON porting_sms_filters TO ninjamaster
/
GRANT DEBUG ON porting_sms_filters TO ninjamaster
/
GRANT FLASHBACK ON porting_sms_filters TO ninjamaster
/
GRANT ALTER ON porting_sms_filters TO ninjamain
/
GRANT DELETE ON porting_sms_filters TO ninjamain
/
GRANT INDEX ON porting_sms_filters TO ninjamain
/
GRANT INSERT ON porting_sms_filters TO ninjamain
/
GRANT SELECT ON porting_sms_filters TO ninjamain
/
GRANT UPDATE ON porting_sms_filters TO ninjamain
/
GRANT REFERENCES ON porting_sms_filters TO ninjamain
/
GRANT ON COMMIT REFRESH ON porting_sms_filters TO ninjamain
/
GRANT QUERY REWRITE ON porting_sms_filters TO ninjamain
/
GRANT DEBUG ON porting_sms_filters TO ninjamain
/
GRANT FLASHBACK ON porting_sms_filters TO ninjamain
/
GRANT SELECT ON porting_sms_filters TO ks_user
/
GRANT SELECT ON porting_sms_filters TO kontant
/
GRANT SELECT ON porting_sms_filters TO readonly
/

-- Indexes for porting_sms_filters

CREATE INDEX porting_sms_filters_idx1 ON porting_sms_filters (activity_code, filter_type);
CREATE INDEX porting_sms_filters_idx2 ON porting_sms_filters (effective_date, expiration_date);



-- Triggers for porting_sms_filters

CREATE OR REPLACE TRIGGER porting_sms_filters_trg1
 BEFORE
  INSERT
 ON porting_sms_filters
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
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

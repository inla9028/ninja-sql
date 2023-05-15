CREATE TABLE soc_charges (
    neo_code                       VARCHAR2(64 CHAR) NOT NULL,
    feature_code                   VARCHAR2(6 CHAR) NOT NULL,
    activity_reason_code           VARCHAR2(9 CHAR),
    bill_text                      VARCHAR2(25 CHAR),
    memo_text                      VARCHAR2(2000 CHAR),
    waive_memo_text                VARCHAR2(2000 CHAR),
    effective_date                 DATE,
    expiration_date                DATE,
    description                    VARCHAR2(2000 CHAR)
)
/

-- Grants for Table
/*
GRANT ALTER ON soc_charges TO ninjateam
/
GRANT DELETE ON soc_charges TO ninjateam
/
GRANT INDEX ON soc_charges TO ninjateam
/
GRANT INSERT ON soc_charges TO ninjateam
/
GRANT SELECT ON soc_charges TO ninjateam
/
GRANT UPDATE ON soc_charges TO ninjateam
/
GRANT REFERENCES ON soc_charges TO ninjateam
/
*/
GRANT ALTER ON soc_charges TO ninjamain
/
GRANT DELETE ON soc_charges TO ninjamain
/
GRANT INDEX ON soc_charges TO ninjamain
/
GRANT INSERT ON soc_charges TO ninjamain
/
GRANT SELECT ON soc_charges TO ninjamain
/
GRANT UPDATE ON soc_charges TO ninjamain
/
GRANT REFERENCES ON soc_charges TO ninjamain
/
GRANT ON COMMIT REFRESH ON soc_charges TO ninjamain
/
GRANT QUERY REWRITE ON soc_charges TO ninjamain
/
GRANT DEBUG ON soc_charges TO ninjamain
/
GRANT FLASHBACK ON soc_charges TO ninjamain
/

-- Triggers for soc_charges

CREATE OR REPLACE TRIGGER soc_charges_trg
 BEFORE
  INSERT
 ON soc_charges
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF INSERTING
    THEN
    --== Ensure we record the effective date
    IF :new.effective_date IS NULL THEN
        :new.effective_date := TRUNC(SYSDATE);
    END IF;
    --== Ensure we record the expiration date
    IF :new.expiration_date IS NULL THEN
        :new.expiration_date := TO_DATE('4700-12-31', 'YYYY-MM-DD');
    END IF;
    --==
  END IF;
END soc_charges_trg;
/

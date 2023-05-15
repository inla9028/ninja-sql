CREATE TABLE suspend_bar (
    priceplan                      VARCHAR2(4 CHAR) NOT NULL,
    soc                            VARCHAR2(9 CHAR),
    effective_date                 DATE,
    expiration_date                DATE,
    description                    VARCHAR2(2000 CHAR)
)
/

-- Grants for Table
/*
GRANT ALTER ON suspend_bar TO ninjateam
/
GRANT DELETE ON suspend_bar TO ninjateam
/
GRANT INDEX ON suspend_bar TO ninjateam
/
GRANT INSERT ON suspend_bar TO ninjateam
/
GRANT SELECT ON suspend_bar TO ninjateam
/
GRANT UPDATE ON suspend_bar TO ninjateam
/
GRANT REFERENCES ON suspend_bar TO ninjateam
/
*/
GRANT ALTER ON suspend_bar TO ninjamain
/
GRANT DELETE ON suspend_bar TO ninjamain
/
GRANT INDEX ON suspend_bar TO ninjamain
/
GRANT INSERT ON suspend_bar TO ninjamain
/
GRANT SELECT ON suspend_bar TO ninjamain
/
GRANT UPDATE ON suspend_bar TO ninjamain
/
GRANT REFERENCES ON suspend_bar TO ninjamain
/
GRANT ON COMMIT REFRESH ON suspend_bar TO ninjamain
/
GRANT QUERY REWRITE ON suspend_bar TO ninjamain
/
GRANT DEBUG ON suspend_bar TO ninjamain
/
GRANT FLASHBACK ON suspend_bar TO ninjamain
/

-- Triggers for suspend_bar

CREATE OR REPLACE TRIGGER suspend_bar_trg
 BEFORE
  INSERT
 ON suspend_bar
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
END suspend_bar_trg;
/

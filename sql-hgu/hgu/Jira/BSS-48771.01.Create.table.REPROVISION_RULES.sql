CREATE TABLE reprovision_rules (
  dealer_code VARCHAR2(5 CHAR), 
	reprov_type VARCHAR2(32 CHAR), 
	soc VARCHAR2(9 CHAR), 
	feature VARCHAR2(9 CHAR), 
	effective_date DATE, 
	expiration_date DATE, 
	comments VARCHAR2(128 CHAR), 
	 CHECK (dealer_code IS NOT NULL) ENABLE NOVALIDATE, 
	 CHECK (reprov_type IS NOT NULL) ENABLE NOVALIDATE, 
	 CHECK (soc IS NOT NULL) ENABLE NOVALIDATE
)
;

CREATE OR REPLACE TRIGGER reprovision_rules_trg1 
 BEFORE
  INSERT
 ON reprovision_rules
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

ALTER TRIGGER reprovision_rules_trg1 ENABLE
;

-- Grants for Table
/*
GRANT ALTER ON reprovision_rules TO ninjateam
/
GRANT DELETE ON reprovision_rules TO ninjateam
/
GRANT INDEX ON reprovision_rules TO ninjateam
/
GRANT INSERT ON reprovision_rules TO ninjateam
/
GRANT SELECT ON reprovision_rules TO ninjateam
/
GRANT UPDATE ON reprovision_rules TO ninjateam
/
GRANT REFERENCES ON reprovision_rules TO ninjateam
/
*/
GRANT ALTER ON reprovision_rules TO ninjamain
/
GRANT DELETE ON reprovision_rules TO ninjamain
/
GRANT INDEX ON reprovision_rules TO ninjamain
/
GRANT INSERT ON reprovision_rules TO ninjamain
/
GRANT SELECT ON reprovision_rules TO ninjamain
/

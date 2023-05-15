/*
"SELECT svc_status, rng_hold_ind, int_port_ind, ctn_sts_ind, porting_indicator\n" +
"  FROM number_porting_logic\n" +
" WHERE SYSDATE between effective_date AND NVL(expiration_date, SYSDATE + 1)";

CREATE SYNONYM number_porting_logic
  FOR ninjarules_at.number_porting_logic
;

*/

CREATE TABLE number_porting_logic
    (svc_status           VARCHAR2(2 CHAR),
    rng_hold_ind          VARCHAR2(2 CHAR),
    int_port_ind          VARCHAR2(2 CHAR),
    ctn_sts_ind           VARCHAR2(2 CHAR),
    porting_indicator     VARCHAR2(2 CHAR),
    porting_mechanism     VARCHAR2(64 CHAR),
    description           VARCHAR2(2000 CHAR),
    effective_date        DATE,
    expiration_date       DATE)
/

-- Grants for Table
GRANT ALTER ON number_porting_logic TO ninjamain
/
GRANT ALTER ON number_porting_logic TO ninjaconfig
/
GRANT ALTER ON number_porting_logic TO ninjadata
/
GRANT DELETE ON number_porting_logic TO ninjamain
/
GRANT DELETE ON number_porting_logic TO ninjaconfig
/
GRANT DELETE ON number_porting_logic TO ninjadata
/
GRANT INDEX ON number_porting_logic TO ninjamain
/
GRANT INDEX ON number_porting_logic TO ninjaconfig
/
GRANT INDEX ON number_porting_logic TO ninjadata
/
GRANT INSERT ON number_porting_logic TO ninjamain
/
GRANT INSERT ON number_porting_logic TO ninjaconfig
/
GRANT INSERT ON number_porting_logic TO ninjadata
/
GRANT SELECT ON number_porting_logic TO ninjamain
/
GRANT SELECT ON number_porting_logic TO ninjaconfig
/
GRANT SELECT ON number_porting_logic TO ninjadata
/
GRANT UPDATE ON number_porting_logic TO ninjamain
/
GRANT UPDATE ON number_porting_logic TO ninjaconfig
/
GRANT UPDATE ON number_porting_logic TO ninjadata
/
GRANT REFERENCES ON number_porting_logic TO ninjamain
/
GRANT REFERENCES ON number_porting_logic TO ninjaconfig
/
GRANT REFERENCES ON number_porting_logic TO ninjadata
/
GRANT ON COMMIT REFRESH ON number_porting_logic TO ninjamain
/
GRANT QUERY REWRITE ON number_porting_logic TO ninjamain
/
GRANT DEBUG ON number_porting_logic TO ninjamain
/
GRANT FLASHBACK ON number_porting_logic TO ninjamain
/


-- Triggers for number_porting_logic

CREATE OR REPLACE TRIGGER number_porting_logic_trg1
 BEFORE
  INSERT OR UPDATE
 ON number_porting_logic
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN

    IF :new.effective_date IS NULL      
    THEN
        :new.effective_date := trunc(sysdate);
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



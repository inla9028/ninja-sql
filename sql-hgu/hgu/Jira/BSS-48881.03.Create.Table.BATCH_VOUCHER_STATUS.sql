CREATE TABLE batch_voucher_status (
    duration                       NUMBER(9),
    process_time                   DATE,
    thread_name                    VARCHAR2(2000 CHAR)
)
/


-- Grants for Table
GRANT ALTER ON batch_voucher_status TO ninjateam
/
GRANT DELETE ON batch_voucher_status TO ninjateam
/
GRANT INDEX ON batch_voucher_status TO ninjateam
/
GRANT INSERT ON batch_voucher_status TO ninjateam
/
GRANT SELECT ON batch_voucher_status TO ninjateam
/
GRANT UPDATE ON batch_voucher_status TO ninjateam
/
GRANT REFERENCES ON batch_voucher_status TO ninjateam
/
GRANT ALTER ON batch_voucher_status TO ninjamaster
/
GRANT DELETE ON batch_voucher_status TO ninjamaster
/
GRANT INDEX ON batch_voucher_status TO ninjamaster
/
GRANT INSERT ON batch_voucher_status TO ninjamaster
/
GRANT SELECT ON batch_voucher_status TO ninjamaster
/
GRANT UPDATE ON batch_voucher_status TO ninjamaster
/
GRANT REFERENCES ON batch_voucher_status TO ninjamaster
/
GRANT ON COMMIT REFRESH ON batch_voucher_status TO ninjamaster
/
GRANT QUERY REWRITE ON batch_voucher_status TO ninjamaster
/
GRANT DEBUG ON batch_voucher_status TO ninjamaster
/
GRANT FLASHBACK ON batch_voucher_status TO ninjamaster
/
GRANT ALTER ON batch_voucher_status TO ninjamain
/
GRANT DELETE ON batch_voucher_status TO ninjamain
/
GRANT INDEX ON batch_voucher_status TO ninjamain
/
GRANT INSERT ON batch_voucher_status TO ninjamain
/
GRANT SELECT ON batch_voucher_status TO ninjamain
/
GRANT UPDATE ON batch_voucher_status TO ninjamain
/
GRANT REFERENCES ON batch_voucher_status TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_voucher_status TO ninjamain
/
GRANT QUERY REWRITE ON batch_voucher_status TO ninjamain
/
GRANT DEBUG ON batch_voucher_status TO ninjamain
/
GRANT FLASHBACK ON batch_voucher_status TO ninjamain
/
GRANT SELECT ON batch_voucher_status TO ks_user
/
GRANT SELECT ON batch_voucher_status TO kontant
/
/
GRANT SELECT ON batch_voucher_status TO readonly
/

-- Indexes for batch_voucher_status

CREATE INDEX batch_voucher_status_idx1 ON batch_voucher_status
  (
    process_time                    ASC
  )
/


-- Triggers for batch_voucher_status

CREATE OR REPLACE TRIGGER batch_voucher_status_trg1
 BEFORE
  INSERT
 ON batch_voucher_status
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF INSERTING
  THEN
   IF :new.process_time IS NULL
   THEN
     SELECT SYSDATE
       INTO :new.process_time
       FROM dual;
   END IF;
  END IF;
 END;
/

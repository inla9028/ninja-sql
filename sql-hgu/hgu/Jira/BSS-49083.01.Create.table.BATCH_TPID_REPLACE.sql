CREATE TABLE batch_tpid_replace (
  old_tpid        VARCHAR2(50 CHAR),
  tpid            VARCHAR2(50 CHAR),
  request_id      VARCHAR2(64 CHAR),
  enter_time      DATE,
  request_time    DATE,
  process_time    DATE,
  process_status  VARCHAR2(15 CHAR) DEFAULT NULL,
  status_desc     VARCHAR2(2000 CHAR)
)
;

-------------------------------------------------------
--  Indexxxes
--------------------------------------------------------

CREATE INDEX batch_tpid_replace_idx1 ON batch_tpid_replace (process_status, request_time);
CREATE INDEX batch_tpid_replace_idx2 ON batch_tpid_replace (request_id, process_status);

--------------------------------------------------------
--  Constraints for Table BATCH_CHANGE_PRICEPLAN
--------------------------------------------------------

ALTER TABLE batch_tpid_replace ADD CONSTRAINT batch_tpid_replace_101 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD', 'DUPLICATE')) ENABLE NOVALIDATE;

--------------------------------------------------------
--  DDL for Trigger BATCH_CHANGE_PRICEPLAN_TRG1
--------------------------------------------------------

CREATE OR REPLACE TRIGGER batch_tpid_replace_trg1
 BEFORE
  INSERT
 ON batch_tpid_replace
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    v_cnt   NUMBER DEFAULT 0;
BEGIN
  IF INSERTING
  THEN
   SELECT sysdate
   INTO :new.enter_time
   FROM dual;

   IF :new.request_time IS NULL
   THEN
    :new.request_time := :new.enter_time;
   END IF;

   IF :new.process_status IS NULL
   THEN
     :new.process_status := 'WAITING';
   END IF;

   IF :new.request_id IS NULL
   THEN
     :new.request_id := 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD');
   END IF;

  END IF;
 END;
/
ALTER TRIGGER batch_tpid_replace_trg1 ENABLE;

-- Grants for Table
GRANT ALTER ON batch_tpid_replace TO ninjamain
/
GRANT DELETE ON batch_tpid_replace TO ninjamain
/
GRANT INDEX ON batch_tpid_replace TO ninjamain
/
GRANT INSERT ON batch_tpid_replace TO ninjamain
/
GRANT SELECT ON batch_tpid_replace TO ninjamain
/
GRANT UPDATE ON batch_tpid_replace TO ninjamain
/
GRANT REFERENCES ON batch_tpid_replace TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_tpid_replace TO ninjamain
/
GRANT QUERY REWRITE ON batch_tpid_replace TO ninjamain
/
GRANT DEBUG ON batch_tpid_replace TO ninjamain
/
GRANT FLASHBACK ON batch_tpid_replace TO ninjamain
/
GRANT ALTER ON batch_tpid_replace TO ninjateam
/
GRANT DELETE ON batch_tpid_replace TO ninjateam
/
GRANT INDEX ON batch_tpid_replace TO ninjateam
/
GRANT INSERT ON batch_tpid_replace TO ninjateam
/
GRANT SELECT ON batch_tpid_replace TO ninjateam
/
GRANT UPDATE ON batch_tpid_replace TO ninjateam
/
GRANT REFERENCES ON batch_tpid_replace TO ninjateam
/
GRANT ON COMMIT REFRESH ON batch_tpid_replace TO ninjateam
/
GRANT QUERY REWRITE ON batch_tpid_replace TO ninjateam
/
GRANT DEBUG ON batch_tpid_replace TO ninjateam
/
GRANT FLASHBACK ON batch_tpid_replace TO ninjateam
/

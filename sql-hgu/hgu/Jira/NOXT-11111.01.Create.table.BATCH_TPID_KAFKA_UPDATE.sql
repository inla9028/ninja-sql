CREATE TABLE batch_tpid_kafka_update (
  old_tpid          VARCHAR2(50 CHAR),
  tpid              VARCHAR2(50 CHAR),
  request_id        VARCHAR2(64 CHAR),
  enter_time        DATE,
  request_time      DATE,
  process_time      DATE,
  process_status    VARCHAR2(16 CHAR) DEFAULT 'WAITING',
  status_desc       VARCHAR2(2000 CHAR),
  -- PIM...
  contact_type      VARCHAR2(64 CHAR),
  -- Name...
  birth_date        DATE,
  gender            VARCHAR2(64 CHAR),
  pid               VARCHAR2(50 CHAR),
  first_name        VARCHAR2(256 CHAR),
  last_name         VARCHAR2(256 CHAR),
  -- Address
  city              VARCHAR2(256 CHAR),
  country_code      VARCHAR2(64),
  co_name           VARCHAR2(256 CHAR),
  door_number       VARCHAR2(4 CHAR),
  email             VARCHAR2(256 CHAR),
  floor_number      VARCHAR2(2 CHAR),
  house_letter      VARCHAR2(2 CHAR),
  house_number      VARCHAR2(32 CHAR),
  pob               VARCHAR2(16 CHAR),
  pob_name          VARCHAR2(64 CHAR),
  street_name       VARCHAR2(256 CHAR),
  zip_code          VARCHAR2(16 CHAR)
)
;

-------------------------------------------------------
--  Indexxxes
--------------------------------------------------------

CREATE INDEX batch_tpid_kafka_idx1 ON batch_tpid_kafka_update (old_tpid, tpid);
CREATE INDEX batch_tpid_kafka_idx2 ON batch_tpid_kafka_update (process_status, request_time);
CREATE INDEX batch_tpid_kafka_idx3 ON batch_tpid_kafka_update (request_id, process_status);
CREATE INDEX batch_tpid_kafka_gdpr ON batch_tpid_kafka_update (process_time);

--------------------------------------------------------
--  Constraints for Table BATCH_CHANGE_PRICEPLAN
--------------------------------------------------------

ALTER TABLE batch_tpid_kafka_update ADD CONSTRAINT batch_tpid_kafka_update_101 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD', 'DUPLICATE')) ENABLE NOVALIDATE;

--------------------------------------------------------
--  DDL for Trigger batch_tpid_kafka_update_trg1
--------------------------------------------------------

CREATE OR REPLACE TRIGGER batch_tpid_kafka_update_trg1
 BEFORE
  INSERT
 ON batch_tpid_kafka_update
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

  END IF;
 END;
/

ALTER TRIGGER batch_tpid_kafka_update_trg1 ENABLE;

-- Grants for Table
GRANT ALTER ON batch_tpid_kafka_update TO ninjamain
/
GRANT DELETE ON batch_tpid_kafka_update TO ninjamain
/
GRANT INDEX ON batch_tpid_kafka_update TO ninjamain
/
GRANT INSERT ON batch_tpid_kafka_update TO ninjamain
/
GRANT SELECT ON batch_tpid_kafka_update TO ninjamain
/
GRANT UPDATE ON batch_tpid_kafka_update TO ninjamain
/
GRANT REFERENCES ON batch_tpid_kafka_update TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_tpid_kafka_update TO ninjamain
/
GRANT QUERY REWRITE ON batch_tpid_kafka_update TO ninjamain
/
GRANT DEBUG ON batch_tpid_kafka_update TO ninjamain
/
GRANT FLASHBACK ON batch_tpid_kafka_update TO ninjamain
/


GRANT ALTER ON batch_tpid_kafka_update TO ninjateam
/
GRANT DELETE ON batch_tpid_kafka_update TO ninjateam
/
GRANT INDEX ON batch_tpid_kafka_update TO ninjateam
/
GRANT INSERT ON batch_tpid_kafka_update TO ninjateam
/
GRANT SELECT ON batch_tpid_kafka_update TO ninjateam
/
GRANT UPDATE ON batch_tpid_kafka_update TO ninjateam
/
GRANT REFERENCES ON batch_tpid_kafka_update TO ninjateam
/
GRANT ON COMMIT REFRESH ON batch_tpid_kafka_update TO ninjateam
/
GRANT QUERY REWRITE ON batch_tpid_kafka_update TO ninjateam
/
GRANT DEBUG ON batch_tpid_kafka_update TO ninjateam
/
GRANT FLASHBACK ON batch_tpid_kafka_update TO ninjateam
/

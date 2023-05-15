CREATE TABLE batch_tpid_extract (
  ban             NUMBER(9,0), 
  subscriber_no   VARCHAR2(20 CHAR), 
  link_type       VARCHAR2(1 CHAR), 
  comp_reg_id     VARCHAR2(100 CHAR), 
  request_id      VARCHAR2(120 CHAR) NOT NULL ENABLE, 
  request_time    DATE NOT NULL ENABLE, 
  process_status  VARCHAR2(20 CHAR) NOT NULL ENABLE, 
  process_time    DATE, 
  status_desc   VARCHAR2(2000 CHAR), 
	 CONSTRAINT batch_tpid_extract_con2 CHECK ( link_type IN ('B', 'L', 'U')) ENABLE, 
	 CONSTRAINT batch_tpid_extract_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD')) ENABLE
 )
 ;

CREATE INDEX batch_tpid_extract_idx1 ON batch_tpid_extract (request_time, process_status) 
;

CREATE INDEX batch_tpid_extract_idx2 ON batch_tpid_extract (process_status, process_time) 
;

--- Grants for Table
/*
GRANT ALTER ON batch_tpid_extract TO ninjateam
/
GRANT DELETE ON batch_tpid_extract TO ninjateam
/
GRANT INDEX ON batch_tpid_extract TO ninjateam
/
GRANT INSERT ON batch_tpid_extract TO ninjateam
/
GRANT SELECT ON batch_tpid_extract TO ninjateam
/
GRANT UPDATE ON batch_tpid_extract TO ninjateam
/
GRANT REFERENCES ON batch_tpid_extract TO ninjateam
/
*/
GRANT ALTER ON batch_tpid_extract TO ninjamain_at
/
GRANT DELETE ON batch_tpid_extract TO ninjamain_at
/
GRANT INDEX ON batch_tpid_extract TO ninjamain_at
/
GRANT INSERT ON batch_tpid_extract TO ninjamain_at
/
GRANT SELECT ON batch_tpid_extract TO ninjamain_at
/
GRANT UPDATE ON batch_tpid_extract TO ninjamain_at
/
GRANT REFERENCES ON batch_tpid_extract TO ninjamain_at
/
GRANT ON COMMIT REFRESH ON batch_tpid_extract TO ninjamain_at
/
GRANT QUERY REWRITE ON batch_tpid_extract TO ninjamain_at
/
GRANT DEBUG ON batch_tpid_extract TO ninjamain_at
/
GRANT FLASHBACK ON batch_tpid_extract TO ninjamain_at
/


CREATE OR REPLACE TRIGGER batch_tpid_extract_trg
 BEFORE
  INSERT
 ON batch_tpid_extract
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    missing_mandatory_column EXCEPTION;
BEGIN
  IF INSERTING
    THEN
    --== If status of record is null, default it to 'WAITING'
    IF :new.process_status IS NULL THEN
        :new.process_status := 'WAITING';
    END IF;
    --== Ensure we record the created date
    IF :new.request_time IS NULL THEN
        :new.request_time := SYSDATE;
    END IF;
    --== Ensure a user id is set.
    IF :new.request_id IS NULL THEN
        :new.request_id := 'NINJA ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD');
    END IF;
    --== If LINK_TYPE is U, enforce an entry in SUBSCRIBER_NO
    IF (:new.link_type = 'U' AND :new.subscriber_no IS NULL) THEN
        RAISE missing_mandatory_column;
    END IF;
    --==
  END IF;
    EXCEPTION
        WHEN missing_mandatory_column THEN
            raise_application_error(-20000, 'LINK_TYPE = ''U'' requires SUBSCRIBER_NO');
END batch_tpid_extract_trg;
/
ALTER TRIGGER batch_tpid_extract_trg ENABLE;

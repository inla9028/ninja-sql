CREATE TABLE batch_sub_rank_update (
  ban            NUMBER(9),
  subscriber_no  VARCHAR2(20 CHAR),
	enter_time     DATE,
  modify_time    DATE,
	request_time   DATE,
	request_id     VARCHAR2(64 CHAR),
	process_time   DATE,
	process_status VARCHAR2(15 CHAR) DEFAULT NULL,
	status_desc    VARCHAR2(2000 CHAR)
)
;

-------------------------------------------------------
--  Indexxxes
--------------------------------------------------------

CREATE INDEX batch_sub_rank_update_idx1 ON batch_sub_rank_update (process_status, request_time);
CREATE INDEX batch_sub_rank_update_idx2 ON batch_sub_rank_update (request_id, process_status);
CREATE INDEX batch_sub_rank_update_gdpr ON batch_sub_rank_update (process_time);

--------------------------------------------------------
--  Constraints
--------------------------------------------------------

ALTER TABLE batch_sub_rank_update ADD CONSTRAINT batch_sub_rank_update_101 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD', 'DUPLICATE')) ENABLE NOVALIDATE;

--------------------------------------------------------
--  Trigger
--------------------------------------------------------

CREATE OR REPLACE TRIGGER batch_sub_rank_update_trg1
 BEFORE
  INSERT
 ON batch_sub_rank_update
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

  IF UPDATING
  THEN
    :new.modify_time := SYSDATE;
  END IF;
 END;
/
ALTER TRIGGER batch_sub_rank_update_trg1 ENABLE;

-- Grants for Table
GRANT ALTER ON batch_sub_rank_update TO ninjamain
/
GRANT DELETE ON batch_sub_rank_update TO ninjamain
/
GRANT INDEX ON batch_sub_rank_update TO ninjamain
/
GRANT INSERT ON batch_sub_rank_update TO ninjamain
/
GRANT SELECT ON batch_sub_rank_update TO ninjamain
/
GRANT UPDATE ON batch_sub_rank_update TO ninjamain
/
GRANT REFERENCES ON batch_sub_rank_update TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_sub_rank_update TO ninjamain
/
GRANT QUERY REWRITE ON batch_sub_rank_update TO ninjamain
/
GRANT DEBUG ON batch_sub_rank_update TO ninjamain
/
GRANT FLASHBACK ON batch_sub_rank_update TO ninjamain
/
GRANT ALTER ON batch_sub_rank_update TO ninjateam
/
GRANT DELETE ON batch_sub_rank_update TO ninjateam
/
GRANT INDEX ON batch_sub_rank_update TO ninjateam
/
GRANT INSERT ON batch_sub_rank_update TO ninjateam
/
GRANT SELECT ON batch_sub_rank_update TO ninjateam
/
GRANT UPDATE ON batch_sub_rank_update TO ninjateam
/
GRANT REFERENCES ON batch_sub_rank_update TO ninjateam
/
GRANT ON COMMIT REFRESH ON batch_sub_rank_update TO ninjateam
/
GRANT QUERY REWRITE ON batch_sub_rank_update TO ninjateam
/
GRANT DEBUG ON batch_sub_rank_update TO ninjateam
/
GRANT FLASHBACK ON batch_sub_rank_update TO ninjateam
/

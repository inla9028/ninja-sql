CREATE TABLE batch_sim_release
    (sim_no                  VARCHAR2(20 CHAR),
     update_db               VARCHAR2(1 CHAR),
     dealer                  VARCHAR2(6 CHAR),
     sales_agent             VARCHAR2(6 CHAR),
     request_id              VARCHAR2(60 CHAR),
     request_time            DATE,
     record_creation_date    DATE,
     process_status          VARCHAR2(20 CHAR),
     process_time            DATE,
     status_desc             VARCHAR2(2000 CHAR))
/

-- Grants for Table
GRANT ALTER ON batch_sim_release TO ninjateam
/
GRANT DELETE ON batch_sim_release TO ninjateam
/
GRANT INDEX ON batch_sim_release TO ninjateam
/
GRANT INSERT ON batch_sim_release TO ninjateam
/
GRANT SELECT ON batch_sim_release TO ninjateam
/
GRANT UPDATE ON batch_sim_release TO ninjateam
/
GRANT REFERENCES ON batch_sim_release TO ninjateam
/
GRANT ALTER ON batch_sim_release TO ninjamain
/
GRANT DELETE ON batch_sim_release TO ninjamain
/
GRANT INDEX ON batch_sim_release TO ninjamain
/
GRANT INSERT ON batch_sim_release TO ninjamain
/
GRANT SELECT ON batch_sim_release TO ninjamain
/
GRANT UPDATE ON batch_sim_release TO ninjamain
/
GRANT REFERENCES ON batch_sim_release TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_sim_release TO ninjamain
/
GRANT QUERY REWRITE ON batch_sim_release TO ninjamain
/
GRANT DEBUG ON batch_sim_release TO ninjamain
/
GRANT FLASHBACK ON batch_sim_release TO ninjamain
/




-- Indexes for batch_sim_release

CREATE INDEX batch_sim_release_idx1 ON batch_sim_release
  (
    request_id                      ASC,
    process_status                  ASC
  )
/

CREATE INDEX batch_sim_release_idx2 ON batch_sim_release
  (
    process_status                  ASC,
    process_time                    ASC
  )
/

CREATE INDEX batch_sim_release_idx3 ON batch_sim_release
  (
    sim_no                          ASC
  )
/



-- Constraints for batch_sim_release

ALTER TABLE batch_sim_release
ADD CONSTRAINT batch_sim_release_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_FATAL', 'ON_HOLD'))
ENABLE NOVALIDATE
/

ALTER TABLE batch_sim_release
ADD CHECK ("SIM_NO" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_sim_release
ADD CHECK ("PROCESS_STATUS" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_sim_release
ADD CHECK ("RECORD_CREATION_DATE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_sim_release
ADD CHECK ("REQUEST_ID" IS NOT NULL)
ENABLE NOVALIDATE
/

-- Triggers for batch_sim_release

CREATE OR REPLACE TRIGGER batch_sim_release_trg1
 BEFORE
  INSERT
 ON batch_sim_release
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF INSERTING
    THEN
        IF :new.process_status IS NULL THEN
            :new.process_status := 'WAITING';
        END IF;
        IF :new.record_creation_date IS NULL THEN
            :new.record_creation_date := SYSDATE;
        END IF; 
        IF :new.request_time IS NULL THEN
            :new.request_time := SYSDATE;
        END IF; 
    END IF;
END;
/


-- Comments for batch_sim_release

COMMENT ON COLUMN batch_sim_release.process_status IS 'Current status of record (starts with WAITING)'
/
COMMENT ON COLUMN batch_sim_release.process_time IS 'Date and time of processing'
/
COMMENT ON COLUMN batch_sim_release.update_db IS 'If ''Y'', Ninja will update table SERIAL_ITEM_INV prior to releasing the SIM'
/
COMMENT ON COLUMN batch_sim_release.record_creation_date IS 'Date record added'
/
COMMENT ON COLUMN batch_sim_release.request_id IS 'Some kind of information about what or how requested this'
/
COMMENT ON COLUMN batch_sim_release.status_desc IS 'Description of status (used in case of errors)'
/
COMMENT ON COLUMN batch_sim_release.sim_no IS 'SIM number to release'
/


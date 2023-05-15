-- Start of DDL Script for Sequence ninjaatdata.BATCH_NAME_ADDRESS_TRX_SEQ
-- Generated 2007-03-16 13:57:26 from ninjaatdata@NINJAPROD1

CREATE SEQUENCE batch_pub_lvl_update_trx_seq
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999
  NOCYCLE
  ORDER
  CACHE 20
/


-- End of DDL Script for Sequence ninjaatdata.BATCH_NAME_ADDRESS_TRX_SEQ

CREATE TABLE batch_publishlevel_update
    (transaction_number             NUMBER(9,0) NOT NULL,
    subscriber_no                  VARCHAR2(20) NOT NULL,
    publish_level                  VARCHAR2(1) NOT NULL,
    process_status                 VARCHAR2(20) NOT NULL,
    process_time                   DATE,
    status_desc                    VARCHAR2(2000),
    record_creation_date           DATE NOT NULL,
    request_id                     VARCHAR2(30) NOT NULL,
    request_user_id                VARCHAR2(30) NOT NULL)
/

-- Grants for Table
GRANT ALTER ON batch_publishlevel_update TO ninjamain
/
GRANT DELETE ON batch_publishlevel_update TO ninjamain
/
GRANT INDEX ON batch_publishlevel_update TO ninjamain
/
GRANT INSERT ON batch_publishlevel_update TO ninjamain
/
GRANT SELECT ON batch_publishlevel_update TO ninjamain
/
GRANT UPDATE ON batch_publishlevel_update TO ninjamain
/
GRANT REFERENCES ON batch_publishlevel_update TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_publishlevel_update TO ninjamain
/
GRANT QUERY REWRITE ON batch_publishlevel_update TO ninjamain
/
GRANT DEBUG ON batch_publishlevel_update TO ninjamain
/
GRANT FLASHBACK ON batch_publishlevel_update TO ninjamain
/
GRANT ALTER ON batch_publishlevel_update TO ninjateam
/
GRANT DELETE ON batch_publishlevel_update TO ninjateam
/
GRANT INDEX ON batch_publishlevel_update TO ninjateam
/
GRANT INSERT ON batch_publishlevel_update TO ninjateam
/
GRANT SELECT ON batch_publishlevel_update TO ninjateam
/
GRANT UPDATE ON batch_publishlevel_update TO ninjateam
/
GRANT REFERENCES ON batch_publishlevel_update TO ninjateam
/

-- Indexes for batch_publishlevel_update

CREATE INDEX batch_publishlevel_update_idx1 ON batch_publishlevel_update
  (
    record_creation_date            ASC,
    process_status                  ASC
  )
/

CREATE INDEX batch_publishlevel_update_idx2 ON batch_publishlevel_update
  (
    process_status                  ASC,
    process_time                    ASC
  )
/

CREATE INDEX batch_publishlevel_update_idx3 ON batch_publishlevel_update
  (
    subscriber_no                   ASC
  )
/

-- Constraints for batch_publishlevel_update

ALTER TABLE batch_publishlevel_update
ADD CONSTRAINT batch_publishlevel_update_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_FATAL', 'ON_HOLD'))
/

ALTER TABLE batch_publishlevel_update
ADD CONSTRAINT batch_publishlevel_update_pk PRIMARY KEY (transaction_number)
USING INDEX
/


-- Triggers for batch_publishlevel_update

CREATE OR REPLACE TRIGGER batch_publishlevel_update_trg1
 BEFORE
  INSERT
 ON batch_publishlevel_update
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    v_cnt1 NUMBER;
BEGIN
	IF INSERTING
	THEN
    -- Ensure that the unique id is updated correctly
	SELECT	BATCH_PUB_LVL_UPDATE_TRX_SEQ.NEXTVAL	
	INTO	:new.transaction_number
	FROM	dual;	

      -- If status of record is null, default it to 'WAITING'
      IF :new.process_status IS NULL THEN
          :new.process_status := 'WAITING';
      END IF;

      IF :new.record_creation_date IS NULL THEN
          :new.record_creation_date := sysdate;
      END IF;	
      
  END IF;
END;
/


-- Comments for batch_publishlevel_update

COMMENT ON COLUMN batch_publishlevel_update.publish_level IS 'Publish Level for the subscriber'
/
COMMENT ON COLUMN batch_publishlevel_update.process_status IS 'Current status of record (starts with WAITING)'
/
COMMENT ON COLUMN batch_publishlevel_update.process_time IS 'Date and time of processing'
/
COMMENT ON COLUMN batch_publishlevel_update.record_creation_date IS 'Date record added'
/
COMMENT ON COLUMN batch_publishlevel_update.request_id IS 'Some kind of information about what or how requested this'
/
COMMENT ON COLUMN batch_publishlevel_update.request_user_id IS 'User information'
/
COMMENT ON COLUMN batch_publishlevel_update.status_desc IS 'Description of status (used in case of errors)'
/
COMMENT ON COLUMN batch_publishlevel_update.subscriber_no IS 'Subscriber number in format "GSM047..."'
/
COMMENT ON COLUMN batch_publishlevel_update.transaction_number IS 'Transaction number of record - automatically updated'
/

CREATE SYNONYM ninjamain.batch_publishlevel_update
  FOR NINJADATA.BATCH_PUBLISHLEVEL_UPDATE
/

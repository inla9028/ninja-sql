CREATE TABLE batch_send_sms
(
    from_number      VARCHAR2 (20 BYTE),
    from_text        VARCHAR2 (20 BYTE),
    recipient        VARCHAR2 (20 BYTE),
    attempts         NUMBER (9, 0),
    text             VARCHAR2 (480 BYTE),
    send_date        DATE,
    enter_time       DATE,
    request_time     DATE,
    process_time     DATE,
    process_status   VARCHAR2 (15 BYTE),
    status_desc      VARCHAR2 (2000 BYTE),
    request_id       VARCHAR2 (30 BYTE)
)
/

-- Grants for Table
GRANT ALTER ON batch_send_sms TO ninjateam
/
GRANT DELETE ON batch_send_sms TO ninjateam
/
GRANT INDEX ON batch_send_sms TO ninjateam
/
GRANT INSERT ON batch_send_sms TO ninjateam
/
GRANT SELECT ON batch_send_sms TO ninjateam
/
GRANT UPDATE ON batch_send_sms TO ninjateam
/
GRANT REFERENCES ON batch_send_sms TO ninjateam
/
GRANT ALTER ON batch_send_sms TO ninjamaster
/
GRANT DELETE ON batch_send_sms TO ninjamaster
/
GRANT INDEX ON batch_send_sms TO ninjamaster
/
GRANT INSERT ON batch_send_sms TO ninjamaster
/
GRANT SELECT ON batch_send_sms TO ninjamaster
/
GRANT UPDATE ON batch_send_sms TO ninjamaster
/
GRANT REFERENCES ON batch_send_sms TO ninjamaster
/
GRANT ON COMMIT REFRESH   ON batch_send_sms TO ninjamaster
/
GRANT QUERY REWRITE   ON batch_send_sms TO ninjamaster
/
GRANT DEBUG ON batch_send_sms TO ninjamaster
/
GRANT FLASHBACK   ON batch_send_sms TO ninjamaster
/
GRANT ALTER ON batch_send_sms TO ninjamain
/
GRANT DELETE ON batch_send_sms TO ninjamain
/
GRANT INDEX ON batch_send_sms TO ninjamain
/
GRANT INSERT ON batch_send_sms TO ninjamain
/
GRANT SELECT ON batch_send_sms TO ninjamain
/
GRANT UPDATE ON batch_send_sms TO ninjamain
/
GRANT REFERENCES ON batch_send_sms TO ninjamain
/
GRANT ON COMMIT REFRESH   ON batch_send_sms TO ninjamain
/
GRANT QUERY REWRITE   ON batch_send_sms TO ninjamain
/
GRANT DEBUG ON batch_send_sms TO ninjamain
/
GRANT FLASHBACK   ON batch_send_sms TO ninjamain
/
GRANT SELECT ON batch_send_sms TO ks_user
/
GRANT ALTER ON batch_send_sms TO kontant
/
GRANT DELETE ON batch_send_sms TO kontant
/
GRANT INDEX ON batch_send_sms TO kontant
/
GRANT INSERT ON batch_send_sms TO kontant
/
GRANT SELECT ON batch_send_sms TO kontant
/
GRANT UPDATE ON batch_send_sms TO kontant
/
GRANT REFERENCES ON batch_send_sms TO kontant
/
GRANT ON COMMIT REFRESH   ON batch_send_sms TO kontant
/
GRANT QUERY REWRITE   ON batch_send_sms TO kontant
/
GRANT DEBUG ON batch_send_sms TO kontant
/
GRANT FLASHBACK   ON batch_send_sms TO kontant
/
GRANT SELECT ON batch_send_sms TO readonly
/

-- Indexes for batch_send_sms

CREATE INDEX batch_send_sms_idx1
    ON batch_send_sms (process_status ASC, request_time ASC)
/

CREATE INDEX batch_send_sms_idx2
    ON batch_send_sms (recipient ASC)
/

CREATE INDEX batch_send_sms_idx3
    ON batch_send_sms (request_id ASC, process_status ASC)
/

CREATE INDEX batch_send_sms_idx4
    ON batch_send_sms (enter_time ASC)
/


-- Constraints for batch_send_sms

ALTER TABLE batch_send_sms
ADD CONSTRAINT batch_send_sms_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_FATAL','ON_HOLD'))
ENABLE NOVALIDATE
/

ALTER TABLE batch_send_sms
ADD CONSTRAINT batch_send_sms_con2 CHECK ( from_number IS NOT NULL OR from_text IS NOT NULL )
ENABLE NOVALIDATE
/

-- Triggers for batch_send_sms

CREATE OR REPLACE TRIGGER batch_send_sms_trg1
    BEFORE INSERT
    ON batch_send_sms
    REFERENCING NEW AS new OLD AS old
    FOR EACH ROW
DECLARE
    v_success_count   NUMBER DEFAULT 0;
    v_error_count     NUMBER DEFAULT 0;
    v_tmp_trans_seq   NUMBER DEFAULT 0;
BEGIN
    IF INSERTING
    THEN
        SELECT SYSDATE INTO :new.enter_time FROM DUAL;

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
            :new.request_id := TO_CHAR (SYSDATE, 'YYYY-MM-DD');
        END IF;

        IF :new.attempts IS NULL
        THEN
            :new.attempts := 0;
        END IF;
    END IF;
END;
/

-- Comments for batch_send_sms

COMMENT ON TABLE batch_send_sms IS 'Contains records to send SMSes by BatchSendSMS. Originally, this was a backup, in case Prepaid DB was unavailable....'
/
COMMENT ON COLUMN batch_send_sms.from_number IS 'If the sender is a phone number, it goes here.'
/
COMMENT ON COLUMN batch_send_sms.from_text IS 'If the sender is in ASCII, for example "NETCOM", it goes here. If FROM_NUMBER is present, this is ignored.'
/
COMMENT ON COLUMN batch_send_sms.recipient IS 'The receipient of the SMS'
/
COMMENT ON COLUMN batch_send_sms.attempts IS 'The current number of attempts since the record was created.'
/
COMMENT ON COLUMN batch_send_sms.text IS 'The actual SMS message to send (480 bytes, same as column in Prepaid DB)'
/
COMMENT ON COLUMN batch_send_sms.send_date IS 'If the SMS was requested for a certain date (in the future?)'
/
COMMENT ON COLUMN batch_send_sms.enter_time IS 'The time this row was created'
/
COMMENT ON COLUMN batch_send_sms.request_time IS 'If this row is requested for future scheduling in Ninja DB, rather than in Prepaid DB...'
/
COMMENT ON COLUMN batch_send_sms.process_time IS 'The time when this row was (finally) processed.'
/
COMMENT ON COLUMN batch_send_sms.process_status IS 'The state of the processing, default is "WAITING", also valid are "IN_PROGRESS", "PRSD_SUCCESS", "PRSD_ERROR", "PRSD_FATAL" & "ON_HOLD"'
/
COMMENT ON COLUMN batch_send_sms.status_desc IS 'A description of the status, in case of errors...'
/
COMMENT ON COLUMN batch_send_sms.request_id IS 'An id for this request, if requested manually. Default is the current date in ISO format.'
/

-- End of DDL Script for Table NINJADATA.batch_send_sms

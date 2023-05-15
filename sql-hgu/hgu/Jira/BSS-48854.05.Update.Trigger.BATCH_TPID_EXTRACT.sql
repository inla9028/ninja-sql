CREATE OR REPLACE TRIGGER batch_tpid_extract_trg
 BEFORE
  INSERT
 ON batch_tpid_extract
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    missing_mandatory_column exception;
    account_type             VARCHAR2(1 CHAR);
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
--    --== Only accept certain account-types.
--    IF :new.ban IS NOT NULL AND :new.process_status = 'WAITING' THEN
--        SELECT ba.account_type
--          INTO account_type
--          FROM billing_account@fokus ba
--         WHERE ba.ban = :new.ban;
--        --
--        IF account_type NOT IN ( 'I' ) THEN
--            :new.process_status := 'PRSD_SUCCESS';
--            :new.status_desc    := 'Account Type = ' || account_type || '; Ignored by Trigger';
--        END IF;
--    END IF;
    --==
  END IF;
    EXCEPTION
        WHEN missing_mandatory_column THEN
            raise_application_error(-20000, 'LINK_TYPE = ''U'' requires SUBSCRIBER_NO');
END batch_tpid_extract_trg;
/
ALTER TRIGGER batch_tpid_extract_trg ENABLE;

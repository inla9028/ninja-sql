-- Triggers for party_manager_events

CREATE OR REPLACE TRIGGER party_manager_events_trg
 BEFORE
  INSERT
 ON party_manager_events
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    missing_mandatory_column EXCEPTION;
BEGIN
  IF INSERTING
    THEN
    --== Enforce the uniqueness of the request id.
    SELECT party_manager_events_seq.nextval
      INTO :new.request_id
      FROM dual;
    --== If status of record is null, default it to 'WAITING'
    IF :new.process_status IS NULL THEN
        :new.process_status := 'WAITING';
    END IF;
    --== If SP BAN, ignore.
    IF :new.account_type = 'S' THEN
        :new.process_status := 'PRSD_SUCCESS';
        :new.status_desc    := 'ServiceProvider; Ignored by Trigger';
    END IF;
    --== Filter account-types.
    IF :new.account_type NOT IN ( 'I', 'P' ) THEN
        :new.process_status := 'PRSD_SUCCESS';
        :new.status_desc    := 'Account Type = ' || :new.account_type || '; Ignored by Trigger';
    END IF;
    IF (:new.account_type IN ( 'P' ) AND :new.link_type NOT IN ( 'U' )) THEN
        :new.process_status := 'PRSD_SUCCESS';
        :new.status_desc    := 'Account Type = ' || :new.account_type || ' + Link Type = ' || :new.link_type || '; Ignored by Trigger';
    END IF;
    --== Ensure we record the created date
    IF :new.request_time IS NULL THEN
        :new.request_time := SYSDATE;
    END IF;
    --== Ensure a user id is set.
    IF :new.request_user_id IS NULL THEN
        :new.request_user_id := 'NINJA ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD');
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
END party_manager_events_trg;
/

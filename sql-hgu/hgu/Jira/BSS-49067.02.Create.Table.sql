--DROP TABLE party_manager_events PURGE;

CREATE TABLE party_manager_events (
    request_id                     NUMBER(10,0) NOT NULL,
    action_type                    VARCHAR2(1 CHAR),
    customer_id                    NUMBER(9,0),
    account_type                   VARCHAR2(1 CHAR),
    account_sub_type               VARCHAR2(2 CHAR),
    subscriber_no                  VARCHAR2(20 CHAR),
    link_type                      VARCHAR2(1 CHAR),
    old_comp_reg_id                VARCHAR2(50 CHAR),
    comp_reg_id                    VARCHAR2(50 CHAR),
    old_tpid                       VARCHAR2(36 CHAR),
    tpid                           VARCHAR2(36 CHAR),
    old_birth_date                 DATE,
    birth_date                     DATE,
    old_status                     VARCHAR2(1 CHAR),
    status                         VARCHAR2(1 CHAR),
    name_format                    VARCHAR2(1 CHAR),
    old_first_name                 VARCHAR2(32 CHAR),
    first_name                     VARCHAR2(32 CHAR),
    old_last_business_name         VARCHAR2(60 CHAR),
    last_business_name             VARCHAR2(60 CHAR),
    old_email                      VARCHAR2(150 CHAR),
    email                          VARCHAR2(150 CHAR),
    old_customer_telno             VARCHAR2(20 CHAR),
    customer_telno                 VARCHAR2(20 CHAR),
    request_time                   DATE NOT NULL,
    process_time                   DATE,
    process_status                 VARCHAR2(20 CHAR) NOT NULL,
    request_user_id                VARCHAR2(120 CHAR) NOT NULL,
    status_desc                    VARCHAR2(2000 CHAR)
)
/

-- Grants for Table
/*
GRANT ALTER ON party_manager_events TO ninjateam
/
GRANT DELETE ON party_manager_events TO ninjateam
/
GRANT INDEX ON party_manager_events TO ninjateam
/
GRANT INSERT ON party_manager_events TO ninjateam
/
GRANT SELECT ON party_manager_events TO ninjateam
/
GRANT UPDATE ON party_manager_events TO ninjateam
/
GRANT REFERENCES ON party_manager_events TO ninjateam
/
*/
GRANT ALTER ON party_manager_events TO ninjamain_at
/
GRANT DELETE ON party_manager_events TO ninjamain_at
/
GRANT INDEX ON party_manager_events TO ninjamain_at
/
GRANT INSERT ON party_manager_events TO ninjamain_at
/
GRANT SELECT ON party_manager_events TO ninjamain_at
/
GRANT UPDATE ON party_manager_events TO ninjamain_at
/
GRANT REFERENCES ON party_manager_events TO ninjamain_at
/
GRANT ON COMMIT REFRESH ON party_manager_events TO ninjamain_at
/
GRANT QUERY REWRITE ON party_manager_events TO ninjamain_at
/
GRANT DEBUG ON party_manager_events TO ninjamain_at
/
GRANT FLASHBACK ON party_manager_events TO ninjamain_at
/


CREATE INDEX party_manager_events_idx1 ON party_manager_events
  (
    request_time                    ASC,
    process_status                  ASC
  )
/


CREATE INDEX party_manager_events_idx2 ON party_manager_events
  (
    process_status                  ASC,
    process_time                    ASC
  )
/

/*
CREATE INDEX gdpr_idx_ban_party_manager_events ON party_manager_events
  (
    customer_id                     ASC
  )
/

CREATE INDEX gdpr_idx_sub_party_manager_events ON party_manager_events
  (
    subscriber_no                   ASC
  )
/
*/

-- Constraints for party_manager_events

ALTER TABLE party_manager_events
ADD CONSTRAINT party_manager_events_con3 CHECK ( name_format IN ('C', 'I'))
/

ALTER TABLE party_manager_events
ADD CONSTRAINT party_manager_events_con2 CHECK ( link_type IN ('B', 'C' ,'L', 'U'))
/

ALTER TABLE party_manager_events
ADD CONSTRAINT party_manager_events_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

ALTER TABLE party_manager_events
ADD CONSTRAINT party_manager_events_pk PRIMARY KEY (request_id)
USING INDEX
/

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
        :new.status_desc    := 'ServiceProvider (Ignored)';
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


-- End of DDL Script for Table NINJADATA.party_manager_events

CREATE TABLE party_mgr_pid_update (
    request_id                     NUMBER(10,0) NOT NULL,
    action_type                    VARCHAR2(1 CHAR),
    customer_id                    NUMBER(9,0),
    subscriber_no                  VARCHAR2(20 CHAR),
    link_type                      VARCHAR2(1 CHAR),
    comp_reg_id                    VARCHAR2(100 CHAR),
    prev_comp_reg_id               VARCHAR2(100 CHAR),
    birth_date                     DATE,
    name_format                    VARCHAR2(1 CHAR),
    first_name                     VARCHAR2(32 CHAR),
    middle_name                    VARCHAR2(60 CHAR),
    last_business_name             VARCHAR2(60 CHAR),
    request_time                   DATE NOT NULL,
    process_time                   DATE,
    process_status                 VARCHAR2(20 CHAR) NOT NULL,
    request_user_id                VARCHAR2(120 CHAR) NOT NULL,
    status_desc                    VARCHAR2(2000 CHAR)
)
/

-- Grants for Table
/*
GRANT ALTER ON party_mgr_pid_update TO ninjateam
/
GRANT DELETE ON party_mgr_pid_update TO ninjateam
/
GRANT INDEX ON party_mgr_pid_update TO ninjateam
/
GRANT INSERT ON party_mgr_pid_update TO ninjateam
/
GRANT SELECT ON party_mgr_pid_update TO ninjateam
/
GRANT UPDATE ON party_mgr_pid_update TO ninjateam
/
GRANT REFERENCES ON party_mgr_pid_update TO ninjateam
/
*/
GRANT ALTER ON party_mgr_pid_update TO ninjamain
/
GRANT DELETE ON party_mgr_pid_update TO ninjamain
/
GRANT INDEX ON party_mgr_pid_update TO ninjamain
/
GRANT INSERT ON party_mgr_pid_update TO ninjamain
/
GRANT SELECT ON party_mgr_pid_update TO ninjamain
/
GRANT UPDATE ON party_mgr_pid_update TO ninjamain
/
GRANT REFERENCES ON party_mgr_pid_update TO ninjamain
/
GRANT ON COMMIT REFRESH ON party_mgr_pid_update TO ninjamain
/
GRANT QUERY REWRITE ON party_mgr_pid_update TO ninjamain
/
GRANT DEBUG ON party_mgr_pid_update TO ninjamain
/
GRANT FLASHBACK ON party_mgr_pid_update TO ninjamain
/


CREATE INDEX party_mgr_pid_update_idx1 ON party_mgr_pid_update
  (
    request_time                    ASC,
    process_status                  ASC
  )
/

CREATE INDEX party_mgr_pid_update_idx2 ON party_mgr_pid_update
  (
    process_status                  ASC,
    process_time                    ASC
  )
/

/*
CREATE INDEX gdpr_idx_ban_party_mgr_pid_update ON party_mgr_pid_update
  (
    customer_id                     ASC
  )
/

CREATE INDEX gdpr_idx_sub_party_mgr_pid_update ON party_mgr_pid_update
  (
    subscriber_no                   ASC
  )
/
*/

-- Constraints for party_mgr_pid_update

ALTER TABLE party_mgr_pid_update
ADD CONSTRAINT party_mgr_pid_update_con3 CHECK ( name_format IN ('C', 'I'))
/

ALTER TABLE party_mgr_pid_update
ADD CONSTRAINT party_mgr_pid_update_con2 CHECK ( link_type IN ('B', 'L', 'U'))
/

ALTER TABLE party_mgr_pid_update
ADD CONSTRAINT party_mgr_pid_update_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

ALTER TABLE party_mgr_pid_update
ADD CONSTRAINT party_mgr_pid_update_pk PRIMARY KEY (request_id)
USING INDEX
/

-- Triggers for party_mgr_pid_update

CREATE OR REPLACE TRIGGER party_mgr_pid_update_trg
 BEFORE
  INSERT
 ON party_mgr_pid_update
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    missing_mandatory_column EXCEPTION;
BEGIN
  IF INSERTING
    THEN
    --== Enforce the uniqueness of the request id.
    SELECT party_mgr_pid_update_seq.nextval
      INTO :new.request_id
      FROM dual;
    --== If status of record is null, default it to 'WAITING'
    IF :new.process_status IS NULL THEN
        :new.process_status := 'WAITING';
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
END party_mgr_pid_update_trg;
/


-- End of DDL Script for Table NINJADATA.party_mgr_pid_update


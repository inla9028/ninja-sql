-- Start of DDL Script for Table NINJADATA.hgu_dsp_request
-- Generated 2018-02-13 10:18:08 from NINJADATA@NINJAPROD1

CREATE TABLE hgu_dsp_request
    (request_id                     NUMBER(10,0),
    customer_id                    NUMBER(9,0),
    adr_first_name                 VARCHAR2(32 BYTE) NOT NULL,
    adr_last_name                  VARCHAR2(60 BYTE) NOT NULL,
    adr_birth_date                 DATE NOT NULL,
    adr_zip                        VARCHAR2(9 BYTE),
    record_creation_date           DATE NOT NULL,
    process_status                 VARCHAR2(20 BYTE) NOT NULL,
    request_user_id                VARCHAR2(30 BYTE) NOT NULL,
    process_time                   DATE,
    status_desc                    VARCHAR2(2000 BYTE))
/

-- Grants for Table
GRANT ALTER ON hgu_dsp_request TO ninjateam
/
GRANT DELETE ON hgu_dsp_request TO ninjateam
/
GRANT INDEX ON hgu_dsp_request TO ninjateam
/
GRANT INSERT ON hgu_dsp_request TO ninjateam
/
GRANT SELECT ON hgu_dsp_request TO ninjateam
/
GRANT UPDATE ON hgu_dsp_request TO ninjateam
/
GRANT REFERENCES ON hgu_dsp_request TO ninjateam
/
GRANT ALTER ON hgu_dsp_request TO ninjamain
/
GRANT DELETE ON hgu_dsp_request TO ninjamain
/
GRANT INDEX ON hgu_dsp_request TO ninjamain
/
GRANT INSERT ON hgu_dsp_request TO ninjamain
/
GRANT SELECT ON hgu_dsp_request TO ninjamain
/
GRANT UPDATE ON hgu_dsp_request TO ninjamain
/
GRANT REFERENCES ON hgu_dsp_request TO ninjamain
/
GRANT ON COMMIT REFRESH ON hgu_dsp_request TO ninjamain
/
GRANT QUERY REWRITE ON hgu_dsp_request TO ninjamain
/
GRANT DEBUG ON hgu_dsp_request TO ninjamain
/
GRANT FLASHBACK ON hgu_dsp_request TO ninjamain
/




-- Indexes for hgu_dsp_request

CREATE INDEX hgu_dsp_request_idx1 ON hgu_dsp_request
  (
    adr_first_name                  ASC
  )
/

CREATE INDEX hgu_dsp_request_idx2 ON hgu_dsp_request
  (
   adr_last_name                    ASC
  )
/

CREATE INDEX hgu_dsp_request_idx3 ON hgu_dsp_request
  (
    request_user_id                 ASC
  )
/

CREATE INDEX gdpr_idx_ban_hgu_dsp_request ON hgu_dsp_request
  (
    customer_id                     ASC
  )
/



-- Constraints for hgu_dsp_request

ALTER TABLE hgu_dsp_request
ADD CONSTRAINT hgu_dsp_request_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

CREATE OR REPLACE TRIGGER hgu_dsp_request_trg
 BEFORE
  INSERT
 ON hgu_dsp_request
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    updating_key_fields EXCEPTION;
BEGIN
  IF INSERTING
    THEN
    --== Enforce the uniqueness of the request id.
    /*
    SELECT dsp_request_seq.nextval
      INTO :new.request_id
      FROM dual;
    */
    --== If status of record is null, default it to 'WAITING'
    IF :new.process_status IS NULL THEN
        :new.process_status := 'WAITING';
    END IF;
    --== Ensure we record the created date
    IF :new.record_creation_date IS NULL THEN
        :new.record_creation_date := SYSDATE;
    END IF;
    --== Ensure a user id is set.
    IF :new.request_user_id IS NULL THEN
        :new.request_user_id := 'NINJA ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD');
    END IF;
  END IF;
    EXCEPTION
        WHEN updating_key_fields THEN
            raise_application_error(-20300, 'NinjaDB Error: cannot update key fields of source table.');
END hgu_dsp_request_trg;
/

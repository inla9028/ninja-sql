-- Start of DDL Script for Table NINJADATA.hgu_dsp_response
-- Generated 2018-02-21 08:38:36 from NINJADATA@NINJAPROD1

CREATE TABLE hgu_dsp_response
    (request_id                     NUMBER(10,0) NOT NULL,
     request_user_id                VARCHAR2(120 CHAR),
    adr_last_name                  VARCHAR2(60 BYTE),
    adr_first_name                 VARCHAR2(32 BYTE),
    adr_birth_date                 VARCHAR2(8 BYTE),
    adr_city                       VARCHAR2(39 BYTE),
    adr_zip                        VARCHAR2(9 BYTE),
    adr_house_no                   VARCHAR2(20 BYTE),
    adr_street_name                VARCHAR2(60 BYTE),
    adr_pob                        VARCHAR2(20 BYTE),
    adr_country                    VARCHAR2(3 BYTE),
    adr_house_letter               VARCHAR2(2 BYTE),
    adr_storey                     VARCHAR2(2 BYTE),
    adr_door_no                    VARCHAR2(4 BYTE),
    adr_district                   VARCHAR2(40 BYTE),
    adr_gender                     VARCHAR2(1 BYTE),
    adr_stat                       VARCHAR2(10 BYTE),
    dsp_id                         VARCHAR2(20 BYTE),
    record_creation_date           DATE NOT NULL,
    process_status                 VARCHAR2(20 BYTE) NOT NULL,
    process_time                   DATE,
    status_desc                    VARCHAR2(2000 BYTE))
/

-- Grants for Table
GRANT ALTER ON hgu_dsp_response TO ninjateam
/
GRANT DELETE ON hgu_dsp_response TO ninjateam
/
GRANT INDEX ON hgu_dsp_response TO ninjateam
/
GRANT INSERT ON hgu_dsp_response TO ninjateam
/
GRANT SELECT ON hgu_dsp_response TO ninjateam
/
GRANT UPDATE ON hgu_dsp_response TO ninjateam
/
GRANT REFERENCES ON hgu_dsp_response TO ninjateam
/
GRANT ALTER ON hgu_dsp_response TO ninjamain
/
GRANT DELETE ON hgu_dsp_response TO ninjamain
/
GRANT INDEX ON hgu_dsp_response TO ninjamain
/
GRANT INSERT ON hgu_dsp_response TO ninjamain
/
GRANT SELECT ON hgu_dsp_response TO ninjamain
/
GRANT UPDATE ON hgu_dsp_response TO ninjamain
/
GRANT REFERENCES ON hgu_dsp_response TO ninjamain
/
GRANT ON COMMIT REFRESH ON hgu_dsp_response TO ninjamain
/
GRANT QUERY REWRITE ON hgu_dsp_response TO ninjamain
/
GRANT DEBUG ON hgu_dsp_response TO ninjamain
/
GRANT FLASHBACK ON hgu_dsp_response TO ninjamain
/




-- Indexes for hgu_dsp_response

CREATE INDEX hgu_dsp_response_idx1 ON hgu_dsp_response
  (
    process_status                  ASC
  )
/

CREATE INDEX hgu_dsp_response_idx2 ON hgu_dsp_response
  (
    request_user_id                 ASC
  )
/



-- Constraints for hgu_dsp_response

ALTER TABLE hgu_dsp_response
ADD CONSTRAINT hgu_dsp_response_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

ALTER TABLE hgu_dsp_response
ADD CONSTRAINT hgu_dsp_response_pk PRIMARY KEY (request_id)
USING INDEX
/


-- Triggers for hgu_dsp_response

CREATE OR REPLACE TRIGGER hgu_dsp_response_trg
 BEFORE
  INSERT
 ON hgu_dsp_response
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    updating_key_fields EXCEPTION;
BEGIN
  IF INSERTING
    THEN
    --== If status of record is null, default it to 'WAITING'
    IF :new.process_status IS NULL THEN
        :new.process_status := 'WAITING';
    END IF;
    --== Ensure we record the created date
    IF :new.record_creation_date IS NULL THEN
        :new.record_creation_date := SYSDATE;
    END IF;
  END IF;
    EXCEPTION
        WHEN updating_key_fields THEN
            raise_application_error(-20300, 'NinjaDB Error: cannot update key fields of source table.');
END hgu_dsp_response_trg;
/


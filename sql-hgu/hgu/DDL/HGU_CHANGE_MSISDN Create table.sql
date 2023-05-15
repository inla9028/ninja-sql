CREATE TABLE hgu_change_msisdn
    (subscriber_no                  VARCHAR2(18 CHAR) NOT NULL,
     dealer_code                    VARCHAR2(5 CHAR),
     num_loc                        VARCHAR2(3 CHAR),
     num_group                      VARCHAR2(3 CHAR),
     num_length                     NUMBER DEFAULT ON NULL 12,
     physical_hlr                   VARCHAR2(3 CHAR),
     ctn                            VARCHAR2(18 CHAR),
     process_status                 VARCHAR2(20 CHAR) NOT NULL,
     process_time                   DATE,
     status_desc                    VARCHAR2(4000 BYTE))
/

-- Grants for Table
GRANT ALTER ON hgu_change_msisdn TO ninjamain
/
GRANT DELETE ON hgu_change_msisdn TO ninjamain
/
GRANT INDEX ON hgu_change_msisdn TO ninjamain
/
GRANT INSERT ON hgu_change_msisdn TO ninjamain
/
GRANT SELECT ON hgu_change_msisdn TO ninjamain
/
GRANT UPDATE ON hgu_change_msisdn TO ninjamain
/
GRANT REFERENCES ON hgu_change_msisdn TO ninjamain
/
GRANT ON COMMIT REFRESH ON hgu_change_msisdn TO ninjamain
/
GRANT QUERY REWRITE ON hgu_change_msisdn TO ninjamain
/
GRANT DEBUG ON hgu_change_msisdn TO ninjamain
/
GRANT FLASHBACK ON hgu_change_msisdn TO ninjamain
/




-- Indexes for hgu_change_msisdn

CREATE INDEX hgu_change_msisdn_idx1 ON hgu_change_msisdn
  (
    subscriber_no                  ASC
  )
/

CREATE INDEX hgu_change_msisdn_idx2 ON hgu_change_msisdn
  (
    process_status                  ASC
  )
/

CREATE INDEX hgu_change_msisdn_idx3 ON hgu_change_msisdn
  (
    ctn                             ASC
  )
/


-- Constraints for hgu_change_msisdn

ALTER TABLE hgu_change_msisdn
ADD CONSTRAINT hgu_change_msisdn_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/


-- Triggers for hgu_change_msisdn

CREATE OR REPLACE TRIGGER hgu_change_msisdn_trg
 BEFORE
  INSERT
 ON hgu_change_msisdn
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
  END IF;
    EXCEPTION
        WHEN updating_key_fields THEN
            raise_application_error(-20300, 'NinjaDB Error: cannot update key fields of source table.');
END hgu_change_msisdn_trg;
/


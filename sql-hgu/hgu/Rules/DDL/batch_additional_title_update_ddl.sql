-- Start of DDL Script for Table NINJADATA.batch_additional_title_update
-- Generated 2017-10-25 15:39:20 from NINJADATA@NINJAPROD1

CREATE TABLE batch_additional_title_update
    (transaction_number             NUMBER(9,0),
    subscriber_no                  VARCHAR2(20 CHAR),
    ban_no                         NUMBER(9,0),
    link_type                      CHAR(1 CHAR),
    additional_title               VARCHAR2(60 CHAR),
    process_status                 VARCHAR2(20 CHAR),
    request_date                   DATE,
    process_time                   DATE,
    status_desc                    VARCHAR2(2000 CHAR),
    record_creation_date           DATE,
    request_id                     VARCHAR2(60 CHAR),
    request_user_id                VARCHAR2(60 CHAR))
/

-- Grants for Table
GRANT ALTER ON batch_additional_title_update TO ninjamain
/
GRANT DELETE ON batch_additional_title_update TO ninjamain
/
GRANT INDEX ON batch_additional_title_update TO ninjamain
/
GRANT INSERT ON batch_additional_title_update TO ninjamain
/
GRANT SELECT ON batch_additional_title_update TO ninjamain
/
GRANT UPDATE ON batch_additional_title_update TO ninjamain
/
GRANT REFERENCES ON batch_additional_title_update TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_additional_title_update TO ninjamain
/
GRANT QUERY REWRITE ON batch_additional_title_update TO ninjamain
/
GRANT DEBUG ON batch_additional_title_update TO ninjamain
/
GRANT FLASHBACK ON batch_additional_title_update TO ninjamain
/


-- Indexes for batch_additional_title_update

CREATE UNIQUE INDEX batch_additional_title_update_pk ON batch_additional_title_update
  (
    transaction_number              ASC
  )
/

CREATE INDEX add_title_upd_idx1 ON batch_additional_title_update
  (
    subscriber_no                   ASC
  )
/

CREATE INDEX add_title_upd_idx2 ON batch_additional_title_update
  (
    ban_no                          ASC
  )
/

CREATE INDEX add_title_upd_idx3 ON batch_additional_title_update
  (
    request_date                    ASC,
    process_time                    ASC
  )
/

CREATE INDEX add_title_upd_idx4 ON batch_additional_title_update
  (
    request_id                      ASC,
    request_user_id                 ASC
  )
/

-- Sequence...

CREATE SEQUENCE batch_add_title_update_trx_seq
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999
  NOCYCLE
  NOORDER
  CACHE 20
/


-- Triggers for batch_additional_title_update

CREATE OR REPLACE TRIGGER "NINJADATA.ADD_TITLE_TRG"
 BEFORE
  INSERT
 ON batch_additional_title_update
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF INSERTING
    THEN
        -- Ensure that the unique id is updated correctly
        SELECT BATCH_ADD_TITLE_UPDATE_TRX_SEQ.NEXTVAL
          INTO :new.transaction_number
          FROM dual;

        -- If status of record is null, default it to 'WAITING'
        IF :new.process_status IS NULL THEN
            :new.process_status := 'WAITING';
        END IF;

        -- If requested date is null, default it to 'WAITING'
        IF :new.request_date IS NULL THEN
            :new.request_date := SYSDATE;
        END IF;

        IF :new.record_creation_date IS NULL THEN
            :new.record_creation_date := SYSDATE;
        END IF;
    END IF;
END;
/


-- Comments for batch_additional_title_update

COMMENT ON COLUMN batch_additional_title_update.ban_no IS 'ban number for legal or billing email update'
/
COMMENT ON COLUMN batch_additional_title_update.additional_title IS 'new additional title'
/
COMMENT ON COLUMN batch_additional_title_update.link_type IS 'link type, either ''U''ser,''L''egal or ''B''illing'
/
COMMENT ON COLUMN batch_additional_title_update.subscriber_no IS 'subscriber number for user title update'
/

CREATE SYNONYM ninjamain.batch_additional_title_update
  FOR NINJADATA.batch_additional_title_update
/
-- End of DDL Script for Table NINJADATA.batch_additional_title_update


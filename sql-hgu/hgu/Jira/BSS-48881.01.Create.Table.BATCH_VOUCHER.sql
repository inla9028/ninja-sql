CREATE TABLE batch_voucher (
    -- Generic...
    ban                            NUMBER(9),
    subscriber_no                  VARCHAR2(20 CHAR),
    soc                            VARCHAR2(9 CHAR),
    feature                        VARCHAR2(6 CHAR),
    -- Data
    frequency                      NUMBER(9),
    product_id                     VARCHAR2(200 CHAR),
    product_type                   VARCHAR2(200 CHAR),
    recharge_amount                NUMBER(9),
    recharge_count                 NUMBER(9),
    recharge_unit                  VARCHAR2(200 CHAR),
    sms                            VARCHAR2(1 CHAR),
    valid_from                     DATE,
    valid_to                       DATE,
    -- Batch-related.
    request_id                     VARCHAR2(200 CHAR),
    enter_time                     DATE,
    request_time                   DATE,
    process_time                   DATE,
    process_status                 VARCHAR2(15 CHAR),
    status_desc                    VARCHAR2(2000 CHAR)
)
/


-- Grants for Table
GRANT ALTER ON batch_voucher TO ninjateam
/
GRANT DELETE ON batch_voucher TO ninjateam
/
GRANT INDEX ON batch_voucher TO ninjateam
/
GRANT INSERT ON batch_voucher TO ninjateam
/
GRANT SELECT ON batch_voucher TO ninjateam
/
GRANT UPDATE ON batch_voucher TO ninjateam
/
GRANT REFERENCES ON batch_voucher TO ninjateam
/
GRANT ALTER ON batch_voucher TO ninjamaster
/
GRANT DELETE ON batch_voucher TO ninjamaster
/
GRANT INDEX ON batch_voucher TO ninjamaster
/
GRANT INSERT ON batch_voucher TO ninjamaster
/
GRANT SELECT ON batch_voucher TO ninjamaster
/
GRANT UPDATE ON batch_voucher TO ninjamaster
/
GRANT REFERENCES ON batch_voucher TO ninjamaster
/
GRANT ON COMMIT REFRESH ON batch_voucher TO ninjamaster
/
GRANT QUERY REWRITE ON batch_voucher TO ninjamaster
/
GRANT DEBUG ON batch_voucher TO ninjamaster
/
GRANT FLASHBACK ON batch_voucher TO ninjamaster
/
GRANT ALTER ON batch_voucher TO ninjamain
/
GRANT DELETE ON batch_voucher TO ninjamain
/
GRANT INDEX ON batch_voucher TO ninjamain
/
GRANT INSERT ON batch_voucher TO ninjamain
/
GRANT SELECT ON batch_voucher TO ninjamain
/
GRANT UPDATE ON batch_voucher TO ninjamain
/
GRANT REFERENCES ON batch_voucher TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_voucher TO ninjamain
/
GRANT QUERY REWRITE ON batch_voucher TO ninjamain
/
GRANT DEBUG ON batch_voucher TO ninjamain
/
GRANT FLASHBACK ON batch_voucher TO ninjamain
/
GRANT SELECT ON batch_voucher TO ks_user
/
GRANT ALTER ON batch_voucher TO kontant
/
GRANT DELETE ON batch_voucher TO kontant
/
GRANT INDEX ON batch_voucher TO kontant
/
GRANT INSERT ON batch_voucher TO kontant
/
GRANT SELECT ON batch_voucher TO kontant
/
GRANT UPDATE ON batch_voucher TO kontant
/
GRANT REFERENCES ON batch_voucher TO kontant
/
GRANT SELECT ON batch_voucher TO readonly
/

-- Indexes for batch_voucher

CREATE INDEX batch_voucher_idx1 ON batch_voucher
  (
    process_status                  ASC,
    request_time                    ASC
  )
/

CREATE INDEX batch_voucher_idx2 ON batch_voucher
  (
    process_status                  ASC,
    enter_time                      ASC
  )
/

CREATE INDEX batch_voucher_idx3 ON batch_voucher
  (
    request_id                      ASC,
    process_status                  ASC
  )
/

-- Constraints for batch_voucher

ALTER TABLE batch_voucher
ADD CHECK (request_id IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_voucher
ADD CHECK (PROCESS_STATUS IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_voucher
ADD CHECK (REQUEST_TIME IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_voucher
ADD CHECK (ENTER_TIME IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_voucher
ADD CHECK (SUBSCRIBER_NO IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_voucher
ADD CONSTRAINT batch_voucher_100 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD')
)
ENABLE NOVALIDATE
/

-- Triggers for batch_voucher

CREATE OR REPLACE TRIGGER batch_voucher_trg1
 BEFORE
  INSERT
 ON batch_voucher
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF INSERTING
  THEN
   SELECT SYSDATE
     INTO :new.enter_time
     FROM dual;

   IF :new.request_time IS NULL
   THEN
    :new.request_time := :new.enter_time;
   END IF;

   IF :new.process_status IS NULL
   THEN
     :new.process_status := 'WAITING';
   END IF;

  END IF;
 END;
/

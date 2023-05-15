CREATE TABLE batch_socs (
    ban             NUMBER(9),
    subscriber_no   VARCHAR2(20 CHAR),
    add_socs        VARCHAR2(256 CHAR),
    modify_socs     VARCHAR2(256 CHAR),
    delete_socs     VARCHAR2(256 CHAR),
    chk_priceplan   VARCHAR2(9 CHAR),
    dealer_code     VARCHAR2(6 CHAR),
    sales_agent     VARCHAR2(6 CHAR),
    memo_text       VARCHAR2(256 CHAR),
    operator_id     INTEGER,
    request_id      VARCHAR2(60 CHAR),
    waive_act_fee   VARCHAR2(1 CHAR),
    enter_time      DATE,
    request_time    DATE,
    process_time    DATE,
    process_status  VARCHAR2(15 CHAR),
    status_desc     VARCHAR2(2000 CHAR),
    CHECK (subscriber_no IS NOT NULL) ENABLE NOVALIDATE,
    CONSTRAINT batch_socs_101 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD', 'DUPLICATE')
) ENABLE NOVALIDATE
)
;

CREATE OR REPLACE TRIGGER batch_socs_trg1
 BEFORE
  INSERT
 ON batch_socs
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  v_success_count     NUMBER DEFAULT 0;
  v_error_count       NUMBER DEFAULT 0;
  v_tmp_trans_seq     NUMBER DEFAULT 0;

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

   -- Customer Care famously once uploaded a job with subscriber_no = 'gsm047', which didn't work very well.
   :new.subscriber_no := UPPER(:new.subscriber_no);

  END IF;
 END;
/

ALTER TRIGGER batch_socs_trg1 ENABLE
;

CREATE INDEX batch_socs_idx1 ON batch_socs (process_status, request_time)
;

CREATE INDEX batch_socs_idx3 ON batch_socs (request_id, process_status)
;

-- Grants for Table
/*
GRANT ALTER ON batch_socs TO ninjateam
/
GRANT DELETE ON batch_socs TO ninjateam
/
GRANT INDEX ON batch_socs TO ninjateam
/
GRANT INSERT ON batch_socs TO ninjateam
/
GRANT SELECT ON batch_socs TO ninjateam
/
GRANT UPDATE ON batch_socs TO ninjateam
/
GRANT REFERENCES ON batch_socs TO ninjateam
/
*/
GRANT ALTER ON batch_socs TO ninjamain_at
/
GRANT DELETE ON batch_socs TO ninjamain_at
/
GRANT INDEX ON batch_socs TO ninjamain_at
/
GRANT INSERT ON batch_socs TO ninjamain_at
/
GRANT SELECT ON batch_socs TO ninjamain_at
/

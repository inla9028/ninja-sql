CREATE TABLE batch_replace_keep_exp_date (
    subscriber_no  VARCHAR2(20 CHAR), 
    old_soc        VARCHAR2(9 CHAR), 
    old_soc_promo  VARCHAR2(9 CHAR),
    new_soc        VARCHAR2(9 CHAR), 
    new_soc_promo  VARCHAR2(9 CHAR),
    dealer_code    VARCHAR2(6 CHAR), 
    sales_agent    VARCHAR2(6 CHAR), 
    memo_text      VARCHAR2(200 CHAR), 
    request_id     VARCHAR2(60 CHAR),
    enter_time     DATE, 
    request_time   DATE,  
    process_time   DATE,  
    process_status VARCHAR2(15 CHAR), 
    status_desc    VARCHAR2(200 CHAR),
    CHECK (subscriber_no IS NOT NULL) ENABLE NOVALIDATE,
    CONSTRAINT batch_replace_kp_exp_dt_101 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD', 'DUPLICATE')
) ENABLE NOVALIDATE
)
;

CREATE OR REPLACE TRIGGER batch_replace_kp_exp_dt_trg1 
 BEFORE
  INSERT
 ON batch_replace_keep_exp_date
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
     :new.process_status := 'IN_PROGRESS';
   END IF;
   
   IF :new.memo_text IS NULL
   THEN
    :new.memo_text := 'No Memo Text Specified by Request [' || :new.request_id || ']';
   END IF;
   
   -- 2020-09-16 :: Customer Care uploaded a job with subscriber_no = 'gsm047', which didn't work very well.
   :new.subscriber_no := UPPER(:new.subscriber_no);

  END IF;
 END;
/

ALTER TRIGGER batch_replace_kp_exp_dt_trg1 ENABLE
;

CREATE INDEX batch_replace_kp_exp_dt_idx1 ON batch_replace_keep_exp_date (process_status, request_time) 
;

CREATE INDEX batch_replace_kp_exp_dt_idx3 ON batch_replace_keep_exp_date (request_id, process_status) 
;

-- Grants for Table
/*
GRANT ALTER ON batch_replace_keep_exp_date TO ninjateam
/
GRANT DELETE ON batch_replace_keep_exp_date TO ninjateam
/
GRANT INDEX ON batch_replace_keep_exp_date TO ninjateam
/
GRANT INSERT ON batch_replace_keep_exp_date TO ninjateam
/
GRANT SELECT ON batch_replace_keep_exp_date TO ninjateam
/
GRANT UPDATE ON batch_replace_keep_exp_date TO ninjateam
/
GRANT REFERENCES ON batch_replace_keep_exp_date TO ninjateam
/
*/
GRANT ALTER ON batch_replace_keep_exp_date TO ninjamain
/
GRANT DELETE ON batch_replace_keep_exp_date TO ninjamain
/
GRANT INDEX ON batch_replace_keep_exp_date TO ninjamain
/
GRANT INSERT ON batch_replace_keep_exp_date TO ninjamain
/
GRANT SELECT ON batch_replace_keep_exp_date TO ninjamain
/

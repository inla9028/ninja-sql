-- Start of DDL Script for Table NINJADATA_PT.batch_change_priceplan_w_clone
-- Generated 2018-08-17 11:06:40 from NINJADATA_PT@NINJA_NO_PT_ST

CREATE TABLE batch_change_priceplan_w_clone
    (subscriber_no                 VARCHAR2(20 CHAR) ,
    old_priceplan                  VARCHAR2(9 CHAR),
    new_priceplan                  VARCHAR2(9 CHAR) ,
    new_campaign_code              VARCHAR2(9 CHAR),
    new_subscription_type          VARCHAR2(15 CHAR),
    handle_commitment              VARCHAR2(1 CHAR),
    socs_to_add_first              VARCHAR2(200 CHAR),
    socs_to_delete_first           VARCHAR2(200 CHAR),
    socs_to_add                    VARCHAR2(200 CHAR),
    socs_to_clone                  VARCHAR2(200 CHAR),
    socs_to_delete                 VARCHAR2(200 CHAR),
    dealer                         VARCHAR2(6 CHAR),
    sales_agent                    VARCHAR2(6 CHAR),
    reason_code                    VARCHAR2(5 CHAR),
    memo_text                      VARCHAR2(200 CHAR),
    waive_fees                     VARCHAR2(1 CHAR),
    enter_time                     DATE ,
    request_time                   DATE,
    process_time                   DATE,
    process_status                 VARCHAR2(15 CHAR) DEFAULT NULL,
    status_desc                    VARCHAR2(2001 CHAR),
    requestor_id                   VARCHAR2(60 CHAR),
    skip_ninja_validation          VARCHAR2(1 CHAR) DEFAULT 'N')
/

-- Grants for Table
GRANT ALTER ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT DELETE ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT INDEX ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT INSERT ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT SELECT ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT UPDATE ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT REFERENCES ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT QUERY REWRITE ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT DEBUG ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT FLASHBACK ON batch_change_priceplan_w_clone TO ninjamain
/
GRANT ALTER ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT DELETE ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT INDEX ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT INSERT ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT SELECT ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT UPDATE ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT REFERENCES ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT ON COMMIT REFRESH ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT QUERY REWRITE ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT DEBUG ON batch_change_priceplan_w_clone TO ninjateam
/
GRANT FLASHBACK ON batch_change_priceplan_w_clone TO ninjateam
/



-- Indexes for batch_change_priceplan_w_clone

CREATE INDEX batch_change_pp_w_clone_idx1 ON batch_change_priceplan_w_clone
  (
    process_status                  ASC,
    request_time                    ASC
  )
/

CREATE INDEX batch_change_pp_w_clone_idx2 ON batch_change_priceplan_w_clone
  (
    process_status                  ASC,
    enter_time                      ASC
  )
/

CREATE INDEX batch_change_pp_w_clone_idx3 ON batch_change_priceplan_w_clone
  (
    requestor_id                    ASC,
    process_status                  ASC
  )
/



-- Constraints for batch_change_priceplan_w_clone

ALTER TABLE batch_change_priceplan_w_clone
ADD CONSTRAINT batch_change_pp_w_clone_100 CHECK ( waive_fees IN ('Y', 'N'))
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CONSTRAINT batch_change_pp_w_clone_101 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD')
)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CONSTRAINT batch_change_pp_w_clone_103 CHECK ( handle_commitment IN ('N','K','E','R' ) )
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD PRIMARY KEY (subscriber_no, new_priceplan, enter_time)
USING INDEX
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("SUBSCRIBER_NO" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("NEW_PRICEPLAN" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("NEW_CAMPAIGN_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("NEW_SUBSCRIPTION_TYPE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("HANDLE_COMMITMENT" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("REASON_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("MEMO_TEXT" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("WAIVE_FEES" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("ENTER_TIME" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("REQUEST_TIME" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("PROCESS_STATUS" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("REQUESTOR_ID" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan_w_clone
ADD CHECK ("SKIP_NINJA_VALIDATION" IS NOT NULL)
ENABLE NOVALIDATE
/


-- Triggers for batch_change_priceplan_w_clone

CREATE OR REPLACE TRIGGER batch_change_pp_w_clone_trg1
 BEFORE
  INSERT
 ON batch_change_priceplan_w_clone
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF INSERTING
  THEN
   SELECT sysdate
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
   
   IF :new.new_priceplan IS NOT NULL
   THEN
     :new.new_priceplan := TRIM(:new.new_priceplan);
   END IF;

   IF :new.new_subscription_type IS NULL
   THEN
     :new.new_subscription_type := :new.new_priceplan || 'REG1';
   END IF;
   
   IF :new.new_campaign_code IS NULL
   THEN
        :new.new_campaign_code := '000000000';
   END IF;
   
   IF :new.handle_commitment IS NULL
   THEN
     IF :new.new_campaign_code = '000000000'
     THEN
         :new.handle_commitment := 'K';
     ELSE
         :new.handle_commitment := 'N';
     END IF;
   END IF;
   
   IF :new.waive_fees IS NULL
   THEN
     :new.waive_fees := 'Y';
   END IF;
   
   IF :new.memo_text IS NULL
   THEN
    :new.memo_text := 'No Memo Text Specified by Requestor [' || :new.requestor_id || ']';
   END IF;

   IF :new.skip_ninja_validation IS NULL
   THEN
     :new.skip_ninja_validation := 'N';
   END IF;
   
  END IF;
 END;
/


-- Comments for batch_change_priceplan_w_clone

COMMENT ON TABLE batch_change_priceplan_w_clone IS 'Holds transactions for priceplan changes to be processed by the Master priceplan changer demon'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.dealer IS 'Dealer who performed the change. If left blank, the original dealer code on the subscription is used'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.enter_time IS 'Time when row was inserted into this table. Automatically set on insert operation'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.handle_commitment IS 'How to handle the existing commitment period. N, (NONE) R, (REPLACE OLD (default)) E, (EXTEND OLD) K, (KEEP OLD)'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.memo_text IS 'Foksu Memo Text for PP change'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.new_campaign_code IS 'The new campaign code'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.new_priceplan IS 'The new priceplan code'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.new_subscription_type IS 'The new Subscription Profile Type'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.old_priceplan IS 'The old priceplan code, if the priceplan is different, the job will refuse to process the row'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.process_status IS 'Status of transaction. Valid values: ''WAITING'', ''IN_PROGRESS'', ''PRSD_SUCCESS'' and ''PRSD_ERROR'''
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.process_time IS 'Time when this transaction was actually processed'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.reason_code IS 'Reason code for PP change'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.request_time IS 'Time when PP change is supposed to take place'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.requestor_id IS 'Free Text To identify who entered them'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.sales_agent IS 'Sales agent who performed the change. If left blank, the original sales agent code on the subscription is used'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.skip_ninja_validation IS 'Indicator to utilize Ninja ''backdoor'''
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.socs_to_add IS 'A comma-separated list of socs to add as part of the rating-change'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.socs_to_add_first IS 'A comma-separated list of socs to add before the rating-change'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.socs_to_clone IS 'A comma-separated list of socs, formatted SOCA/SOCB, to clone as part of the rating-change'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.socs_to_delete IS 'A comma-separated list of socs to delete as part of the rating-change'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.socs_to_delete_first IS 'A comma-separated list of socs to delete before the rating-change'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.status_desc IS 'Status description'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.subscriber_no IS 'Subscriber number of subscriber who is going to get his priceplan changed'
/
COMMENT ON COLUMN batch_change_priceplan_w_clone.waive_fees IS 'Waive fees relating to the PP change Valud values: ''Y'' and ''N'''
/


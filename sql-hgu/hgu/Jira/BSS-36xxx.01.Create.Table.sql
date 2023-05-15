CREATE TABLE batch_change_priceplan
    (subscriber_no                  VARCHAR2(20),
    old_priceplan                  VARCHAR2(9),
    new_priceplan                  VARCHAR2(9),
    new_campaign_code              VARCHAR2(9),
    new_subscription_type          VARCHAR2(15),
    handle_commitment              VARCHAR2(1),
    socs_to_add                    VARCHAR2(200),
    socs_to_delete                 VARCHAR2(200),
    effective_date                 DATE,
    dealer                         VARCHAR2(6),
    sales_agent                    VARCHAR2(6),
    reason_code                    VARCHAR2(5),
    memo_text                      VARCHAR2(200),
    waive_fees                     VARCHAR2(1),
    enter_time                     DATE,
    request_time                   DATE,
    process_time                   DATE,
    process_status                 VARCHAR2(15) DEFAULT NULL,
    status_desc                    VARCHAR2(2001),
    requestor_id                   VARCHAR2(60),
    skip_ninja_validation          VARCHAR2(1) DEFAULT 'N')
/

-- Grants for Table
GRANT ALTER ON batch_change_priceplan TO ninjateam
/
GRANT DELETE ON batch_change_priceplan TO ninjateam
/
GRANT INDEX ON batch_change_priceplan TO ninjateam
/
GRANT INSERT ON batch_change_priceplan TO ninjateam
/
GRANT SELECT ON batch_change_priceplan TO ninjateam
/
GRANT UPDATE ON batch_change_priceplan TO ninjateam
/
GRANT REFERENCES ON batch_change_priceplan TO ninjateam
/
GRANT ALTER ON batch_change_priceplan TO ninjamaster
/
GRANT DELETE ON batch_change_priceplan TO ninjamaster
/
GRANT INDEX ON batch_change_priceplan TO ninjamaster
/
GRANT INSERT ON batch_change_priceplan TO ninjamaster
/
GRANT SELECT ON batch_change_priceplan TO ninjamaster
/
GRANT UPDATE ON batch_change_priceplan TO ninjamaster
/
GRANT REFERENCES ON batch_change_priceplan TO ninjamaster
/
GRANT ON COMMIT REFRESH ON batch_change_priceplan TO ninjamaster
/
GRANT QUERY REWRITE ON batch_change_priceplan TO ninjamaster
/
GRANT DEBUG ON batch_change_priceplan TO ninjamaster
/
GRANT FLASHBACK ON batch_change_priceplan TO ninjamaster
/
GRANT ALTER ON batch_change_priceplan TO ninjamain
/
GRANT DELETE ON batch_change_priceplan TO ninjamain
/
GRANT INDEX ON batch_change_priceplan TO ninjamain
/
GRANT INSERT ON batch_change_priceplan TO ninjamain
/
GRANT SELECT ON batch_change_priceplan TO ninjamain
/
GRANT UPDATE ON batch_change_priceplan TO ninjamain
/
GRANT REFERENCES ON batch_change_priceplan TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_change_priceplan TO ninjamain
/
GRANT QUERY REWRITE ON batch_change_priceplan TO ninjamain
/
GRANT DEBUG ON batch_change_priceplan TO ninjamain
/
GRANT FLASHBACK ON batch_change_priceplan TO ninjamain
/
GRANT SELECT ON batch_change_priceplan TO ks_user
/
GRANT ALTER ON batch_change_priceplan TO kontant
/
GRANT DELETE ON batch_change_priceplan TO kontant
/
GRANT INDEX ON batch_change_priceplan TO kontant
/
GRANT INSERT ON batch_change_priceplan TO kontant
/
GRANT SELECT ON batch_change_priceplan TO kontant
/
GRANT UPDATE ON batch_change_priceplan TO kontant
/
GRANT REFERENCES ON batch_change_priceplan TO kontant
/
GRANT SELECT ON batch_change_priceplan TO readonly
/

-- Indexes for batch_change_priceplan

CREATE INDEX batch_change_priceplan_idx1 ON batch_change_priceplan
  (
    process_status                  ASC,
    request_time                    ASC
  )
/

CREATE INDEX batch_change_priceplan_idx2 ON batch_change_priceplan
  (
    process_status                  ASC,
    enter_time                      ASC
  )
/

CREATE INDEX batch_change_priceplan_idx3 ON batch_change_priceplan
  (
    requestor_id                    ASC,
    process_status                  ASC
  )
/

-- Constraints for batch_change_priceplan

ALTER TABLE batch_change_priceplan
ADD CHECK ("SKIP_NINJA_VALIDATION" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("REQUESTOR_ID" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("PROCESS_STATUS" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("REQUEST_TIME" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("ENTER_TIME" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("WAIVE_FEES" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("MEMO_TEXT" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("REASON_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("HANDLE_COMMITMENT" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("NEW_SUBSCRIPTION_TYPE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("NEW_CAMPAIGN_CODE" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("NEW_PRICEPLAN" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CHECK ("SUBSCRIBER_NO" IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD PRIMARY KEY (subscriber_no, new_priceplan, enter_time)
USING INDEX
/

ALTER TABLE batch_change_priceplan
ADD CONSTRAINT batch_change_priceplan_103 CHECK ( handle_commitment IN ('N','K','E','R' ) )
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CONSTRAINT batch_change_priceplan_101 CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD')
)
ENABLE NOVALIDATE
/

ALTER TABLE batch_change_priceplan
ADD CONSTRAINT batch_change_priceplan_100 CHECK ( waive_fees IN ('Y', 'N'))
ENABLE NOVALIDATE
/

-- Triggers for batch_change_priceplan

CREATE OR REPLACE TRIGGER batch_change_priceplan_trg1
 BEFORE
  INSERT
 ON batch_change_priceplan
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

-- Comments for batch_change_priceplan

COMMENT ON TABLE batch_change_priceplan IS 'Holds transactions for priceplan changes to be processed by the Master priceplan changer demon'
/
COMMENT ON COLUMN batch_change_priceplan.dealer IS 'Dealer who performed the change. If left blank, the original dealer code on the subscription is used'
/
COMMENT ON COLUMN batch_change_priceplan.effective_date IS 'Date when the change must be effective from'
/
COMMENT ON COLUMN batch_change_priceplan.enter_time IS 'Time when row was inserted into this table. Automatically set on insert operation'
/
COMMENT ON COLUMN batch_change_priceplan.handle_commitment IS 'How to handle the existing commitment period. N, (NONE) R, (REPLACE OLD (default)) E, (EXTEND OLD) K, (KEEP OLD)'
/
COMMENT ON COLUMN batch_change_priceplan.memo_text IS 'Foksu Memo Text for PP change'
/
COMMENT ON COLUMN batch_change_priceplan.new_campaign_code IS 'The new campaign code'
/
COMMENT ON COLUMN batch_change_priceplan.old_priceplan IS 'The old priceplan code, if the priceplan is different, the job will refuse to process the row'
/
COMMENT ON COLUMN batch_change_priceplan.new_priceplan IS 'The new priceplan code'
/
COMMENT ON COLUMN batch_change_priceplan.new_subscription_type IS 'The new Subscription Profile Type'
/
COMMENT ON COLUMN batch_change_priceplan.socs_to_add IS 'A comma-separated list of socs to add as part of the rating-change'
/
COMMENT ON COLUMN batch_change_priceplan.socs_to_delete IS 'A comma-separated list of socs to delete as part of the rating-change'
/
COMMENT ON COLUMN batch_change_priceplan.process_status IS 'Status of transaction. Valid values: ''WAITING'', ''IN_PROGRESS'', ''PRSD_SUCCESS'' and ''PRSD_ERROR'''
/
COMMENT ON COLUMN batch_change_priceplan.process_time IS 'Time when this transaction was actually processed'
/
COMMENT ON COLUMN batch_change_priceplan.reason_code IS 'Reason code for PP change'
/
COMMENT ON COLUMN batch_change_priceplan.request_time IS 'Time when PP change is supposed to take place'
/
COMMENT ON COLUMN batch_change_priceplan.requestor_id IS 'Free Text To identify who entered them'
/
COMMENT ON COLUMN batch_change_priceplan.sales_agent IS 'Sales agent who performed the change. If left blank, the original sales agent code on the subscription is used'
/
COMMENT ON COLUMN batch_change_priceplan.skip_ninja_validation IS 'Indicator to utilize Ninja ''backdoor'''
/
COMMENT ON COLUMN batch_change_priceplan.status_desc IS 'Status description'
/
COMMENT ON COLUMN batch_change_priceplan.subscriber_no IS 'Subscriber number of subscriber who is going to get his priceplan changed'
/
COMMENT ON COLUMN batch_change_priceplan.waive_fees IS 'Waive fees relating to the PP change Valud values: ''Y'' and ''N'''
/


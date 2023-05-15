CREATE TABLE batch_move_subscription (
    subscriber_no                  VARCHAR2(20 CHAR),
    ban                            NUMBER(9,0),
    --
    priceplan                      VARCHAR2(256 CHAR),
    campaign_code                  VARCHAR2(9 CHAR) DEFAULT '000000000',
    handle_commitment              VARCHAR2(1 CHAR),
    reason_code                    VARCHAR2(5 CHAR),
    --
    add_socs                       VARCHAR2(256 CHAR),
    modify_socs                    VARCHAR2(256 CHAR),
    delete_socs                    VARCHAR2(256 CHAR),
    --
    to_sp                          VARCHAR2(1 CHAR) DEFAULT 'N',
    from_sp                        VARCHAR2(1 CHAR) DEFAULT 'N',
    --
    keep_name                      VARCHAR2(1 CHAR) DEFAULT 'Y',
    sim                            VARCHAR2(20 CHAR),
    --
    dealer                         VARCHAR2(6 CHAR),
    --
    memo_text                      VARCHAR2(200 CHAR),
    waive_fees                     VARCHAR2(1 CHAR) DEFAULT 'N',
    skip_validation                VARCHAR2(1 CHAR) DEFAULT 'N',
    --
    request_time                   DATE,
    request_id                     VARCHAR2(64 CHAR),
    --
    process_status                 VARCHAR2(16 CHAR) DEFAULT 'WAITING',
    process_time                   DATE,
    status_desc                    VARCHAR2(2000 CHAR)
)
/

-- Grants for Table
GRANT ALTER ON batch_move_subscription TO ninjateam
/
GRANT DELETE ON batch_move_subscription TO ninjateam
/
GRANT INDEX ON batch_move_subscription TO ninjateam
/
GRANT INSERT ON batch_move_subscription TO ninjateam
/
GRANT SELECT ON batch_move_subscription TO ninjateam
/
GRANT UPDATE ON batch_move_subscription TO ninjateam
/
GRANT REFERENCES ON batch_move_subscription TO ninjateam
/
GRANT ALTER ON batch_move_subscription TO ninjamaster
/
GRANT DELETE ON batch_move_subscription TO ninjamaster
/
GRANT INDEX ON batch_move_subscription TO ninjamaster
/
GRANT INSERT ON batch_move_subscription TO ninjamaster
/
GRANT SELECT ON batch_move_subscription TO ninjamaster
/
GRANT UPDATE ON batch_move_subscription TO ninjamaster
/
GRANT REFERENCES ON batch_move_subscription TO ninjamaster
/
GRANT ON COMMIT REFRESH ON batch_move_subscription TO ninjamaster
/
GRANT QUERY REWRITE ON batch_move_subscription TO ninjamaster
/
GRANT DEBUG ON batch_move_subscription TO ninjamaster
/
GRANT FLASHBACK ON batch_move_subscription TO ninjamaster
/
GRANT ALTER ON batch_move_subscription TO ninjamain
/
GRANT DELETE ON batch_move_subscription TO ninjamain
/
GRANT INDEX ON batch_move_subscription TO ninjamain
/
GRANT INSERT ON batch_move_subscription TO ninjamain
/
GRANT SELECT ON batch_move_subscription TO ninjamain
/
GRANT UPDATE ON batch_move_subscription TO ninjamain
/
GRANT REFERENCES ON batch_move_subscription TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_move_subscription TO ninjamain
/
GRANT QUERY REWRITE ON batch_move_subscription TO ninjamain
/
GRANT DEBUG ON batch_move_subscription TO ninjamain
/
GRANT FLASHBACK ON batch_move_subscription TO ninjamain
/
GRANT SELECT ON batch_move_subscription TO readonly
/

-- Indexes for batch_move_subscription

CREATE INDEX batch_move_subscription_idx1 ON batch_move_subscription
  (
    process_status                  ASC,
    request_time                    ASC
  )
/

CREATE INDEX batch_move_subscription_idx2 ON batch_move_subscription
  (
    subscriber_no                   ASC,
    process_status                  ASC
  )
/
-- Constraints for batch_move_subscription


ALTER TABLE batch_move_subscription
ADD CONSTRAINT batch_move_subscription_103 CHECK ( handle_commitment IN ('E', 'K', 'N', 'R' ) )
ENABLE NOVALIDATE
/

ALTER TABLE batch_move_subscription
ADD CONSTRAINT batch_move_subscription_101 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD') )
ENABLE NOVALIDATE
/

ALTER TABLE batch_move_subscription
ADD CONSTRAINT batch_move_subscription_102 CHECK ( waive_fees IN ('Y', 'N') )
ENABLE NOVALIDATE
/

ALTER TABLE batch_move_subscription
ADD CONSTRAINT batch_move_subscription_104 CHECK ( to_sp IN ('Y', 'N') )
ENABLE NOVALIDATE
/

ALTER TABLE batch_move_subscription
ADD CONSTRAINT batch_move_subscription_105 CHECK ( from_sp IN ('Y', 'N') )
ENABLE NOVALIDATE
/

ALTER TABLE batch_move_subscription
ADD CONSTRAINT batch_move_subscription_106 CHECK ( keep_name IN ('Y', 'N') )
ENABLE NOVALIDATE
/

ALTER TABLE batch_move_subscription
ADD CONSTRAINT batch_move_subscription_107 CHECK ( skip_validation IN ('Y', 'N') )
ENABLE NOVALIDATE
/

-- Triggers for batch_move_subscription

CREATE OR REPLACE TRIGGER batch_move_subscription_trg1
 BEFORE
  INSERT
 ON batch_move_subscription
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF INSERTING
  THEN
   IF :new.request_time IS NULL
   THEN
    :new.request_time := SYSDATE;
   END IF;
   
   IF :new.handle_commitment IS NULL
   THEN
     IF :new.campaign_code = '000000000'
     THEN
         :new.handle_commitment := 'K';
     ELSE
         :new.handle_commitment := 'N';
     END IF;
   END IF;
      
  END IF;
 END;
/

CREATE TABLE "BATCH_ADDRESS_UPDATE" (
  "BAN" NUMBER(9),
  "SUBSCRIBER_NO" VARCHAR2(20 CHAR),
  "LINK_TYPE" CHAR(1 CHAR),
  "ADDRESS_TYPE" CHAR(1 CHAR),
  "ACCOMMODATION_TYPE" VARCHAR2(4 CHAR),
  "AREA_DISTRICT" VARCHAR2(40 CHAR),
  "CITY" VARCHAR2(39 CHAR),
  "COUNTRY_CODE" CHAR(3),
  "CO_NAME" VARCHAR2(60 CHAR),
  "DIRECTION" CHAR(2),
  "DOOR_NUMBER" VARCHAR2(4 CHAR),
  "EMAIL" VARCHAR2(150 CHAR),
  "FLOOR_NUMBER" VARCHAR2(2 CHAR),
  "HOUSE_LETTER" VARCHAR2(2 CHAR),
  "HOUSE_NUMBER" VARCHAR2(20 CHAR),
  "POB" VARCHAR2(10 CHAR),
  "POB_NAME" VARCHAR2(40 CHAR),
  "SINCE_DATE" DATE,
  "STREET_NAME" VARCHAR2(60 CHAR),
  "ZIP_CODE" VARCHAR2(9 CHAR),
	"ENTER_TIME" DATE,
	"REQUEST_TIME" DATE,
	"REQUESTOR_ID" VARCHAR2(64 CHAR),
	"PROCESS_TIME" DATE,
	"PROCESS_STATUS" VARCHAR2(15 CHAR) DEFAULT NULL,
	"STATUS_DESC" VARCHAR2(2000 CHAR)
)
;

-------------------------------------------------------
--  Indexxxes
--------------------------------------------------------

CREATE INDEX "BATCH_ADDRESS_UPDATE_IDX1" ON "BATCH_ADDRESS_UPDATE" ("PROCESS_STATUS", "REQUEST_TIME");
CREATE INDEX "BATCH_ADDRESS_UPDATE_IDX2" ON "BATCH_ADDRESS_UPDATE" ("REQUESTOR_ID", "PROCESS_STATUS");
CREATE INDEX "BATCH_ADDRESS_UPDATE_GDPR" ON "BATCH_ADDRESS_UPDATE" ("PROCESS_TIME");

--------------------------------------------------------
--  Constraints for Table BATCH_CHANGE_PRICEPLAN
--------------------------------------------------------

ALTER TABLE "BATCH_ADDRESS_UPDATE" ADD CONSTRAINT "BATCH_ADDRESS_UPDATE_101" CHECK (process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_PASSED', 'ON_HOLD', 'DUPLICATE')) ENABLE NOVALIDATE;

--------------------------------------------------------
--  DDL for Trigger BATCH_CHANGE_PRICEPLAN_TRG1
--------------------------------------------------------

CREATE OR REPLACE TRIGGER "BATCH_ADDRESS_UPDATE_TRG1"
 BEFORE
  INSERT
 ON batch_address_update
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    v_cnt   NUMBER DEFAULT 0;
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
     :new.process_status := 'WAITING';
   END IF;

  END IF;
 END;
/
ALTER TRIGGER "BATCH_ADDRESS_UPDATE_TRG1" ENABLE;


-- Grants for Table
GRANT ALTER ON batch_address_update TO ninjamain
/
GRANT DELETE ON batch_address_update TO ninjamain
/
GRANT INDEX ON batch_address_update TO ninjamain
/
GRANT INSERT ON batch_address_update TO ninjamain
/
GRANT SELECT ON batch_address_update TO ninjamain
/
GRANT UPDATE ON batch_address_update TO ninjamain
/
GRANT REFERENCES ON batch_address_update TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_address_update TO ninjamain
/
GRANT QUERY REWRITE ON batch_address_update TO ninjamain
/
GRANT DEBUG ON batch_address_update TO ninjamain
/
GRANT FLASHBACK ON batch_address_update TO ninjamain
/
GRANT ALTER ON batch_address_update TO ninjateam
/
GRANT DELETE ON batch_address_update TO ninjateam
/
GRANT INDEX ON batch_address_update TO ninjateam
/
GRANT INSERT ON batch_address_update TO ninjateam
/
GRANT SELECT ON batch_address_update TO ninjateam
/
GRANT UPDATE ON batch_address_update TO ninjateam
/
GRANT REFERENCES ON batch_address_update TO ninjateam
/
GRANT ON COMMIT REFRESH ON batch_address_update TO ninjateam
/
GRANT QUERY REWRITE ON batch_address_update TO ninjateam
/
GRANT DEBUG ON batch_address_update TO ninjateam
/
GRANT FLASHBACK ON batch_address_update TO ninjateam
/
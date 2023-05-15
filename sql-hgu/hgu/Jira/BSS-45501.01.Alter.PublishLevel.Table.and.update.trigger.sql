ALTER TABLE batch_publishlevel_update
ADD (
   request_time DATE 
);

CREATE OR REPLACE TRIGGER batch_publishlevel_update_trg1
 BEFORE
  INSERT
 ON batch_publishlevel_update
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    v_cnt1 NUMBER;
BEGIN
    IF INSERTING
    THEN
        -- Ensure that the unique id is updated correctly
        SELECT  BATCH_PUB_LVL_UPDATE_TRX_SEQ.NEXTVAL    
        INTO    :new.transaction_number
        FROM    dual;   

        -- If status of record is null, default it to 'WAITING'
        IF :new.process_status IS NULL THEN
            :new.process_status := 'WAITING';
        END IF;

        IF :new.record_creation_date IS NULL THEN
            :new.record_creation_date := SYSDATE;
        END IF; 

        IF :new.request_time IS NULL THEN
            :new.request_time := SYSDATE;
        END IF; 
        
    END IF;
END;
/

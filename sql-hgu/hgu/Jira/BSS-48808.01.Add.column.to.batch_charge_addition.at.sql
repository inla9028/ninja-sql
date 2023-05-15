ALTER TABLE batch_charge_addition
  ADD request_time  DATE
;

COMMENT ON COLUMN batch_charge_addition.request_time IS 'Requested date and time for the charge to be executed (optional)'
;

CREATE INDEX batch_charge_addition_req_time ON batch_charge_addition ("REQUEST_TIME")
;

CREATE OR REPLACE TRIGGER batch_charge_addition_trg1
 BEFORE
  INSERT
 ON batch_charge_addition
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW

BEGIN
	IF INSERTING
	THEN
	    -- Ensure that the unique id is updated correctly
		SELECT	BATCH_CHARGE_ADDITION_TRX_SEQ.NEXTVAL		
		INTO	:new.transaction_number
		FROM	dual;	

        -- If status of record is null, default it to 'WAITING'
        IF :new.process_status IS NULL THEN
            :new.process_status := 'WAITING';
        END IF;

        IF :new.record_creation_date IS NULL THEN
            :new.record_creation_date := sysdate;
        END IF;

        IF :new.request_time IS NULL THEN
            :new.request_time := sysdate;
        END IF;
        
        IF :new.request_user_id = 'KONTANT' THEN
            IF :new.charge_code IS NULL THEN
                :new.charge_code := 'FLEX';
            END IF;
            IF :new.actv_reason_code IS NULL THEN
                :new.actv_reason_code := 'PRPCHG';
            END IF;
            IF :new.memo_text IS NULL THEN
                :new.memo_text := 'Monthly Refill';
            END IF;
        END IF;	
    END IF;
END;


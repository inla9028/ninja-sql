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
        
        -- HGU 2007-07-28: If the effective date wasn't specified, use the
        -- record creation date (we want it to be EXACTLY the same.
        IF :new.effective_date IS NULL THEN
            :new.effective_date := :new.record_creation_date;
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

        -- HGU :: If this is the 1st of the Month, and it is between 01:00 and 18:59,
        --     :: and the charge code is 'FLXSMS', "generate" a stream value other than '1'.
        --IF :new.charge_code IN ('FLEX', 'FLXSMS', 'FLXMMS', 'FLXVEN') AND TO_CHAR(SYSDATE,'DD') = '01' AND TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) BETWEEN 01 AND 18 THEN
        -- HGU :: If this is the 1st of the Month, and the charge code is a Flex-one, "generate" a stream value other than '1'.
        IF :new.charge_code IN ('FLEX', 'FLXSMS', 'FLXMMS', 'FLXVEN') AND TO_CHAR(SYSDATE,'DD') = '01' THEN
            -- Generate a unique stream value based on the msisdn...
            IF :new.subscriber_no IS NULL THEN
                -- In case no number exists (BAN level socs), leave it to 1.
                :new.stream := 1;
            ELSE
                :new.stream := MOD(:new.subscriber_no, 10) + 2;
            END IF;
        ELSE
            --  For all other charges if stream is null default it to 1
            IF :new.stream IS NULL THEN
                :new.stream := 1;
            END IF;
        END IF;

    END IF;
END;


CREATE OR REPLACE TRIGGER dsp_request_trg2
    BEFORE DELETE
    ON dsp_request
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF DELETING
    THEN
        -- Delete the corresponding row in DSP_RESPONSE
        DELETE FROM dsp_response WHERE request_id = :OLD.request_id;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER oldb_services_trg2
    BEFORE DELETE
    ON oldb_services
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF DELETING
    THEN
        -- Delete all rows in the XLDB_SERVICE_PARAMS table for the same SERVICE_SEQ_NO
        IF :OLD.service_seq_no IS NOT NULL
        THEN
            DELETE FROM oldb_service_params WHERE service_seq_no = :OLD.service_seq_no;
        END IF;
    END IF;
END;
/


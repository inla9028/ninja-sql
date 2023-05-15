CREATE OR REPLACE TRIGGER oldb_master_transactions_trg2
    BEFORE DELETE
    ON oldb_master_transactions
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF DELETING
    THEN
        -- Delete all rows in the neighbouring tables for this transaction_id
        IF :OLD.transaction_id IS NOT NULL
        THEN
            DELETE FROM oldb_additional_info_details WHERE master_trx_id = :OLD.transaction_id;
            DELETE FROM oldb_address_name_details    WHERE master_trx_id = :OLD.transaction_id;
            DELETE FROM oldb_ban_details             WHERE master_trx_id = :OLD.transaction_id;
            DELETE FROM oldb_credit_check_details    WHERE master_trx_id = :OLD.transaction_id;
            DELETE FROM oldb_equipment_details       WHERE master_trx_id = :OLD.transaction_id;
            DELETE FROM oldb_np_details              WHERE master_trx_id = :OLD.transaction_id;
            DELETE FROM oldb_services                WHERE master_trx_id = :OLD.transaction_id;
            DELETE FROM oldb_subscription_details    WHERE master_trx_id = :OLD.transaction_id;
            /*
            ** Note! The table OLDB_SERVICE_PARAMS does not have a master_trx_id,
            ** instead it has SERVICE_SEQ_NO, which refers to OLDB_SERVICES.SERVICE_SEQ_NO,
            ** thus we need a trigger on OLDB_SERVICES to delete that...
            */
        END IF;
    END IF;
END;
/


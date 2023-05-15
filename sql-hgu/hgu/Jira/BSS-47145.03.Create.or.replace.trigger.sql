CREATE OR REPLACE TRIGGER ninja_time_port_trg2
 BEFORE
  DELETE
 ON ninja_time_port
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    IF DELETING
    THEN
        -- Delete all rows in the neighbouring tables for this ninja_ref_id
        IF :OLD.ninja_ref_id IS NOT NULL
        THEN
            DELETE FROM ninja_time_port_adt_info     WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_adt_nos      WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_equipment    WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_downpayments WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_srv_ftr_prms WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_services     WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_sub_info     WHERE ninja_ref_id = :OLD.ninja_ref_id;
        END IF;
    END IF;
END;
/


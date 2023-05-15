CREATE TABLE ninja_time_port_adt_params (
    ninja_ref_id                   NUMBER(8,0),
    param_type                     VARCHAR2(60 CHAR),
    param_name                     VARCHAR2(60 CHAR),
    param_value                    VARCHAR2(200 CHAR)
)
/

-- Grants for Table
GRANT ALTER ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT DELETE ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT INDEX ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT INSERT ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT SELECT ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT UPDATE ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT REFERENCES ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT ON COMMIT REFRESH ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT QUERY REWRITE ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT DEBUG ON ninja_time_port_adt_params TO ninjamain_at
/
GRANT FLASHBACK ON ninja_time_port_adt_params TO ninjamain_at
/

-- Indexes for ninja_time_port_adt_params

CREATE UNIQUE INDEX ntp_adt_params_idx1 ON ninja_time_port_adt_params (
    ninja_ref_id                    ASC,
    param_type                      ASC,
    param_name                      ASC
)
/


-- Constraints for ninja_time_port_adt_params

ALTER TABLE ninja_time_port_adt_params
ADD CHECK (ninja_ref_id IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE ninja_time_port_adt_params
ADD CHECK (param_type IS NOT NULL)
ENABLE NOVALIDATE
/

ALTER TABLE ninja_time_port_adt_params
ADD CHECK (param_name IS NOT NULL)
ENABLE NOVALIDATE
/


-- Foreign Key
ALTER TABLE ninja_time_port_adt_params
ADD CONSTRAINT ntp_adt_params_fk1 FOREIGN KEY (ninja_ref_id)
REFERENCES ninja_time_port (ninja_ref_id)
ENABLE NOVALIDATE
/

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
            DELETE FROM ninja_time_port_adt_params   WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_equipment    WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_downpayments WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_srv_ftr_prms WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_services     WHERE ninja_ref_id = :OLD.ninja_ref_id;
            DELETE FROM ninja_time_port_sub_info     WHERE ninja_ref_id = :OLD.ninja_ref_id;
        END IF;
    END IF;
END;
/

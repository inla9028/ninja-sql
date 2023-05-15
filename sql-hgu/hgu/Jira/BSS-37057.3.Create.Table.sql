CREATE TABLE neo_sim_types
(
    brand              VARCHAR2 (64) NOT NULL,
    neo_type           VARCHAR2 (64) NOT NULL,
    sim_type           VARCHAR2 (64) NOT NULL,
    effective_date     DATE          NOT NULL,
    expiration_date    DATE          NOT NULL,
    description        VARCHAR2 (200)
);

-- Grants for Table
GRANT ALTER ON neo_sim_types TO ninjamain
/
GRANT DELETE ON neo_sim_types TO ninjamain
/
GRANT INDEX ON neo_sim_types TO ninjamain
/
GRANT INSERT ON neo_sim_types TO ninjamain
/
GRANT SELECT ON neo_sim_types TO ninjamain
/
GRANT UPDATE ON neo_sim_types TO ninjamain
/
GRANT REFERENCES ON neo_sim_types TO ninjamain
/
GRANT ON COMMIT REFRESH ON neo_sim_types TO ninjamain
/
GRANT QUERY REWRITE ON neo_sim_types TO ninjamain
/
GRANT DEBUG ON neo_sim_types TO ninjamain
/
GRANT FLASHBACK ON neo_sim_types TO ninjamain
/
GRANT ALTER ON neo_sim_types TO ninjadata
/
GRANT DELETE ON neo_sim_types TO ninjadata
/
GRANT INDEX ON neo_sim_types TO ninjadata
/
GRANT INSERT ON neo_sim_types TO ninjadata
/
GRANT SELECT ON neo_sim_types TO ninjadata
/
GRANT UPDATE ON neo_sim_types TO ninjadata
/
GRANT REFERENCES ON neo_sim_types TO ninjadata
/
GRANT ON COMMIT REFRESH ON neo_sim_types TO ninjadata
/
GRANT QUERY REWRITE ON neo_sim_types TO ninjadata
/
GRANT ALTER ON neo_sim_types TO ninjateam
/
GRANT DELETE ON neo_sim_types TO ninjateam
/
GRANT INDEX ON neo_sim_types TO ninjateam
/
GRANT INSERT ON neo_sim_types TO ninjateam
/
GRANT SELECT ON neo_sim_types TO ninjateam
/
GRANT UPDATE ON neo_sim_types TO ninjateam
/
GRANT REFERENCES ON neo_sim_types TO ninjateam
/

CREATE INDEX neo_sim_types_idx1
    ON neo_sim_types (effective_date ASC, expiration_date ASC)
/

CREATE OR REPLACE TRIGGER neo_sim_types_trg
    BEFORE INSERT
    ON neo_sim_types
    REFERENCING NEW AS new OLD AS old
    FOR EACH ROW
DECLARE
    updating_key_fields   EXCEPTION;
BEGIN
    IF INSERTING
    THEN
        --== Ensure we record the reserve_date
        IF :new.effective_date IS NULL
        THEN
            :new.effective_date := TRUNC(SYSDATE);
        END IF;
        --== Ensure we record the last_update_date
        IF :new.expiration_date IS NULL
        THEN
            :new.expiration_date := TO_DATE('4700-12-31', 'YYYY-MM-DD');
        END IF;
    END IF;
EXCEPTION
    WHEN updating_key_fields
    THEN
        raise_application_error (
            -20300,
            'NinjaDB Error: Failed to insert row into neo_sim_types table.');
END neo_sim_types_trg;
/

ALTER TRIGGER neo_sim_types_trg ENABLE;

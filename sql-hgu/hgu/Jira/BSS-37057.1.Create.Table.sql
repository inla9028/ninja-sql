CREATE TABLE reserved_sim_numbers
(
    sim_number         VARCHAR2 (20)  NOT NULL,
    reserve_id         VARCHAR2 (128) NOT NULL,
    reserve_date       DATE           NOT NULL,
    status             VARCHAR2 (20),
    last_update_date   DATE           NOT NULL,
    dealer_code        VARCHAR2 (5),
    hlr                VARCHAR2 (3),
    imsi               VARCHAR2 (15),
    location           CHAR (4),
    pin                NUMBER (4, 0),
    pin2               NUMBER (4, 0),
    puk                NUMBER (8, 0),
    puk2               NUMBER (8, 0),
    sim_type           CHAR (3),
    matching_id        VARCHAR2 (128)
);

-- Grants for Table
GRANT ALTER ON reserved_sim_numbers TO ninjamain
/
GRANT DELETE ON reserved_sim_numbers TO ninjamain
/
GRANT INDEX ON reserved_sim_numbers TO ninjamain
/
GRANT INSERT ON reserved_sim_numbers TO ninjamain
/
GRANT SELECT ON reserved_sim_numbers TO ninjamain
/
GRANT UPDATE ON reserved_sim_numbers TO ninjamain
/
GRANT REFERENCES ON reserved_sim_numbers TO ninjamain
/
GRANT ON COMMIT REFRESH ON reserved_sim_numbers TO ninjamain
/
GRANT QUERY REWRITE ON reserved_sim_numbers TO ninjamain
/
GRANT DEBUG ON reserved_sim_numbers TO ninjamain
/
GRANT FLASHBACK ON reserved_sim_numbers TO ninjamain
/
GRANT ALTER ON reserved_sim_numbers TO ninjateam
/
GRANT DELETE ON reserved_sim_numbers TO ninjateam
/
GRANT INDEX ON reserved_sim_numbers TO ninjateam
/
GRANT INSERT ON reserved_sim_numbers TO ninjateam
/
GRANT SELECT ON reserved_sim_numbers TO ninjateam
/
GRANT UPDATE ON reserved_sim_numbers TO ninjateam
/
GRANT REFERENCES ON reserved_sim_numbers TO ninjateam
/

ALTER TABLE reserved_sim_numbers
ADD CONSTRAINT reserved_sim_numbers_pk PRIMARY KEY (sim_number)
USING INDEX
/

CREATE INDEX reserved_sim_numbers_idx1
    ON reserved_sim_numbers (reserve_id ASC)
/

CREATE INDEX reserved_sim_numbers_idx2
    ON reserved_sim_numbers (reserve_date ASC, status ASC)
/


CREATE OR REPLACE TRIGGER reserved_sim_numbers_trg
    BEFORE INSERT
    ON reserved_sim_numbers
    REFERENCING NEW AS new OLD AS old
    FOR EACH ROW
DECLARE
    updating_key_fields   EXCEPTION;
BEGIN
    IF INSERTING
    THEN
        --== Ensure we record the reserve_date
        IF :new.reserve_date IS NULL
        THEN
            :new.reserve_date := SYSDATE;
        END IF;
        --== Ensure we record the last_update_date
        IF :new.last_update_date IS NULL
        THEN
            :new.last_update_date := SYSDATE;
        END IF;
        --== Default status to RESERVED
        IF :new.status IS NULL
        THEN
            :new.status := 'RESERVED';
        END IF;
    END IF;
EXCEPTION
    WHEN updating_key_fields
    THEN
        raise_application_error (
            -20300,
            'NinjaDB Error: Failed to insert row into RESERVED_SIM_NUMBERS table.');
END reserved_sim_numbers_trg;
/

ALTER TRIGGER reserved_sim_numbers_trg ENABLE;

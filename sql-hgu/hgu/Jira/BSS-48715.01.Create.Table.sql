CREATE TABLE batch_tree_discount ( 
	ban             NUMBER(9,0),
	action          VARCHAR2(20 CHAR), 
	discount_code   VARCHAR2(32 CHAR),
	cycle_start     VARCHAR2(32 CHAR),
	dealer_code     VARCHAR2(32 CHAR),
	request_id      VARCHAR2(60 CHAR),
	request_time    DATE,
	process_status  VARCHAR2(20 CHAR), 
	process_time    DATE, 
	status_desc     VARCHAR2(2000 CHAR)
);


CREATE INDEX batch_tree_discount_rqi ON batch_tree_discount (request_id);
CREATE INDEX batch_tree_discount_rqt ON batch_tree_discount (request_time);
CREATE INDEX batch_tree_discount_sts ON batch_tree_discount (process_status);

ALTER TABLE batch_tree_discount ADD CONSTRAINT ban_tree_disc_action CHECK ( action         IN ('ADD', 'DELETE') ) ENABLE;
-- ALTER TABLE batch_tree_discount ADD CONSTRAINT ban_tree_disc_cycle  CHECK ( cycle_start    IN ('C', 'N') ) ENABLE;
ALTER TABLE batch_tree_discount ADD CONSTRAINT ban_tree_disc_status CHECK ( process_status IN ('WAITING', 'PRSD_ERROR', 'PRSD_SUCCESS', 'ON_HOLD', 'IN_PROGRESS') ) ENABLE;

-- Grants for Table
/*
GRANT ALTER ON batch_tree_discount TO ninjateam
/
GRANT DELETE ON batch_tree_discount TO ninjateam
/
GRANT INDEX ON batch_tree_discount TO ninjateam
/
GRANT INSERT ON batch_tree_discount TO ninjateam
/
GRANT SELECT ON batch_tree_discount TO ninjateam
/
GRANT UPDATE ON batch_tree_discount TO ninjateam
/
GRANT REFERENCES ON batch_tree_discount TO ninjateam
/
*/
GRANT ALTER ON batch_tree_discount TO ninjamain
/
GRANT DELETE ON batch_tree_discount TO ninjamain
/
GRANT INDEX ON batch_tree_discount TO ninjamain
/
GRANT INSERT ON batch_tree_discount TO ninjamain
/
GRANT SELECT ON batch_tree_discount TO ninjamain
/
GRANT UPDATE ON batch_tree_discount TO ninjamain
/
GRANT REFERENCES ON batch_tree_discount TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_tree_discount TO ninjamain
/
GRANT QUERY REWRITE ON batch_tree_discount TO ninjamain
/
GRANT DEBUG ON batch_tree_discount TO ninjamain
/
GRANT FLASHBACK ON batch_tree_discount TO ninjamain
/

CREATE OR REPLACE TRIGGER batch_tree_discount_trg
 BEFORE
  INSERT
 ON batch_tree_discount
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
    -- If inserting a new record.....
    IF inserting THEN

        IF :new.action IS NULL
        THEN
            :new.action := 'ADD';
        END IF;
        
        IF :new.process_status IS NULL
        THEN
            :new.process_status := 'WAITING';
        END IF;

        IF :new.request_time IS NULL
        THEN
            :new.request_time := sysdate;
        END IF;

        IF :new.request_id IS NULL
        THEN
            :new.request_id := 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD');
        END IF;

    END IF;

END;
/

ALTER TRIGGER batch_tree_discount_trg ENABLE;

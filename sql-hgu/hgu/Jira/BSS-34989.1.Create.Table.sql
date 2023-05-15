CREATE TABLE ban_level_socs_trx (
	trans_number         NUMBER(9,0),
	ban                  NUMBER(9,0) NOT NULL,
	soc                  VARCHAR2(9) NOT NULL,
	action_code          VARCHAR2(15) NOT NULL,
	dealer_code          VARCHAR2(5),
	sales_agent          VARCHAR2(5),
	memo_text	     VARCHAR2(300),
	enter_time           DATE NOT NULL,
	request_time         DATE NOT NULL,
	process_time         DATE NULL,
	process_status       VARCHAR2(20) NOT NULL,
	request_id           VARCHAR2(30) NOT NULL,
	status_desc          VARCHAR2(2000)
);

-- Grants for Table
GRANT ALTER ON ban_level_socs_trx TO ninjamain
/
GRANT DELETE ON ban_level_socs_trx TO ninjamain
/
GRANT INDEX ON ban_level_socs_trx TO ninjamain
/
GRANT INSERT ON ban_level_socs_trx TO ninjamain
/
GRANT SELECT ON ban_level_socs_trx TO ninjamain
/
GRANT UPDATE ON ban_level_socs_trx TO ninjamain
/
GRANT REFERENCES ON ban_level_socs_trx TO ninjamain
/
GRANT ON COMMIT REFRESH ON ban_level_socs_trx TO ninjamain
/
GRANT QUERY REWRITE ON ban_level_socs_trx TO ninjamain
/
GRANT DEBUG ON ban_level_socs_trx TO ninjamain
/
GRANT FLASHBACK ON ban_level_socs_trx TO ninjamain
/
GRANT ALTER ON ban_level_socs_trx TO ninjateam
/
GRANT DELETE ON ban_level_socs_trx TO ninjateam
/
GRANT INDEX ON ban_level_socs_trx TO ninjateam
/
GRANT INSERT ON ban_level_socs_trx TO ninjateam
/
GRANT SELECT ON ban_level_socs_trx TO ninjateam
/
GRANT UPDATE ON ban_level_socs_trx TO ninjateam
/
GRANT REFERENCES ON ban_level_socs_trx TO ninjateam
/

ALTER TABLE ban_level_socs_trx
ADD CONSTRAINT ban_level_socs_trx_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

ALTER TABLE ban_level_socs_trx
ADD CONSTRAINT ban_level_socs_trx_pk PRIMARY KEY (trans_number)
USING INDEX
/

CREATE INDEX ban_level_socs_idx1 ON ban_level_socs_trx
  (
    request_time		ASC,
    process_status		ASC
  )
/

CREATE INDEX ban_level_socs_idx2 ON ban_level_socs_trx
  (
    process_status		ASC,
    process_time		ASC
  )
/

CREATE INDEX ban_level_socs_idx3 ON ban_level_socs_trx
  (
    request_id			ASC
  )
/

--CREATE INDEX ban_level_socs_idx4 ON ban_level_socs_trx
--  (
--    request_id			ASC
--  )
--/


CREATE OR REPLACE TRIGGER ban_level_socs_trg
 BEFORE
  INSERT
 ON ban_level_socs_trx
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
	updating_key_fields EXCEPTION;
BEGIN
  IF INSERTING
	THEN
	--== Enforce the uniqueness of the transaction number.
	SELECT ban_level_socs_seq.nextval
	  INTO :new.trans_number
	  FROM dual;
	--== If status of record is null, default it to 'WAITING'
	IF :new.process_status IS NULL THEN
		:new.process_status := 'WAITING';
	END IF;
	--== Ensure we record the enter time
	IF :new.enter_time IS NULL THEN
		:new.enter_time := SYSDATE;
	END IF;
	--== Ensure we record the request time
	IF :new.request_time IS NULL THEN
		:new.request_time := SYSDATE;
	END IF;
  END IF;
	EXCEPTION
		WHEN updating_key_fields THEN
			raise_application_error(-20300, 'NinjaDB Error: cannot update key fields of source table.');
END ban_level_socs_trg;
/
ALTER TRIGGER ban_level_socs_trg ENABLE;


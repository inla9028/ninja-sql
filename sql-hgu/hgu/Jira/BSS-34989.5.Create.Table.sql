CREATE TABLE batch_print_category (
	trans_number         NUMBER(9,0),
	ban                  NUMBER(9,0) NOT NULL,
	print_category       VARCHAR2(9) NOT NULL,
	email                VARCHAR2(150) NOT NULL,
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
GRANT ALTER ON batch_print_category TO ninjamain
/
GRANT DELETE ON batch_print_category TO ninjamain
/
GRANT INDEX ON batch_print_category TO ninjamain
/
GRANT INSERT ON batch_print_category TO ninjamain
/
GRANT SELECT ON batch_print_category TO ninjamain
/
GRANT UPDATE ON batch_print_category TO ninjamain
/
GRANT REFERENCES ON batch_print_category TO ninjamain
/
GRANT ON COMMIT REFRESH ON batch_print_category TO ninjamain
/
GRANT QUERY REWRITE ON batch_print_category TO ninjamain
/
GRANT DEBUG ON batch_print_category TO ninjamain
/
GRANT FLASHBACK ON batch_print_category TO ninjamain
/
GRANT ALTER ON batch_print_category TO ninjateam
/
GRANT DELETE ON batch_print_category TO ninjateam
/
GRANT INDEX ON batch_print_category TO ninjateam
/
GRANT INSERT ON batch_print_category TO ninjateam
/
GRANT SELECT ON batch_print_category TO ninjateam
/
GRANT UPDATE ON batch_print_category TO ninjateam
/
GRANT REFERENCES ON batch_print_category TO ninjateam
/

ALTER TABLE batch_print_category
ADD CONSTRAINT batch_print_cat_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

ALTER TABLE batch_print_category
ADD CONSTRAINT batch_print_cat_pk PRIMARY KEY (trans_number)
USING INDEX
/

CREATE INDEX batch_print_cat_idx1 ON batch_print_category
  (
    request_time		ASC,
    process_status		ASC
  )
/

CREATE INDEX batch_print_cat_idx2 ON batch_print_category
  (
    process_status		ASC,
    process_time		ASC
  )
/

CREATE INDEX batch_print_cat_idx3 ON batch_print_category
  (
    request_id			ASC
  )
/

--CREATE INDEX batch_print_cat_idx4 ON batch_print_category
--  (
--    request_id			ASC
--  )
--/


CREATE OR REPLACE TRIGGER batch_print_cat_trg
 BEFORE
  INSERT
 ON batch_print_category
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
	updating_key_fields EXCEPTION;
BEGIN
  IF INSERTING
	THEN
	--== Enforce the uniqueness of the transaction number.
	SELECT batch_print_cat_seq.nextval
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
END batch_print_cat_trg;
/
ALTER TRIGGER batch_print_cat_trg ENABLE;


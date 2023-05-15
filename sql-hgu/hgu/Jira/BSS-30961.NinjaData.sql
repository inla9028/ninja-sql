CREATE SEQUENCE dsp_request_seq
	MINVALUE 1
	MAXVALUE 999999999999999999999999999
	INCREMENT BY 1
	START WITH 1
	CACHE 20 
	NOORDER 
	NOCYCLE
/

CREATE TABLE dsp_request (
	request_id           NUMBER(10,0),
	customer_id          NUMBER(9,0),
	adr_first_name       VARCHAR2(32),
	adr_last_name        VARCHAR2(60),
	adr_birth_date       DATE,
	adr_zip              VARCHAR2(9),
	record_creation_date DATE NOT NULL,
	process_status       VARCHAR2(20) NOT NULL,
	request_user_id      VARCHAR2(30) NOT NULL,
	process_time         DATE,
	status_desc          VARCHAR2(2000)
);

-- Grants for Table
GRANT ALTER ON dsp_request TO ninjamain
/
GRANT DELETE ON dsp_request TO ninjamain
/
GRANT INDEX ON dsp_request TO ninjamain
/
GRANT INSERT ON dsp_request TO ninjamain
/
GRANT SELECT ON dsp_request TO ninjamain
/
GRANT UPDATE ON dsp_request TO ninjamain
/
GRANT REFERENCES ON dsp_request TO ninjamain
/
GRANT ON COMMIT REFRESH ON dsp_request TO ninjamain
/
GRANT QUERY REWRITE ON dsp_request TO ninjamain
/
GRANT DEBUG ON dsp_request TO ninjamain
/
GRANT FLASHBACK ON dsp_request TO ninjamain
/
GRANT ALTER ON dsp_request TO ninjateam
/
GRANT DELETE ON dsp_request TO ninjateam
/
GRANT INDEX ON dsp_request TO ninjateam
/
GRANT INSERT ON dsp_request TO ninjateam
/
GRANT SELECT ON dsp_request TO ninjateam
/
GRANT UPDATE ON dsp_request TO ninjateam
/
GRANT REFERENCES ON dsp_request TO ninjateam
/

ALTER TABLE dsp_request
ADD CONSTRAINT dsp_request_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

ALTER TABLE dsp_request
ADD CONSTRAINT dsp_request_pk PRIMARY KEY (request_id)
USING INDEX
/
ALTER TABLE dsp_request MODIFY (ADR_BIRTH_DATE NOT NULL ENABLE);
ALTER TABLE dsp_request MODIFY (ADR_LAST_NAME NOT NULL ENABLE);
ALTER TABLE dsp_request MODIFY (ADR_FIRST_NAME NOT NULL ENABLE);
ALTER TABLE dsp_request MODIFY (REQUEST_ID NOT NULL ENABLE);

CREATE INDEX dsp_request_idx1 ON dsp_request
  (
    record_creation_date	ASC,
    process_status		ASC
  )
/

CREATE INDEX dsp_request_idx2 ON dsp_request
  (
    process_status		ASC,
    process_time		ASC
  )
/

CREATE INDEX dsp_request_idx3 ON dsp_request
  (
    request_user_id		ASC
  )
/

--CREATE INDEX dsp_request_idx4 ON dsp_request
--  (
--    request_id			ASC
--  )
--/


CREATE OR REPLACE TRIGGER dsp_request_trg
 BEFORE
  INSERT
 ON dsp_request
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
	updating_key_fields EXCEPTION;
BEGIN
  IF INSERTING
	THEN
	--== Enforce the uniqueness of the request id.
	SELECT dsp_request_seq.nextval
	  INTO :new.request_id
	  FROM dual;

	--== If status of record is null, default it to 'WAITING'
	IF :new.process_status IS NULL THEN
		:new.process_status := 'WAITING';
	END IF;
	--== Ensure we record the created date
	IF :new.record_creation_date IS NULL THEN
		:new.record_creation_date := SYSDATE;
	END IF;
	--== Ensure a user id is set.
	IF :new.request_user_id IS NULL THEN
		:new.request_user_id := 'NINJA ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD');
	END IF;
  END IF;
	EXCEPTION
		WHEN updating_key_fields THEN
			raise_application_error(-20300, 'NinjaDB Error: cannot update key fields of source table.');
END dsp_request_trg;
/
ALTER TRIGGER dsp_request_trg ENABLE;

CREATE TABLE dsp_response (
	request_id           NUMBER(10,0),
	adr_last_name        VARCHAR2(60),
	adr_first_name       VARCHAR2(32),
	adr_birth_date       VARCHAR2(8),
	adr_city             VARCHAR2(39),
	adr_zip              VARCHAR2(9),
	adr_house_no         VARCHAR2(20),
	adr_street_name      VARCHAR2(60),
	adr_pob              VARCHAR2(20),
	adr_country          VARCHAR2(3),
	adr_house_letter     VARCHAR2(2),
	adr_storey           VARCHAR2(2),
	adr_door_no          VARCHAR2(4),
	adr_district         VARCHAR2(40),
	adr_gender           VARCHAR2(1),
	adr_stat             VARCHAR2(10),
	dsp_id               VARCHAR2(20),
	record_creation_date DATE NOT NULL,
	process_status       VARCHAR2(20) NOT NULL,
	process_time         DATE,
	status_desc          VARCHAR2(2000)
);

-- Grants for Table
GRANT ALTER ON dsp_response TO ninjamain
/
GRANT DELETE ON dsp_response TO ninjamain
/
GRANT INDEX ON dsp_response TO ninjamain
/
GRANT INSERT ON dsp_response TO ninjamain
/
GRANT SELECT ON dsp_response TO ninjamain
/
GRANT UPDATE ON dsp_response TO ninjamain
/
GRANT REFERENCES ON dsp_response TO ninjamain
/
GRANT ON COMMIT REFRESH ON dsp_response TO ninjamain
/
GRANT QUERY REWRITE ON dsp_response TO ninjamain
/
GRANT DEBUG ON dsp_response TO ninjamain
/
GRANT FLASHBACK ON dsp_response TO ninjamain
/
GRANT ALTER ON dsp_response TO ninjateam
/
GRANT DELETE ON dsp_response TO ninjateam
/
GRANT INDEX ON dsp_response TO ninjateam
/
GRANT INSERT ON dsp_response TO ninjateam
/
GRANT SELECT ON dsp_response TO ninjateam
/
GRANT UPDATE ON dsp_response TO ninjateam
/
GRANT REFERENCES ON dsp_response TO ninjateam
/

ALTER TABLE dsp_response
ADD CONSTRAINT dsp_response_con1 CHECK ( process_status IN ('WAITING', 'IN_PROGRESS', 'PRSD_SUCCESS', 'PRSD_ERROR', 'ON_HOLD'))
/

ALTER TABLE dsp_response
ADD CONSTRAINT dsp_response_pk PRIMARY KEY (request_id)
USING INDEX
/

ALTER TABLE dsp_response
MODIFY (request_id NOT NULL ENABLE)
/

CREATE INDEX dsp_response_idx1 ON dsp_response
  (
    record_creation_date	ASC,
    process_status		ASC
  )
/

CREATE INDEX dsp_response_idx2 ON dsp_response
  (
    process_status		ASC,
    process_time		ASC
  )
/

CREATE OR REPLACE TRIGGER dsp_response_trg
 BEFORE
  INSERT
 ON dsp_response
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
	updating_key_fields EXCEPTION;
BEGIN
  IF INSERTING
	THEN
	--== If status of record is null, default it to 'WAITING'
	IF :new.process_status IS NULL THEN
		:new.process_status := 'WAITING';
	END IF;
	--== Ensure we record the created date
	IF :new.record_creation_date IS NULL THEN
		:new.record_creation_date := SYSDATE;
	END IF;
  END IF;
	EXCEPTION
		WHEN updating_key_fields THEN
			raise_application_error(-20300, 'NinjaDB Error: cannot update key fields of source table.');
END dsp_response_trg;
/
ALTER TRIGGER dsp_response_trg ENABLE;

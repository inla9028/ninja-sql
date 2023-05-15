SELECT rq.*
  FROM dsp_request rq
 WHERE ROWNUM < 11
;

/*
** Add columns.
*/
ALTER TABLE
   dsp_request
ADD (
   subscriber_no  VARCHAR2(20 CHAR), 
   link_type      VARCHAR2(1 CHAR),
   comp_reg_id    VARCHAR2(100 CHAR)
);

UPDATE dsp_request rq
   SET rq.link_type = 'L'
;

ALTER TABLE dsp_request
ADD CONSTRAINT dsp_request_con2 CHECK ( link_type IN ('B', 'L', 'U'))
;

-- Triggers for DSP_REQUEST

CREATE OR REPLACE TRIGGER dsp_request_trg
 BEFORE
  INSERT
 ON dsp_request
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
    missing_mandatory_column EXCEPTION;
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
    --== If LINK_TYPE is U, enforce an entry in SUBSCRIBER_NO
    IF (:new.link_type = 'U' AND :new.subscriber_no IS NULL) THEN
        RAISE missing_mandatory_column;
    END IF;
    --==
  END IF;
    EXCEPTION
        WHEN missing_mandatory_column THEN
            raise_application_error(-20000, 'LINK_TYPE = ''U'' requires SUBSCRIBER_NO');
END dsp_request_trg;


SELECT rq.*
  FROM dsp_request rq
 WHERE ROWNUM < 11
;

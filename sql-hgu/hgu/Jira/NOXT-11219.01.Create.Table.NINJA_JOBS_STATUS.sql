CREATE TABLE ninja_jobs_status (
    job_name                       VARCHAR2(256),
    duration                       NUMBER(9),
    process_time                   DATE,
    thread_name                    VARCHAR2(2000 CHAR)
)
/


-- Grants for Table
GRANT ALTER ON ninja_jobs_status TO ninjateam
/
GRANT DELETE ON ninja_jobs_status TO ninjateam
/
GRANT INDEX ON ninja_jobs_status TO ninjateam
/
GRANT INSERT ON ninja_jobs_status TO ninjateam
/
GRANT SELECT ON ninja_jobs_status TO ninjateam
/
GRANT UPDATE ON ninja_jobs_status TO ninjateam
/
GRANT REFERENCES ON ninja_jobs_status TO ninjateam
/
GRANT ALTER ON ninja_jobs_status TO ninjamaster
/
GRANT DELETE ON ninja_jobs_status TO ninjamaster
/
GRANT INDEX ON ninja_jobs_status TO ninjamaster
/
GRANT INSERT ON ninja_jobs_status TO ninjamaster
/
GRANT SELECT ON ninja_jobs_status TO ninjamaster
/
GRANT UPDATE ON ninja_jobs_status TO ninjamaster
/
GRANT REFERENCES ON ninja_jobs_status TO ninjamaster
/
GRANT ON COMMIT REFRESH ON ninja_jobs_status TO ninjamaster
/
GRANT QUERY REWRITE ON ninja_jobs_status TO ninjamaster
/
GRANT DEBUG ON ninja_jobs_status TO ninjamaster
/
GRANT FLASHBACK ON ninja_jobs_status TO ninjamaster
/
GRANT ALTER ON ninja_jobs_status TO ninjamain
/
GRANT DELETE ON ninja_jobs_status TO ninjamain
/
GRANT INDEX ON ninja_jobs_status TO ninjamain
/
GRANT INSERT ON ninja_jobs_status TO ninjamain
/
GRANT SELECT ON ninja_jobs_status TO ninjamain
/
GRANT UPDATE ON ninja_jobs_status TO ninjamain
/
GRANT REFERENCES ON ninja_jobs_status TO ninjamain
/
GRANT ON COMMIT REFRESH ON ninja_jobs_status TO ninjamain
/
GRANT QUERY REWRITE ON ninja_jobs_status TO ninjamain
/
GRANT DEBUG ON ninja_jobs_status TO ninjamain
/
GRANT FLASHBACK ON ninja_jobs_status TO ninjamain
/
GRANT SELECT ON ninja_jobs_status TO ks_user
/
GRANT SELECT ON ninja_jobs_status TO kontant
/
/
GRANT SELECT ON ninja_jobs_status TO readonly
/

-- Indexes for ninja_jobs_status

CREATE INDEX ninja_jobs_status_idx1 ON ninja_jobs_status (job_name, process_time);



-- Triggers for ninja_jobs_status

CREATE OR REPLACE TRIGGER ninja_jobs_status_trg1
 BEFORE
  INSERT
 ON ninja_jobs_status
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF INSERTING
  THEN
   IF :new.process_time IS NULL
   THEN
     SELECT SYSDATE
       INTO :new.process_time
       FROM dual;
   END IF;
  END IF;
 END;
/

--------------------------------------------------------
--  DDL for Table NSM_JOBS
--------------------------------------------------------
CREATE TABLE nsm_jobs
  (
    hostname       VARCHAR2(200 CHAR),
    job_id         NUMBER(6,0),
    job_status     VARCHAR2(15 CHAR),
    running        VARCHAR2(1 CHAR),
    sleep_time     NUMBER(10,0),
    time_frames    VARCHAR2(200 CHAR),
    next_exec_time DATE,
    status_time    DATE,
    fixed_start    VARCHAR2(1 CHAR),
    job_fqcn       VARCHAR2(200 CHAR),
    job_arg1       VARCHAR2(200 CHAR),
    job_arg2       VARCHAR2(200 CHAR),
    job_arg3       VARCHAR2(200 CHAR),
    job_arg4       VARCHAR2(200 CHAR),
    job_arg5       VARCHAR2(200 CHAR)
  )
;


--------------------------------------------------------
--  DDL for Index N_J_PK1
--------------------------------------------------------
CREATE UNIQUE INDEX nsm_jobs_pk1 ON nsm_jobs
  (
    hostname, job_id
  )
;


--------------------------------------------------------
--  Constraints for Table NSM_JOBS
--------------------------------------------------------

ALTER TABLE nsm_jobs MODIFY (hostname NOT NULL ENABLE NOVALIDATE);
ALTER TABLE nsm_jobs MODIFY (job_id NOT NULL ENABLE NOVALIDATE);
ALTER TABLE nsm_jobs MODIFY (job_status NOT NULL ENABLE NOVALIDATE);
ALTER TABLE nsm_jobs MODIFY (running NOT NULL ENABLE NOVALIDATE);
ALTER TABLE nsm_jobs MODIFY (sleep_time NOT NULL ENABLE NOVALIDATE);
ALTER TABLE nsm_jobs MODIFY (status_time NOT NULL ENABLE NOVALIDATE);
ALTER TABLE nsm_jobs MODIFY (fixed_start NOT NULL ENABLE NOVALIDATE);



--------------------------------------------------------
--  GRANTS
--------------------------------------------------------

GRANT ALTER ON nsm_jobs TO ninjarules;
GRANT DELETE ON nsm_jobs TO ninjarules;
GRANT INDEX ON nsm_jobs TO ninjarules;
GRANT INSERT ON nsm_jobs TO ninjarules;
GRANT SELECT ON nsm_jobs TO ninjarules;
GRANT UPDATE ON nsm_jobs TO ninjarules;
GRANT REFERENCES ON nsm_jobs TO ninjarules;
GRANT ALTER ON nsm_jobs TO ninjamain;
GRANT DELETE ON nsm_jobs TO ninjamain;
GRANT INDEX ON nsm_jobs TO ninjamain;
GRANT INSERT ON nsm_jobs TO ninjamain;
GRANT SELECT ON nsm_jobs TO ninjamain;
GRANT UPDATE ON nsm_jobs TO ninjamain;
GRANT REFERENCES ON nsm_jobs TO ninjamain;
GRANT ON COMMIT REFRESH ON nsm_jobs TO ninjamain;
GRANT QUERY REWRITE ON nsm_jobs TO ninjamain;
GRANT DEBUG ON nsm_jobs TO ninjamain;
GRANT FLASHBACK ON nsm_jobs TO ninjamain;
GRANT ALTER ON nsm_jobs TO ninjadata;
GRANT DELETE ON nsm_jobs TO ninjadata;
GRANT INDEX ON nsm_jobs TO ninjadata;
GRANT INSERT ON nsm_jobs TO ninjadata;
GRANT SELECT ON nsm_jobs TO ninjadata;
GRANT UPDATE ON nsm_jobs TO ninjadata;
GRANT REFERENCES ON nsm_jobs TO ninjadata;
GRANT SELECT ON nsm_jobs TO ninjacstaging;
GRANT SELECT ON nsm_jobs TO readonly;

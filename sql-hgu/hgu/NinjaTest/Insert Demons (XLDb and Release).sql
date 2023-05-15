INSERT INTO ninja_jobs
VALUES
('NINJA_PRO2_SH1',0,'SLEEPING','Y',5000,to_date('2008-06-12 08:55','RRRR-MM-DD HH24:MI'),to_date('2008-06-12 08:54','RRRR-MM-DD HH24:MI'),NULL,'MASTER','Master Job','N',NULL)
/



INSERT INTO ninja_jobs
VALUES
('NINJA_PRO2_SH1',1,'STOPPED','N',60000,to_date('2008-06-12 08:55','RRRR-MM-DD HH24:MI'),to_date('2008-06-12 08:54','RRRR-MM-DD HH24:MI'),NULL,'masterXLDBProcessor','XLDB Processor','N',NULL)
/
INSERT INTO ninja_jobs_parameters
VALUES
('NINJA_PRO2_SH1',1,1,'NinjaInternal','Weblogic User Parameter')
/




INSERT INTO ninja_jobs
VALUES
('NINJA_PRO2_SH1',2,'SLEEPING','Y',150000,to_date('2008-06-12 09:07','RRRR-MM-DD HH24:MI'),to_date('2008-06-12 09:05','RRRR-MM-DD HH24:MI'),NULL,'numberReleaser','Batch Release of numbers held within the Ninja dbase','N',NULL)
/
INSERT INTO ninja_jobs_parameters
VALUES
('NINJA_PRO2_SH1',2,1,'NinjaInternal','Weblogic User Parameter')
/




INSERT INTO ninja_jobs
VALUES
('NINJA_PRO2_SH1',3,'SLEEPING','Y',86400000,to_date('2008-06-13 03:45','RRRR-MM-DD HH24:MI'),to_date('2008-06-12 03:45','RRRR-MM-DD HH24:MI'),NULL,'numberReconciler','Reconcile The Ninja Reserved Numbers wqith Fokus','Y',NULL)
/
INSERT INTO ninja_jobs_parameters
VALUES
('NINJA_PRO2_SH1',3,1,'NinjaInternal','Weblogic User Parameter')
/


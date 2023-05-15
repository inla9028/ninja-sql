INSERT INTO ninja_jobs 
VALUES('NINJAP2_DEMON',84,'STOPPED','N',60000,TO_DATE('2018-08-29 11:54:58', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-08-29 11:53:58', 'YYYY-MM-DD HH24:MI:SS'),NULL,'processChangeRatingCloneSocs','Parallel processing of table BATCH_CHANGE_PRICEPLAN_W_CLONE','N',NULL)
;

INSERT INTO ninja_jobs_parameters 
VALUES('NINJAP2_DEMON',84,1,'NinjaInternal','Weblogic User Parameter');
INSERT INTO ninja_jobs_parameters 
VALUES('NINJAP2_DEMON',84,2,'1','Nr of threads to run in parallel');

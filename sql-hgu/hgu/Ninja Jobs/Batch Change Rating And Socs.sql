INSERT INTO ninja_jobs 
VALUES('NINJAST1_SH1',81,'STARTING','Y',60000,SYSDATE,SYSDATE,NULL,'processChangeRatingAndSocs','Parallel processing of table BATCH_CHANGE_PRICEPLAN','N',NULL);

INSERT INTO ninja_jobs_parameters 
VALUES('NINJAST1_SH1',81,1,'NinjaInternal','Weblogic User Parameter');

INSERT INTO ninja_jobs_parameters 
VALUES('NINJAST1_SH1',81,2,'10','Nr of threads to run in parallel');

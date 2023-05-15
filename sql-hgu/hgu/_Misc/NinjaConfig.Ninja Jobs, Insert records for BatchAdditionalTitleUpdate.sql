INSERT INTO ninja_jobs            VALUES('NINJAP2_DEMON',83,'STARTING','Y',60000,SYSDATE,SYSDATE,NULL,'batchAdditionalTitleUpdate','Batch update Additional Title only','N',NULL);
INSERT INTO ninja_jobs_parameters VALUES('NINJAP2_DEMON',83,1,'NinjaInternal','Weblogic User Parameter');

SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id = 'NINJAP2_DEMON'
   AND a.job_id     = 83
;

SELECT a.machine_id, a.job_status, count(1) AS "COUNT"
  FROM ninja_jobs a
GROUP BY a.machine_id, a.job_status
ORDER BY 1,2
;


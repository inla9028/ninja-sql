--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run all failed records =--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--     , a.stream = '1'
  WHERE a.request_id     = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')  -- IN ( 'STLI15 2012-07-10' )
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc    LIKE '%No Jolt connections available%'
      OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc    LIKE '%Please try accessing account again later%'
      OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc    LIKE '%not connected to ORACLE%'
      OR a.status_desc    LIKE '%Tuxedo server%service is down%'
      OR a.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
      OR a.status_desc    LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
      OR a.status_desc    LIKE '%java.util.ConcurrentModificationException%'
      OR a.status_desc    LIKE '%Tuxedo service did not terminate successfully%csApiBan00%'
    )
;

UPDATE ninjaconfig.ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE), a.status_desc = NULL
 WHERE a.exec_method  = 'masterManipulator'
   AND a.job_status   = 'SLEEPING'
   AND a.job_id      IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
   AND a.machine_id   = 'NINJAP2Z_DEMON'
;

COMMIT WORK
;

SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP1_DEMON','NINJAP2_DEMON')
   AND a.job_status != 'STOPPED'
   AND a.exec_method LIKE 'sp%'
ORDER BY 1,2
;

/**
 * Runs every 30 mins.
 * But due to a Chess job, let's check every 5 minutes.
 * Was: 1800000
 * New:  300000
 */
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP1_DEMON','NINJAP2_DEMON')
   AND a.exec_method = 'spActivationsByPriceplan'
;

/**
 * Runs every 60 mins.
 * But due to a Chess job, let's check every 5 minutes.
 * Was: 3600000
 * New:  300000
 */
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP1_DEMON','NINJAP2_DEMON')
   AND a.exec_method = 'monitorSPBans'
;



SELECT DECODE(
         TO_CHAR(COUNT(1))
       , '2', 'OK'
       , '1', 'Bad'
       , '0', 'Very bad'
       , 'Unknown: ' || TO_CHAR(COUNT(1))
       ) AS "STATUS"
  FROM ninja_jobs a
 WHERE a.job_id      = 0
   AND a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
   AND a.status_time > SYSDATE - ( 1 / 1440 ) -- 1440 is the nr of minutes in a day
;

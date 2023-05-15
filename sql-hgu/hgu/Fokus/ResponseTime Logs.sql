  SELECT r.server_name, r.instance_name, COUNT(1) AS "COUNT"
    FROM ninjadata_st.hgu_responsetime_logs r
GROUP BY r.server_name, r.instance_name
ORDER BY r.server_name, r.instance_name
;

-- DELETE FROM ninjadata_st.hgu_responsetime_logs r;

--== List all tuxedo-calls (for a certain server)
SELECT   TO_CHAR(r.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME"
       , r.process_name
       , ROUND(AVG(r.duration) / 1000, 2) AS "DURATION"
       , COUNT(1) AS "COUNT"
    FROM ninjadata_st.hgu_responsetime_logs r
   WHERE r.server_name = 'iplchess01'
GROUP BY TO_CHAR(r.process_time, 'YYYY-MM-DD'), r.process_name
ORDER BY 1, 2
;

--== List the average duration for all calls.
SELECT   TO_CHAR(r.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME"
       , r.process_name
       , ROUND(AVG(r.duration) / 1000, 2) AS "DURATION"
       , COUNT(1) AS "COUNT"
    FROM ninjadata_st.hgu_responsetime_logs r
--   WHERE r.server_name = 'iplchess01'
GROUP BY TO_CHAR(r.process_time, 'YYYY-MM-DD'), r.process_name
ORDER BY 1, 2
;

--== List all tuxedo-calls (for a certain server) where the average duration is above a certain value...
SELECT *
  FROM (
SELECT   TO_CHAR(r.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME"
       , r.process_name
       , ROUND(AVG(r.duration) / 1000, 2) AS "DURATION"
       , COUNT(1) AS "COUNT"
    FROM ninjadata_st.hgu_responsetime_logs r
--   WHERE r.server_name = 'iplchess01'
GROUP BY TO_CHAR(r.process_time, 'YYYY-MM-DD'), r.process_name
)
WHERE "DURATION" > 4
ORDER BY 1, 2
;

SELECT *
  FROM (
SELECT   TO_CHAR(r.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME"
       , r.process_name
       , COUNT(1) AS "COUNT"
    FROM ninjadata_st.hgu_responsetime_logs r
   WHERE r.DURATION > 3999
     AND r.process_name IN ('arGtCstBan00', 'blGetFMSum00', 'blLsSocLoan00', 'blLsUBChg00', 'csApiBan00', 'csCnclCtn00', 'csCrCtn00')
GROUP BY TO_CHAR(r.process_time, 'YYYY-MM-DD'), r.process_name
)
--WHERE "DURATION" > 4
ORDER BY 1, 2
;

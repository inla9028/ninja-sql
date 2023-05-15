-- All...............: 12.001 errors.
-- MOVE..............: 2.815
-- MOVE + NETCOM_MOVE: 1.948
SELECT COUNT(1) AS "COUNT"
  FROM ninja_time_port a
 WHERE a.status        = 'PRSD_ERROR'
   AND a.action        = 'MOVE'
   AND a.ninja_action  = 'NETCOM_MOVE'
   AND a.date_time_port BETWEEN TO_DATE('2017-01-01', 'YYYY-MM-DD') AND TO_DATE('2018-01-01', 'YYYY-MM-DD')
;

-- List errors...
SELECT a.*
  FROM ninja_time_port a
 WHERE a.status        = 'PRSD_ERROR'
   AND a.action        = 'MOVE'
   AND a.ninja_action  = 'NETCOM_MOVE'
   AND a.date_time_port BETWEEN TO_DATE('2017-01-01', 'YYYY-MM-DD') AND TO_DATE('2018-01-01', 'YYYY-MM-DD')
   AND a.description NOT LIKE '%Tuxedo%'
   AND a.description NOT LIKE '%is cancelled%'
   AND a.description NOT LIKE '%no longer assigned%'
   AND a.description NOT LIKE '%is not Open%'
;

SELECT a.*
  FROM ninja_time_port a
 WHERE a.status        = 'PRSD_ERROR'
   AND a.action        = 'MOVE'
   AND a.ninja_action  = 'NETCOM_MOVE'
   AND a.date_time_port BETWEEN TO_DATE('2017-01-01', 'YYYY-MM-DD') AND TO_DATE('2018-01-01', 'YYYY-MM-DD')
   AND (a.description LIKE '%Last port order%'
     OR a.description LIKE '%not yet confirmed%'
     OR a.description LIKE '%has requested execution date%'
     OR a.description LIKE '%NPPortOrderNotConfirmedException%'
   )
;

-- Nr per month
SELECT TO_CHAR(a.date_time_port, 'YYYY-MM') AS "MONTH", COUNT(1) AS "COUNT"
  FROM ninja_time_port a
 WHERE a.status        = 'PRSD_ERROR'
   AND a.action        = 'MOVE'
   AND a.ninja_action  = 'NETCOM_MOVE'
   AND a.date_time_port BETWEEN TO_DATE('2017-01-01', 'YYYY-MM-DD') AND TO_DATE('2018-01-01', 'YYYY-MM-DD')
   AND (a.description LIKE '%Last port order%'
     OR a.description LIKE '%not yet confirmed%'
     OR a.description LIKE '%has requested execution date%'
     OR a.description LIKE '%NPPortOrderNotConfirmedException%'
   )
GROUP BY TO_CHAR(a.date_time_port, 'YYYY-MM')
ORDER BY 1
;

-- Failures per operator
SELECT a.donor_code, o.operator_desc, COUNT(1) AS "COUNT"
  FROM ninja_time_port a, np_operator_codes@fokus o
 WHERE a.status        = 'PRSD_ERROR'
   AND a.action        = 'MOVE'
   AND a.ninja_action  = 'NETCOM_MOVE'
   AND a.date_time_port BETWEEN TO_DATE('2017-01-01', 'YYYY-MM-DD') AND TO_DATE('2018-01-01', 'YYYY-MM-DD')
   AND (a.description LIKE '%Last port order%'
     OR a.description LIKE '%not yet confirmed%'
     OR a.description LIKE '%has requested execution date%'
     OR a.description LIKE '%NPPortOrderNotConfirmedException%'
   )
   AND a.donor_code    = RTRIM(o.np_operator_cd(+))
   AND TO_DATE('2017-12-31', 'YYYY-MM-DD') BETWEEN o.effective_date AND NVL(o.expiration_date, SYSDATE + 1)
GROUP BY a.donor_code, o.operator_desc
ORDER BY 1
;

-- Nr per time of day (hour)
SELECT TO_CHAR(a.date_time_port, 'HH24') || ':00-' || TO_CHAR(a.date_time_port, 'HH24') || ':59' AS "TIME_OF_DAY", COUNT(1) AS "COUNT"
  FROM ninja_time_port a
 WHERE a.status        = 'PRSD_ERROR'
   AND a.action        = 'MOVE'
   AND a.ninja_action  = 'NETCOM_MOVE'
   AND a.date_time_port BETWEEN TO_DATE('2017-01-01', 'YYYY-MM-DD') AND TO_DATE('2018-01-01', 'YYYY-MM-DD')
   AND (a.description LIKE '%Last port order%'
     OR a.description LIKE '%not yet confirmed%'
     OR a.description LIKE '%has requested execution date%'
     OR a.description LIKE '%NPPortOrderNotConfirmedException%'
   )
GROUP BY TO_CHAR(a.date_time_port, 'HH24') || ':00-' || TO_CHAR(a.date_time_port, 'HH24') || ':59'
ORDER BY 1
;


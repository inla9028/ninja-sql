/*
** Display the number of status-changes for the last XXX days.
*/
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD') AS "ENTER_TIME", a.action_code AS "ACTION", 
       a.request_reference_id AS "REQ_REF_ID", COUNT(1) AS "COUNT"
  FROM ninja_sub_change_status a
 WHERE 1 = 1
   AND a.enter_time > TRUNC(SYSDATE, 'MON')
--   AND a.enter_time BETWEEN TO_DATE('2012-10-30 00:01', 'YYYY-MM-DD HH24:MI')
--                        AND TO_DATE('2012-10-31 12:34', 'YYYY-MM-DD HH24:MI')
GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD'), a.action_code, a.request_reference_id
ORDER BY TO_CHAR(a.enter_time, 'YYYY-MM-DD'), a.action_code, a.request_reference_id
;

--==
SELECT last_month
  FROM
(
    SELECT TRUNC(SYSDATE, 'MON') - 1 + LEVEL AS "LAST_MONTH"
      FROM dual
     WHERE (TRUNC(SYSDATE, 'MON') - 1 + LEVEL) <= TRUNC(SYSDATE)
    CONNECT BY LEVEL <= 31
)
-- ORDER BY last_month
;

--==
SELECT daterange
  FROM
(
    SELECT TO_DATE('10 2007','MM YYYY') - 1 + LEVEL AS "DATERANGE"
      FROM dual
     WHERE (TO_DATE('10 2007','MM YYYY') - 1 + LEVEL) <= LAST_DAY(TO_DATE('10 2007','MM YYYY'))
    CONNECT BY LEVEL <= 31
)
ORDER BY daterange;

--==
select to_date('&date','MM YYYY')-1 + level as DateRange
    2 from    dual
    3 where   (to_date('&date','MM YYYY')-1+level) <= last_day(to_date('&Date','MM YYYY'))
    4 connect by level<=31
    5 ;

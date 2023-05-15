--==
--== Display the number of inserted and processed records for every hour for the last xxx days.
--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
       COUNT(*) AS "COUNT"
  FROM service_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time      > TRUNC(SYSDATE - 21)
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "ENTER_TIME";


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
SELECT last_21_days
  FROM
(
    SELECT TRUNC(SYSDATE - 21) - 1 + LEVEL AS "LAST_21_DAYS"
      FROM dual
     WHERE (TRUNC(SYSDATE - 21) - 1 + LEVEL) <= TRUNC(SYSDATE)
    CONNECT BY LEVEL <= 31
)
ORDER BY last_21_days;

--==
select to_date('&date','MM YYYY')-1 + level as DateRange
    2 from    dual
    3 where   (to_date('&date','MM YYYY')-1+level) <= last_day(to_date('&Date','MM YYYY'))
    4 connect by level<=31
    5 ;
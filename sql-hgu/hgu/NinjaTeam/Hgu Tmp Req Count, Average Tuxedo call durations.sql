DESC hgu_tmp_req_count
;

SELECT A.*
  FROM hgu_tmp_req_count A
order by A.req_count desc
;

SELECT A.req_name AS "TUX_SERVICE", count(1) AS "CALL_COUNT"
  FROM hgu_tmp_req_count A
GROUP BY A.req_name
ORDER BY 1
;

/*
DELETE
  FROM hgu_tmp_req_count
;
*/

SELECT A.*
  FROM hgu_tmp_req_count A
 WHERE A.req_count = (SELECT MAX(b.req_count) FROM hgu_tmp_req_count b)
;

SELECT A.*
  FROM hgu_tmp_req_count A
 WHERE A.req_count > (SELECT MAX(b.req_count) - 8000 FROM hgu_tmp_req_count b)
;


-- csActvCtn00
SELECT A.*
  FROM hgu_tmp_req_count A
 WHERE A.req_name = 'csActvCtn00'
;



SELECT b.tux_service, b.req_hour, b.req_duration
  FROM (SELECT A.req_name AS "TUX_SERVICE", to_char(A.req_date, 'HH24') ||':XX' "REQ_HOUR"
             , A.req_count AS "REQ_DURATION"
          FROM hgu_tmp_req_count A
         WHERE A.req_name = 'csActvCtn00') b
 WHERE b.req_hour LIKE '07%'
;

SELECT b.tux_service, b.req_hour, b.req_duration, COUNT(1) AS "REQ_COUNT", AVG(b.req_duration) AS "AVG_DURATION"
  FROM (SELECT A.req_name AS "TUX_SERVICE", to_char(A.req_date, 'HH24') ||':XX' "REQ_HOUR"
             , A.req_count AS "REQ_DURATION"
          FROM hgu_tmp_req_count A
         WHERE A.req_name = 'csActvCtn00') b
 WHERE b.req_hour LIKE '07%'
GROUP BY b.tux_service, b.req_hour, b.req_duration
ORDER BY 1,2
;


SELECT b.tux_service, b.req_hour, b.req_duration, COUNT(1) AS "REQ_COUNT", SUM(b.req_duration) AS "SUM_DURATION"
  FROM (SELECT A.req_name AS "TUX_SERVICE", to_char(A.req_date, 'HH24') ||':XX' "REQ_HOUR"
             , A.req_count AS "REQ_DURATION"
          FROM hgu_tmp_req_count A
         WHERE A.req_name = 'csActvCtn00') b
 WHERE b.req_hour LIKE '07%'
GROUP BY b.tux_service, b.req_hour, b.req_duration
ORDER BY 1,2
;


WITH tux_count AS
(
  SELECT A.req_name AS "TUX_SERVICE", to_char(A.req_date, 'HH24') "REQ_HOUR"
       , count(1) AS "REQ_COUNT"
    FROM hgu_tmp_req_count A
   WHERE A.req_name IN ( 'csActvCtn00', 'csApiBan00', 'csCrCtn00', 'csMoveCtn00' )
  GROUP BY A.req_name, to_char(A.req_date, 'HH24')
),
tux_sum AS
(
  SELECT A.req_name AS "TUX_SERVICE", to_char(A.req_date, 'HH24') "REQ_HOUR"
       , sum(A.req_count) AS "REQ_DURATIONS"
    FROM hgu_tmp_req_count A, tux_count b
   WHERE A.req_name                  = b.tux_service
     AND to_char(A.req_date, 'HH24') = b.req_hour
  GROUP BY A.req_name, to_char(A.req_date, 'HH24')
)
SELECT c.tux_service, c.req_hour ||':XX' "REQ_HOUR", c.req_count -- , s.req_durations
     , TO_NUMBER(TO_CHAR(s.req_durations / c.req_count, 'FM99999999')) AS "AVG_DURATION"
  FROM tux_count c, tux_sum s
 WHERE c.tux_service = s.tux_service
   AND c.req_hour    = s.req_hour
ORDER BY 1, 2
;

-- Get every service for a certain period of time.
WITH tux_count AS
(
  SELECT A.req_name AS "TUX_SERVICE", to_char(A.req_date, 'HH24') "REQ_HOUR"
       , count(1) AS "REQ_COUNT"
    FROM hgu_tmp_req_count A
   WHERE to_char(A.req_date, 'HH24') IN ( '11', '12' )
  GROUP BY A.req_name, to_char(A.req_date, 'HH24')
),
tux_sum AS
(
  SELECT A.req_name AS "TUX_SERVICE", to_char(A.req_date, 'HH24') "REQ_HOUR"
       , sum(A.req_count) AS "REQ_DURATIONS"
    FROM hgu_tmp_req_count A, tux_count b
   WHERE A.req_name                  = b.tux_service
     AND to_char(A.req_date, 'HH24') = b.req_hour
  GROUP BY A.req_name, to_char(A.req_date, 'HH24')
)
SELECT c.tux_service, c.req_hour ||':XX' "REQ_HOUR", c.req_count -- , s.req_durations
     , TO_NUMBER(TO_CHAR(s.req_durations / c.req_count, 'FM99999999')) AS "AVG_DURATION"
  FROM tux_count c, tux_sum s
 WHERE c.tux_service = s.tux_service
   AND c.req_hour    = s.req_hour
ORDER BY 2, 1
;
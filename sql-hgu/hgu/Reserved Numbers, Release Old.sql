--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records that should have been released...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ctn, a.dealer_code, a.reserved_date, a.no_of_days_reserved,
       SYSDATE AS "TODAYS_DATE",
       a.reserved_date + a.no_of_days_reserved AS "RELEASE_DATE"
  FROM reserved_numbers a
 WHERE (a.reserved_date + a.no_of_days_reserved) < TRUNC(SYSDATE)
ORDER BY a.reserved_date
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records where the number is reserved, but a subscription
--== with that very number already exists...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ctn, a.dealer_code, a.reserved_date, a.no_of_days_reserved,
       SYSDATE AS "TODAYS_DATE",
       a.reserved_date + a.no_of_days_reserved AS "RELEASE_DATE",
       b.sub_status, b.effective_date AS "SUB_EFF_DATE", c.ctn_status
  FROM reserved_numbers a, subscriber@fokus b, tn_inv@fokus c
 WHERE (a.reserved_date + a.no_of_days_reserved) < TRUNC(SYSDATE)
   AND 'GSM' || a.ctn = b.subscriber_no
   and a.ctn = c.ctn
ORDER BY a.ctn, a.reserved_date
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records for a specific number(s)...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ctn, a.dealer_code, a.reserved_date, a.no_of_days_reserved,
       SYSDATE AS "TODAYS_DATE",
       a.reserved_date + a.no_of_days_reserved AS "RELEASE_DATE"
  FROM reserved_numbers a
 WHERE a.ctn IN ('047'||'98118522')
ORDER BY a.ctn
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of reservations per day.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.reserved_date, 'YYYY-MM-DD') AS "RESERVED_DATE", COUNT(*) AS "COUNT"
  FROM reserved_numbers a
GROUP BY TO_CHAR(a.reserved_date, 'YYYY-MM-DD')
ORDER BY TO_CHAR(a.reserved_date, 'YYYY-MM-DD')
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of reservations per day/dealer.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.reserved_date, 'YYYY-MM-DD') AS "RESERVED_DATE", a.dealer_code, COUNT(*) AS "COUNT"
  FROM reserved_numbers a
GROUP BY TO_CHAR(a.reserved_date, 'YYYY-MM-DD'), a.dealer_code
ORDER BY TO_CHAR(a.reserved_date, 'YYYY-MM-DD'), a.dealer_code
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Delete the records where the number is reserved, but a subscription
--== with that very number already exists...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM reserved_numbers a
      WHERE (a.reserved_date + a.no_of_days_reserved) < TRUNC(SYSDATE)
--        AND 0 < (
--            SELECT COUNT(1) FROM service_agreement@fokus b
--             WHERE 'GSM' || a.ctn = b.subscriber_no
--               AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
--               AND b.service_type = 'P'
--        )
;

COMMIT WORK
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Delete the records that should have been released...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM reserved_numbers a
      WHERE (a.reserved_date + a.no_of_days_reserved) < TRUNC(SYSDATE)
;

COMMIT WORK
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Delete reserved numbers according to a certain criteria..
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM reserved_numbers a
      WHERE a.reserved_date BETWEEN TRUNC(SYSDATE) AND SYSDATE
        AND a.dealer_code = 'NETV'
;

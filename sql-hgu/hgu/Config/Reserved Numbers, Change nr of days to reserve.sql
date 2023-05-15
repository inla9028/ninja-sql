/*
** Configuration.
*/
SELECT a.key, a.value, a.value_type, a.description
  FROM system_defaults a
 WHERE a.key = 'RESERVATION_DAYS'
;

UPDATE system_defaults a
   SET a.value = '50', a.description = 'Default nr of days to reserve a CTN (HGU: Changed from ' || a.value || ' to 50 at ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI')
 WHERE a.key   = 'RESERVATION_DAYS'
;

SELECT a.key, a.value, a.value_type, a.description
  FROM system_defaults a
 WHERE a.key = 'RESERVATION_DAYS'
;

/*
** Reserved numbers.
*/
SELECT a.no_of_days_reserved, COUNT(1) AS "COUNT"
  FROM reserved_numbers a
GROUP BY a.no_of_days_reserved
ORDER BY 1
;

UPDATE reserved_numbers a
   SET a.no_of_days_reserved = 50
 WHERE a.no_of_days_reserved = 31
;

SELECT a.no_of_days_reserved, COUNT(1) AS "COUNT"
  FROM reserved_numbers a
GROUP BY a.no_of_days_reserved
ORDER BY 1
;


SELECT a.*
  FROM number_porting_logic a
 WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

SELECT a.effective_date, a.expiration_date, COUNT(1) AS "COUNT"
  FROM number_porting_logic a
GROUP BY a.effective_date, a.expiration_date
ORDER BY a.effective_date, a.expiration_date
;

/*
UPDATE number_porting_logic a
   SET a.expiration_date = TRUNC(SYSDATE)
 WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
;
*/
INSERT INTO number_porting_logic
VALUES('S','X','N',NULL,'Y','PFE','isCleanPortIn()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

SELECT a.*
  FROM number_porting_logic a
 WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

SELECT a.effective_date, a.expiration_date, COUNT(1) AS "COUNT"
  FROM number_porting_logic a
GROUP BY a.effective_date, a.expiration_date
ORDER BY a.effective_date, a.expiration_date
;




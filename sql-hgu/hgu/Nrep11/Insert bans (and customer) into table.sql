DELETE
  FROM tmp_bans_w_customer
;

--CREATE table tmp_bans_w_customer
--AS
INSERT INTO tmp_bans_w_customer
SELECT /*+ parallel(b , 6 )*/
       /*+ parallel(c , 6 )*/
       b.ban, b.account_type, b.account_sub_type, c.customer_telno
  FROM billing_account b, customer c
 WHERE b.ban_status             IN ( 'O' )
   AND b.account_type       NOT IN ( 'S' )
   AND b.ban                     = c.customer_id
--   AND ROWNUM < 11
;

COMMIT WORK;

SELECT b.account_type, b.account_sub_type, COUNT(1) AS "COUNT"
  FROM tmp_bans_w_customer b
GROUP BY b.account_type, b.account_sub_type
ORDER BY b.account_type, b.account_sub_type
;


SELECT A.account_type, A.customer_telno, count(1) AS "COUNT"
  FROM (SELECT b.account_type, decode(b.customer_telno, '0', 'No', 'Yes') AS "CUSTOMER_TELNO"
          FROM tmp_bans_w_customer b) a
GROUP BY A.account_type, A.customer_telno
ORDER BY A.account_type, A.customer_telno
;

--DELETE
--  FROM tmp_bans_w_account_type_status
--;

CREATE table tmp_bans_w_account_type_status
AS
--INSERT INTO tmp_bans_w_account_type_status
SELECT /*+ parallel(b , 6 )*/
       b.ban, b.account_type, b.account_sub_type, b.ban_status
  FROM billing_account b
-- WHERE b.ban_status             IN ( 'O' )
--   AND b.account_type            = 'I'
--   AND RTRIM(b.account_sub_type) = 'R'
--   AND ROWNUM < 11
;

COMMIT WORK;

--SELECT b.account_type, b.account_sub_type, b.ban_status, COUNT(1) AS "COUNT"
--  FROM tmp_bans_w_account_type_status b
--GROUP BY b.account_type, b.account_sub_type, b.ban_status
--ORDER BY b.account_type, b.account_sub_type, b.ban_status
--;

SELECT b.account_type, b.ban_status, COUNT(1) AS "COUNT"
  FROM tmp_bans_w_account_type_status b
GROUP BY b.account_type, b.ban_status
ORDER BY b.account_type, b.ban_status
;

SELECT b.ban_status, COUNT(1) AS "COUNT"
  FROM tmp_bans_w_account_type_status b
GROUP BY b.ban_status
ORDER BY b.ban_status
;
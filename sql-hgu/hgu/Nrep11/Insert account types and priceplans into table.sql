DELETE
  FROM tmp_ban_types_priceplans
;

CREATE TABLE tmp_ban_types_priceplans
AS
--INSERT INTO tmp_ban_types_priceplans
SELECT ba.account_type
     , ba.account_sub_type
     , RTRIM(sa.soc) AS "PRICE_PLAN"
     , s.sub_status
  FROM billing_account ba, subscriber s, service_agreement sa
 WHERE s.sub_status    IN ( 'A', 'R', 'S')
   AND s.customer_id    = ba.ban
   AND ba.ban_status    = 'O'
--   AND ba.account_type  NOT IN ( 'S', 'H' ) -- S = SP, H = Chess (being phased out and having 15k of invalid birth-dates.
   AND s.subscriber_no  = sa.subscriber_no
   AND SYSDATE    BETWEEN sa.effective_date AND NVL(sa.expiration_date, SYSDATE + 1)
   AND sa.service_type  = 'P'
--   AND ROWNUM < 11
;

COMMIT WORK
;

SELECT COUNT(1) AS "COUNT"
  FROM tmp_ban_types_priceplans
;

SELECT a.account_type, a.account_sub_type, a.price_plan, COUNT(1) AS "COUNT"
  FROM tmp_ban_types_priceplans a
 WHERE a.account_type = 'S'
GROUP BY a.account_type, a.account_sub_type, a.price_plan
ORDER BY a.account_type, a.account_sub_type, a.price_plan
;

/*

-- From Ninja DB...

SELECT a.account_type, a.account_sub_type, t.description, a.price_plan, COUNT(1) AS "COUNT"
  FROM tmp_ban_types_priceplans@nrep11 a, account_type@fokus t
 WHERE a.account_type     = 'S'
   AND a.account_type     = t.acc_type
   AND a.account_sub_type = t.acc_sub_type
GROUP BY a.account_type, a.account_sub_type, t.description, a.price_plan
ORDER BY a.account_type, a.account_sub_type, t.description, a.price_plan
;

*/

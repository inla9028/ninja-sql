-- F_LO_0
-- Total # LOs for Non-Closed BANs (Cancelled, Open, Suspended)
SELECT b.ban_status, COUNT(1) AS "COUNT"
  FROM tmp_bans_w_account_type_status b
GROUP BY b.ban_status
ORDER BY b.ban_status
;

-- F_LO_1
-- # LOs with F Name, L Name, DoB, PID, for Non-Closed BANs (Split pre-paid / post Paid)
-- + Sub-count: how many of these also have a contact phone or an e-mail address
SELECT /*+ parallel(a , 6 )*/
       /*+ parallel(b , 6 )*/
       COUNT(1) AS "COUNT"
  FROM tmp_addresses_street_email A
 WHERE A.link_type = 'L'
   AND A.first_name IS NOT NULL
   AND A.last_business_name IS NOT NULL
   and A.
   AND ROWNUM < 11
;

SELECT b.*
  FROM tmp_bans_w_account_type_status b
 WHERE ROWNUM < 11
;

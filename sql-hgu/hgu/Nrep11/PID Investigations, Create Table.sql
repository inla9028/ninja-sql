CREATE TABLE tmp_pid_investigations as
(
SELECT /*+ hash(ba,anl) */
       ba.ban,
       anl.name_id,
       anl.address_id,
       anl.link_type,
       anl.subscriber_no,
       nd.comp_reg_id, -- Use this as well, since it might host the TN_ID we want to replace
       nd.first_name,
       nd.last_business_name,
       nd.birth_date,
       ad.adr_zip
  FROM billing_account   ba,
       address_name_link anl,
       name_data         nd,
       address_data      ad
 WHERE ba.ban_status    = 'O'
   AND ba.account_type       NOT IN ( 'S', 'H' ) -- S = SP, H = Chess (being phased out and having 15k of invalid birth-dates.
   AND ba.ban                 = anl.ban
   AND SYSDATE          BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
   AND anl.link_type         IN ( 'B', 'L', 'U' )
   AND anl.name_id            = nd.name_id
   AND nd.birth_date         IS NOT NULL      -- Birth-Date is required towards DSF
   AND nd.first_name         != 'BRUKER'      -- Prepaid...
   AND nd.last_business_name != 'KONTANT'     -- Prepaid...
   AND anl.address_id         = ad.address_id
   AND LENGTH(TRIM(nd.comp_reg_id)) = 11
   AND nd.comp_reg_id NOT LIKE TO_CHAR(nd.birth_date, 'DDMMYY') || '%'
)
;

COMMIT WORK
;

SELECT a.ban, a.name_id, a.address_id, a.link_type, a.subscriber_no,
       a.comp_reg_id, a.first_name, a.last_business_name, a.birth_date,
       a.adr_zip
  FROM tmp_pid_investigations a
ORDER BY a.ban, a.subscriber_no
;

SELECT count(1) AS "COUNT"
  FROM tmp_pid_investigations
;

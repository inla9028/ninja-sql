/*
** Hent ut alle (aktive) tjenester for et abo, og hvilket BAN det er på.
*/
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, a.act_reason_code,
       a.operator_id, u.user_full_name
  FROM service_agreement a, users u
 WHERE a.subscriber_no = 'GSM047' || '46623068'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--   AND TO_DATE('2011-10-13', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
   AND a.operator_id = u.user_id(+)
ORDER BY a.subscriber_no, a.ban, a.soc
;

/*
** Hent ut for et telefon-nummer og BAN.
*/
SELECT a.ban, a.subscriber_no, a.link_type, a.birth_date,
       b.first_name, b.last_business_name,
       c.adr_primary_ln, c.adr_secondary_ln, c.adr_email, a.sys_creation_date
  FROM address_name_link a, name_data b, address_data c
 WHERE 1 = 1
   AND a.ban           = 292004603 
   AND a.subscriber_no = 'GSM047' || '46623068'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.name_id       = b.name_id
   AND a.address_id    = c.address_id
ORDER BY a.ban, a.subscriber_no, a.link_type
;

/*
** Hent ut generelle bruker-data, f.eks. kolonnen SUB_STATUS.
*/
SELECT a.*
  FROM subscriber a
 WHERE 1 = 1
   AND a.customer_id   = 292004603 -- Aka BAN 
   AND a.subscriber_no = 'GSM047' || '46623068'
;

/*
** Hent ut data om avtalen for et BAN, f.eks. CUSTOMER_TELNO (TF Admin!)
*/
SELECT a.*
  FROM customer a
 WHERE 1 = 1
   AND a.customer_id   = 292004603 -- Aka BAN 
;

/*
** Hent ut generelle data om et BAN, f.eks. BAN_STATUS, ACCOUNT_TYPE, ACCOUNT_SUB_STYPE, etc.
*/
SELECT a.*
  FROM billing_account a
 WHERE 1 = 1
   AND a.ban = 292004603 -- Aka CUSTOMER_ID 
;
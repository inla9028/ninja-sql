SELECT /*+DRIVING_SITE(s)*/ s.subscriber_no, TO_CHAR(s.sub_status_date, 'YYYY-MM-DD') AS "SUB_STATUS_DATE"
     , RTRIM(sa.soc) AS "PRICE_PLAN"
     , sii.serial_number, sii.act_issue_date
     -- , sii.puk, sii.puk2, sii.initial_pin, sii.initial_pin2
     , sii.imsi
     --, sii.hlr_cd
  FROM subscriber s, service_agreement sa, physical_device pd, serial_item_inv sii
 WHERE sa.soc          LIKE 'PW20%'
   AND SYSDATE      BETWEEN sa.effective_date And nvl(sa.expiration_date, SYSDATE + 1)
   AND sa.subscriber_no   = s.subscriber_no
   AND sa.ban             = s.customer_id
   AND s.sub_status       = 'A'
   AND s.customer_id      = pd.ban
   AND s.subscriber_no    = pd.subscriber_no
   AND pd.expiration_date IS NULL
   AND pd.equipment_no    = sii.serial_number
   AND pd.imsi            = sii.imsi
ORDER BY 1
;
/*
** Via db-link...
*/
SELECT /*+DRIVING_SITE(s)*/ s.subscriber_no, TO_CHAR(s.sub_status_date, 'YYYY-MM-DD') AS "SUB_STATUS_DATE"
     , RTRIM(sa.soc) AS "PRICE_PLAN"
     , sii.serial_number, sii.act_issue_date
     -- , sii.puk, sii.puk2, sii.initial_pin, sii.initial_pin2
     , sii.imsi
     --, sii.hlr_cd
  FROM subscriber@fokus s, service_agreement@fokus sa, physical_device@fokus pd, serial_item_inv@fokus sii
 WHERE RTRIM(sa.soc)     IN ( 'PW20' )
   AND SYSDATE      BETWEEN sa.effective_date And nvl(sa.expiration_date, SYSDATE + 1)
   AND sa.subscriber_no   = s.subscriber_no
   AND sa.ban             = s.customer_id
   AND s.sub_status       = 'A'
   AND s.customer_id      = pd.ban
   AND s.subscriber_no    = pd.subscriber_no
   AND pd.expiration_date IS NULL
   AND pd.equipment_no    = sii.serial_number
   AND pd.imsi            = sii.imsi
ORDER BY 3, 1
;
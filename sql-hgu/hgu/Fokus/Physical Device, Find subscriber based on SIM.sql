-- A very simple SQL to get MSISDN out of an IMSI is:
SELECT /*+ driving_site(pd)*/
       pd.ban, pd.subscriber_no, pd.imsi, pd.equipment_no, pd.equipment_level,
       pd.effective_date, pd.expiration_date
  FROM physical_device@fokus pd
 WHERE 1 = 1
   AND pd.equipment_no = '08947080037113988272'
--   AND pd.imsi IN ('242029010284236')
   --AND pd.imsi like ( '%8001311')
   --AND pd.customer_id = 131469504
   --AND pd.subscriber_no in ('GSM04798807676')
   AND (pd.expiration_date IS NULL OR pd.expiration_date > SYSDATE - 1)
   --AND pd.imsi in ()
   AND ROWNUM < 20
;

/*
** Based on SIM, identify the MSISDN it's attached to - if any.
*/
SELECT pd.*
  FROM physical_device pd
 WHERE 1 = 1
   AND pd.imsi IN ('242029004825376')
   --AND pd.imsi like ( '%8001311')
   --AND pd.customer_id = 131469504
   --AND pd.subscriber_no in ('GSM04798807676')
   AND (pd.expiration_date IS NULL OR pd.expiration_date > SYSDATE - 1)
   --AND pd.imsi in ()
   AND ROWNUM < 20
;

/*
** Reversed, based on MSISDN, display the SIM.
*/
SELECT s.subscriber_no, sii.serial_number, sii.act_issue_date
     , sii.puk, sii.puk2, sii.initial_pin, sii.initial_pin2, sii.imsi
  FROM subscriber s, physical_device pd, serial_item_inv sii
 WHERE s.subscriber_no = 'GSM047' || '41216391'
   AND s.sub_status    = 'A'
   AND s.customer_id   = pd.ban
   AND s.subscriber_no = pd.subscriber_no
   AND pd.expiration_date IS NULL
   AND pd.equipment_no = sii.serial_number
   AND pd.imsi         = sii.imsi
;
   




 

/*
** List equipment associated with a subscriber.
*/
SELECT s.customer_id AS "BAN", s.subscriber_no, p.equipment_no,
       DECODE(p.device_type, 'H', 'H (Handset)', 'E', 'E (SIM Card)') AS "DEVICE_TYPE", p.imsi
  FROM subscriber s, physical_device p
 WHERE s.subscriber_no = 'GSM047' || '92653600'
   AND s.sub_status    = 'A'
   AND s.customer_id   = p.customer_id
   AND s.subscriber_no = p.subscriber_no
   AND SYSDATE BETWEEN p.effective_date AND NVL(p.expiration_date, SYSDATE + 1)
;

/*
SELECT a.subscriber_no, a.soc, a.action, a.feature, a.parameter,
       a.parm_value, a.request_id, a.memo_text, a.feature2,
       a.parameter2, a.parm_value2, a.feature3, a.parameter3,
       a.parm_value3, a.feature4, a.parameter4, a.parm_value4,
       a.dealer_code, a.sales_agent
  FROM ninjateam.mw_tmp_trans a
*/


/*
** List subscribers with a given set of SIM numbers...
** 580001108101-580001109
*/
SELECT s.*
     , p.*
  FROM subscriber s, physical_device p
 WHERE s.subscriber_no BETWEEN 'GSM047' || '580001108101' AND 'GSM047' || '580001109000'
   AND s.sub_status    = 'A'
   AND s.customer_id   = p.customer_id
   AND s.subscriber_no = p.subscriber_no
   AND p.device_type   = 'E'
AND ROWNUM < 11
;

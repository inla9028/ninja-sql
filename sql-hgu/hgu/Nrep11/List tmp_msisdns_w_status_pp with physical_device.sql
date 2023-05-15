SELECT a.subscriber_no, a.ban, a.sub_status, a.price_plan,
       a.effective_date, p.equipment_no, p.imsi
  FROM tmp_msisdns_w_status_pp a, physical_device p
 WHERE a.ban           = p.customer_id
   AND a.subscriber_no = p.subscriber_no
   AND SYSDATE   BETWEEN p.effective_date AND NVL(p.expiration_date, SYSDATE + 1)
   AND p.device_type   = 'E'
;


SELECT * FROM (
SELECT c.customer_telno, s.soc
  FROM ntcappo.customer c, ntcappo.billing_account b, ntcappo.service_agreement s
  WHERE b.account_type      = 'I'
    AND b.account_sub_type  = 'FB'
    AND c.customer_id       = b.ban
    AND c.customer_telno IS NOT NULL
    AND s.subscriber_no     = 'GSM' || c.customer_telno
    AND s.service_type      = 'P' -- 'P'riceplan Soc, 'R'egular Soc
    AND s.soc              IN ('PPTC')
    AND s.subscriber_no    != '0000000000'
    AND ROWNUM  < 100
  ORDER BY dbms_random.value()
) WHERE ROWNUM  < 2

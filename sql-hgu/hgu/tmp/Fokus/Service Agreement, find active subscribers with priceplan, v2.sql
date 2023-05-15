SELECT a.ban, a.subscriber_no, a.soc, a.effective_date
  FROM service_agreement a
  WHERE a.expiration_date > SYSDATE
    AND a.service_type    = 'P' -- 'P'riceplan Soc, 'R'egular Soc
    AND a.soc            IN ('PSFB')
    AND a.subscriber_no  != '0000000000'
    AND ROWNUM           <= 10
  ORDER BY dbms_random.value()


    

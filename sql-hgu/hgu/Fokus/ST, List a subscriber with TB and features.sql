SELECT a.ban, a.subscriber_no, a.soc, a.effective_date, a.expiration_date
  FROM service_agreement a
--  WHERE a.expiration_date BETWEEN SYSDATE - 30 AND SYSDATE
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.service_type    = 'R' -- 'P'riceplan Soc, 'R'egular Soc
    AND RTRIM(a.soc)     IN ('MCTBFREE')
    AND a.subscriber_no  != '0000000000'
    AND ROWNUM           <= 20
  ORDER BY dbms_random.value();
  
select a.* 
  from service_feature a
 where a.ban = 101997609
   and a.subscriber_no = 'GSM04746472027'
   and sysdate between a.ftr_effective_date and NVL(a.ftr_expiration_date, sysdate + 1)
   and RTRIM(a.soc) like 'MCTB%'
order by a.ban, a.subscriber_no, a.soc
;


SELECT * FROM pnp WHERE pni_type = 'V';
   
select a.ban, a.subscriber_no, a.soc, a.feature_code, a.ftr_add_sw_prm
  from service_feature a
 where a.ban = 101997609
   and a.subscriber_no = 'GSM04746472027'
   and sysdate between a.ftr_effective_date and NVL(a.ftr_expiration_date, sysdate + 1)
   and RTRIM(a.soc) like 'MCTB%'
order by a.ban, a.subscriber_no, a.soc
;
   

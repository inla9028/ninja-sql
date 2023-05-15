delete
  from tmp_msisdns_w_duplicate_socs
;

INSERT INTO tmp_msisdns_w_duplicate_socs
SELECT s.subscriber_no
     , s.customer_id AS "BAN"
     , RTRIM(a1.soc) AS "SOC1"
     , a1.soc_seq_no AS "SOC_SEC_NO1"
     , a1.effective_date AS "EFFECTIVE_DATE1"
     , a1.expiration_date AS "EXPIRATION_DATE1"
     , RTRIM(a2.soc) AS "SOC2"
     , a2.soc_seq_no AS "SOC_SEC_NO1"
     , a2.effective_date AS "EFFECTIVE_DATE2"
     , a2.expiration_date AS "EXPIRATION_DATE2"
  FROM subscriber s, service_agreement a1, service_agreement a2 
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)    = RTRIM(a2.soc)
   AND a1.soc_seq_no    < a2.soc_seq_no
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
--   AND ROWNUM < 11
;

commit work;

select a.soc1, count(1) as "COUNT"
  from tmp_msisdns_w_duplicate_socs a
group by a.soc1
order by 1
;
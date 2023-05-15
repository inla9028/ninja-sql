delete
  from tmp_msisdns_w_status_soc_fp
;

--CREATE TABLE tmp_msisdns_w_status_soc_fp
--AS
INSERT INTO tmp_msisdns_w_status_soc_fp
SELECT s.subscriber_no
     , s.customer_id          AS "BAN"
     , s.sub_status
     , RTRIM(a.soc)           AS "SOC"
     , a.soc_seq_no
     , a.effective_date
     , a.expiration_date
     , RTRIM(f.feature_code)  AS "FEATURE_CODE"
     , f.ftr_effective_date
     , f.ftr_expiration_date
  FROM subscriber s, service_agreement a, service_feature f
 WHERE s.sub_status    IN ( 'A', 'R', 'S')
   AND s.customer_id    = a.ban
   AND s.subscriber_no  = a.subscriber_no
   AND SYSDATE    BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.ban            = f.ban
   AND a.subscriber_no  = f.subscriber_no
   and a.soc_seq_no     = f.soc_seq_no
   AND SYSDATE    BETWEEN f.ftr_effective_date AND nvl(f.ftr_expiration_date, SYSDATE + 1)
   and RTRIM(f.feature_code) IN ( 'SOCPFE' )
--   and rownum < 11
;

COMMIT WORK
;

select a.*
  from tmp_msisdns_w_status_soc_fp a
order by 1,2,4
;

select a.soc, count(1) as "COUNT"
  from tmp_msisdns_w_status_soc_fp a
group by a.soc
order by 1
;

select a.subscriber_no, count(1) as "COUNT"
  from tmp_msisdns_w_status_soc_fp a
group by a.subscriber_no
order by 1
;
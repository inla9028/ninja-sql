--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all subscriptions with a specific soc, added via custom package
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   *
    From Service_Agreement A
   WHERE rtrim(a.soc)      = 'PPUB'
     AND a.expiration_date > SYSDATE
ORDER BY a.effective_date, a.subscriber_no, a.soc;

SELECT a.* FROM service_agreement a WHERE a.ban = 573774007;

SELECT a.* FROM service_agreement a WHERE a.ban = 494318306 and a.service_type = 'P' order by a.effective_date;

SELECT a.* FROM service_agreement a WHERE a.subscriber_no = 'GSM04792601323' and a.effective_date >= trunc(sysdate) order by a.soc;

SELECT a.* FROM service_feature a WHERE a.subscriber_no = 'GSM04798288921' and a.soc like 'MCTB%' and SYSDATE BETWEEN a.ftr_effective_date AND a.ftr_expiration_date order by a.soc;

SELECT a.ban, a.subscriber_no, a.soc, a.feature_code, a.ftr_add_sw_prm, a.ftr_effective_date, a.ftr_expiration_date
  FROM service_feature a
 WHERE a.subscriber_no = 'GSM04798288921'
   AND a.soc like 'MCTB%'
   AND RTRIM(a.feature_code) in ('CUG', 'M-VPT2')
   AND SYSDATE BETWEEN a.ftr_effective_date AND a.ftr_expiration_date
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code;

SELECT * FROM pnp WHERE pni_type = 'V';
SELECT * FROM pnp WHERE pni_type = 'C' and pni like 'CAT%';

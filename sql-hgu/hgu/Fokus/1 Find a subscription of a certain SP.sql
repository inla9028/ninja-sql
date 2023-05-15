select a.soc_code
  from spm_priceplan_mapping a
 where a.service_provider_code = 'NewCo'
   and trunc(sysdate) between a.effective_date and nvl(a.expiration_date, sysdate)
;

with sp_priceplans as (
  select a.soc_code
    from spm_priceplan_mapping a
   where a.service_provider_code = 'NewCo'
     and trunc(sysdate) between a.effective_date and nvl(a.expiration_date, sysdate)
)
SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status, s.sub_status_date, a1.soc AS "PP"
  FROM subscriber@fokus s, service_agreement@fokus a1, sp_priceplans sp
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND nvl(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)    = sp.soc_code
   AND ROWNUM < 21
;
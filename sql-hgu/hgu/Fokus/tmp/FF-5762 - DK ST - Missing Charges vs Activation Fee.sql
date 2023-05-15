SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE (m.memo_subscriber IN ( 'GSM045' || '27152178', 'GSM045' || '27151241' )/* OR m.memo_ban = 862485802*/)
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TRUNC(SYSDATE, 'DAY')
ORDER BY m.memo_id
;

select a.*
  from pp_ac_rate a
 where rtrim(a.soc) IN ('FLEXPA27', 'P_GPMBBXS')
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and nvl(a.rate, 0) != 0
;

select a.root_ban, a.ban, a.subscriber_no, a.sys_creation_date, a.actv_code,
       a.actv_reason_code, a.actv_amt, a.feature_code, a.feature_category,
       a.soc, a.soc_date, a.vat_amt, a.vat_exmp_amt, a.vat_percent_rate,
       a.before_discnt_amt, a.memo_id
  from charge a
 where a.ban = 862485802
   and a.subscriber_no IN ( 'GSM045' || '27152178', 'GSM045' || '27151241' )
;

select a.*
  from service_agreement a
 where a.subscriber_no IN ( 'GSM045' || '27152178', 'GSM045' || '27151241' )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
;

/*
**
** Based on a (set of) campaign(s), list description, price plan and price plan's description.
**
*/
select UNIQUE RTRIM(a.campaign) as "CAMPAIGN", RTRIM(a.campaign_desc) as "CAMPAIGN_DESC"
            , b.pp_code as "PRICE_PLAN", RTRIM(c.soc_description) as "PRICE_PLAN_DESC"
            , b.act_fee
  from campaign a, campaign_commitments b, soc c
 where RTRIM(a.campaign)  = RTRIM(b.campaign)
   and RTRIM(b.pp_code)   = RTRIM(c.soc)
   and sysdate      between c.effective_date and nvl(c.expiration_date, sysdate + 1)
   and RTRIM(a.campaign) in (
    'FLEXPA27', 'P_GPMBBXS'
 )
order by RTRIM(a.campaign)
;

select a.*
  from campaign_commitments a
 where sysdate      between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and RTRIM(a.campaign) in ( 'FLEXPA27', 'P_GPMBBXS' )
;


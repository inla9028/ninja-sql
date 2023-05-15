/*
**
** Display the charges for a BAN and Subscriber.
**
*/
select a.root_ban, a.ban, a.subscriber_no, a.sys_creation_date, a.actv_code,
       a.actv_reason_code, a.actv_amt, a.feature_code, a.feature_category,
       a.soc, a.soc_date, a.vat_amt, a.vat_exmp_amt, a.vat_percent_rate,
       a.before_discnt_amt, a.memo_id
  from charge@fokus a
 where a.ban           = 757828017
   and a.subscriber_no = 'GSM047' || '580000033757'
--   and a.sys_creation_date > trunc(sysdate - 1)
;

/*
** Simply list the subscriber socs (and ban).
*/
select a.*
  from service_agreement@fokus a
 where a.subscriber_no = 'GSM047' || '580000033757'
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.soc
;

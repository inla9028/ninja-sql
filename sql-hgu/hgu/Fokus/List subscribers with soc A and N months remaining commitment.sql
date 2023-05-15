select a.subscriber_no, rtrim(a.soc) as "SOC", a.effective_date, b.commit_end_date
  from service_agreement a, subscriber b
 where rtrim(a.soc) IN ( 'NCFD02', 'NCFD01' )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and a.subscriber_no = b.subscriber_no
   and b.sub_status    = 'A'
   and nvl(b.commit_end_date, to_date('4700-12-31', 'YYYY-MM-DD')) between sysdate and (select add_months(sysdate, 11) from dual)
--   and to_date('2011-11-16', 'YYYY-MM-DD') between a.effective_date and nvl(a.expiration_date, sysdate + 1)
 order by a.subscriber_no, a.soc
;

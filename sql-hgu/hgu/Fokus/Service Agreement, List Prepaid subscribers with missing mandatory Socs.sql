/*
**
** First run this query in FOKUS to get a list of the price plans
** that ought to have the specified soc ('WDFPRE' in this case).
**
*/
SELECT rtrim(a.soc_first) as "SOC_FIRST", rtrim(a.soc_second) as "SOC_SECOND",
       a.effective_date, a.illegal_ind
  FROM soc_illegal_comb a
 WHERE 'WDFPRE' IN (RTRIM (a.soc_first), RTRIM (a.soc_second))
   AND SYSDATE BETWEEN a.effective_date AND NVL (a.expiration_date, SYSDATE + 1)
   AND a.illegal_ind = 'T'
ORDER BY a.soc_first, a.soc_second
;


/*
**
** Second, update the 'IN' statement with the result from the query above
** (again, the query above should be run in FOKUS).
**
*/
select a.ban, a.subscriber_no, rtrim(a.soc) as "SOC", a.effective_date
  from service_agreement a
 where rtrim(a.soc) IN ( 'PKOC', 'PKOD', 'PKOF', 'PKOG', 'PKOI', 'PKOM', 'PKON', 'PKOP', 'PKOS', 'PKOT', 'PKOU', 'PKOV', 'PKOX', 'PKOY' )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
--   and to_date('2011-11-16', 'YYYY-MM-DD') between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and 0 = (
       select count(1) from service_agreement b
        where a.ban           = b.ban
          and a.subscriber_no = b.subscriber_no
          and sysdate between b.effective_date and nvl(b.expiration_date, sysdate + 1)
          and rtrim(b.soc)    = 'WDFPRE'
   )
 order by a.ban, a.subscriber_no, a.soc
;


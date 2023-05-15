select s.customer_id as "BAN", count(1) as "NR_OF_SUBSCRIBERS"
  from subscriber s
 where s.customer_id in (
   195639703, 219529708, 487103905, 626639702, 687103903, 754574903, 877191908
 ) and s.sub_status = 'A'
 group by s.customer_id
 order by s.customer_id;

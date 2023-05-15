select a.*
  from pp_rc_rate@fokus a
 where 1 = 1
--   AND nvl(a.rate, 0) != 0
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   AND rtrim(a.soc) IN ('MCTB1', 'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE', 'MCTBCHG1')
;

select b.*
  from soc_relation@fokus b
 where 'PSSA' in (rtrim(b.soc_src), rtrim(b.soc_dest))
   and sysdate < nvl(b.expiration_date, sysdate + 1)
order by b.soc_src, b.soc_dest
;

select a.*
  from pp_oc_rate@fokus a, soc_relation@fokus b
 where 1 = 1
   -- and nvl(a.rate, 0) != 0
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and rtrim(a.soc) in (rtrim(b.soc_src), rtrim(b.soc_dest))
   and 'MCTB5'       in (rtrim(b.soc_src), rtrim(b.soc_dest))
   and sysdate < nvl(b.expiration_date, sysdate + 1)
;

select rtrim(a.soc) AS "SOC", to_char(a.rate, '990.99') AS "RATE"
  from pp_rc_rate@fokus a
 where 1 = 1
--   AND nvl(a.rate, 0) != 0
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   AND rtrim(a.soc) IN ('PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE', 'MCTB1',
                            'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE', 'MCTBCHG1')
ORDER BY a.soc
;

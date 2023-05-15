/*
**
** Display all records records for Friends and Family Plan Codes...
**
*/
select a.*
  from fr_fm_plan a
 where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.fr_fm_plan_cd
;

/*
**
** Display relevant columns...
**
*/
select a.fr_fm_plan_cd, a.fr_fm_plan_desc, a.discount_type, a.period_ind,
       a.min_at_rate, a.min_toll_rate, a.skip_min_num_1, a.skip_min_pcnt_1,
       a.ac_free_ind, a.call_attempt_free_ind
  from fr_fm_plan a
 where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.fr_fm_plan_cd
;

/*
** Display the currently effective cycles.
*/
select cycle_code, cycle_start_date, cycle_close_date, sys_creation_date
  from cycle_control
 where 1 = 1
   and sysdate between cycle_start_date and cycle_close_date
order by cycle_code, cycle_start_date
;

/*
** Display the last defined cycle_close_date of all cycle_codes.
*/
select cc.cycle_code, cc.cycle_start_date, cc.cycle_close_date
  from cycle_control cc
 where 1 = 1
   and rowid in (
     select cccp.rowid, cccp.cycle_code, max(cccp.cycle_close_date) as "cycle_close_date"
       from cycle_control cccp
     group by cccp.rowid, cccp.cycle_code
   )
order by cc.cycle_code, cc.cycle_start_date
;

select cc.cycle_code, cc.cycle_start_date, max(cc.cycle_close_date) as "CYCLE_CLOSE_DATE"
  from cycle_control cc
 where 1 = 1
--   and cc.cycle_code in (1, 2)
group by cc.cycle_code, cc.cycle_start_date
order by cc.cycle_code
;
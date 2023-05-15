/*
** List BAN Tree Hierarchy for a given BAN.
*/
select a.tree_root_ban, a.ban, a.parent_ban, a.tree_level, a.effective_date, a.expiration_date
  from BAN_HIERARCHY_TREE a
 where 588655415 in (a.tree_root_ban, a.ban, a.parent_ban)
   and sysdate between a.effective_date and NVL(a.expiration_date, sysdate + 1)
order by a.tree_level, a.tree_root_ban, a.ban, a.parent_ban
;

/*
** List the BAN's bill-cycle, if it's 99 it's only teemporary due to billing being run.
*/
select a.ban, decode(a.bill_cycle, 99, '99 (Due to Billing)', a.bill_cycle) as "BILL_CYCLE", 
       a.ban_status, a.account_type, a.account_sub_type 
  from billing_account a
 where a.ban        = 588655415
   and a.ban_status = 'O'
;

/*
** List CYCLE_CONTROL for a given BAN.
*/
select cc.cycle_code, cc.cycle_start_date,
       max(cc.cycle_close_date) as "CYCLE_CLOSE_DATE", cc.sys_creation_date
  from cycle_control cc
 where cc.cycle_code in (
   select b.bill_cycle
     from billing_account b
     where b.ban        = 588655415
       and b.ban_status = 'O'
 )
group by cc.cycle_code, cc.cycle_start_date, "CYCLE_CLOSE_DATE", cc.sys_creation_date
order by cc.cycle_code
;

/*
** List all future cycles in CYCLE_CONTROL for a given BAN.
*/
select cc.cycle_code, cc.cycle_start_date,
       max(cc.cycle_close_date) as "CYCLE_CLOSE_DATE", cc.sys_creation_date
  from cycle_control cc
 where trunc(sysdate, 'MON') < cc.cycle_start_date
   and sysdate               < cc.cycle_close_date
   and cc.cycle_code        in (
   select b.bill_cycle
     from billing_account b
     where b.ban        = 588655415
       and b.ban_status = 'O'
 )
group by cc.cycle_code, cc.cycle_start_date, "CYCLE_CLOSE_DATE", cc.sys_creation_date
order by cc.cycle_code
;

/*
** List all future cycles for all bill cycles/cycle-codes.
*/
select cc.cycle_code, cc.cycle_start_date,
       max(cc.cycle_close_date) as "CYCLE_CLOSE_DATE", cc.sys_creation_date
  from cycle_control cc
 where trunc(sysdate, 'MON') < cc.cycle_start_date
   and sysdate               < cc.cycle_close_date
group by cc.cycle_code, cc.cycle_start_date, "CYCLE_CLOSE_DATE", cc.sys_creation_date
order by cc.cycle_code
;

/*
** List the number of future cycles per cycle-code
*/
select cc.cycle_code, count(1) as "FUTURE_CYCLE_COUNT"
  from cycle_control cc
 where trunc(sysdate, 'MON') < cc.cycle_start_date
   and sysdate               < cc.cycle_close_date
group by cc.cycle_code
order by cc.cycle_code
;

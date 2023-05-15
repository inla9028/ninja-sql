select a.*
  from all_tables a
 where a.table_name LIKE 'PP__%C_RATE'
order by a.owner, a.table_name
;

select a.*
  from pp_camp_rel a
;

select a.*
  from pp_camp_soc_rel a
;

select a.account_type, a.account_sub_type, a.priceplan, count(1) as "COUNT"
  from pp_camp_soc_rel a
group by a.account_type, a.account_sub_type, a.priceplan
order by a.account_type, a.account_sub_type, a.priceplan
;

/*
**
** List the charges codes/types read/cached by Ninja.
**
*/
SELECT rtrim(FEATURE_CODE) as FEATURE_CODE,
      rtrim(CHARGE_TYPE) as CHARGE_TYPE,
      rtrim(FTR_REVENUE_CODE) as FTR_REVENUE_CODE,
      rtrim(MANUAL_OC_CREATE_IND) as MANUAL_OC_CREATE_IND,
      rtrim(MNL_OC_TXT_OVRD_IND) as MNL_OC_TXT_OVRD_IND
FROM charge_info
;


/*
**
** Activation charges
**
*/
select a.*
  from PP_AC_RATE a
 where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.soc
;

/*
**
** One-time charges
**
*/
select a.*
  from PP_OC_RATE a
 where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.soc
;

/*
**
** Recurring charges
**
*/
select a.*
  from PP_RC_RATE a
 where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.soc
;

/*
**
** One-time charges
**
*/
select a.*
  from PP_UC_RATE a
 where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.soc
;
/*
**
** Select all the columns aimed for SRM_FEATURE_PARAMETERS table.
**
*/
select s.soc, sd.description, sd.language_code,
       fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory,
       fp.modifiable, fp.is_cloneable as "CLONEABLE", fp.displayable, 
       fp.default_value, count(*) as soc_count
  from feature_parameters fp, socs s, socs_descriptions sd
 where s.soc_type     IN ('MMS')
   and s.soc           = fp.soc 
   and s.soc           = sd.soc
   and (fp.displayable  = 'Y' or (fp.mandatory = 'Y' and fp.modifiable = 'Y')) 
--   and fp.feature_code IN ('V-PERS')
   and fp.parameter_code IN ('COS')
   and sd.language_code = 'NO'
   and 0 != (
     select count(1)
       from subscription_types_socs sts
      where s.soc = sts.soc
        and sysdate between sts.effective_date and sts.expiration_date
   )
GROUP BY s.soc, sd.description, sd.language_code, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
-- order by s.soc_type, s.soc_group, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
 order by s.soc, sd.description, sd.language_code, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
;


select s.soc, s.soc_type, s.soc_group,  sd.description, sd.language_code,
       fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory,
       fp.modifiable, fp.is_cloneable as "CLONEABLE", fp.displayable, 
       fp.default_value, count(*) as soc_count
  from feature_parameters fp, socs s, socs_descriptions sd
 where /*s.soc_type     IN ('GPRS')
   and */s.soc           = fp.soc 
   and s.soc           = sd.soc
   and (fp.displayable  = 'Y' or (fp.mandatory = 'Y' and fp.modifiable = 'Y')) 
--   and fp.feature_code IN ('V-PERS')
   and sd.language_code = 'NO'
group by s.soc, s.soc_type, s.soc_group, sd.description, sd.language_code, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
-- order by s.soc_type, s.soc_group, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
order by /*s.soc,*/ fp.feature_code, fp.parameter_code, fp.parameter_type, s.soc_type, s.soc_group, sd.description, sd.language_code, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
;


/*
**
** Select all soc-types and groups for the unique feature parameters. 
**
*/
select soc_type, s.soc_group, count(*) as "COUNT"
  from socs s
 where 0 != (
   select count(*)
     from feature_parameters fp
    where s.soc = fp.soc
 )
group by soc_type, s.soc_group
order by soc_type, s.soc_group
;

/*
**
** Display the ... you see what it does.
**
*/
select i.icim_product_code, s.soc_type, s.soc_group,
       fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory,
       fp.modifiable, fp.is_cloneable as "CLONEABLE", fp.displayable, 
       fp.default_value, count(*) as soc_count
  from feature_parameters fp, socs s, icim_product i
 where /*s.soc_type IN ('TSIM')
   and */s.soc       = fp.soc
   and s.soc_type  = i.soc_type
   and s.soc_group = i.soc_group
   and (
       fp.displayable  = 'Y'
    or (fp.mandatory = 'Y' and fp.modifiable = 'Y')
)
group by i.icim_product_code, s.soc_type, s.soc_group, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
order by i.icim_product_code, s.soc_type, s.soc_group, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
;

select s.*
  from socs s
 where s.soc_type in ('DATA')
;

select s.*
  from soc_type_group s
 where s.soc_type in ('DATA')
;

select i.*
  from icim_product i
 where i.soc_type in ('DATA')
;

/*
**
** Insert dummy-values - known to be flawed - in order to continue testing.
** Errors:
**   1. We added SP socs, which had same features but was mandatory (soc: VMVSB+, Ft.code: V-PERS, Prm.code: PO-PHONE-NUM)
**
*/
insert into srm_feature_parameters 
(
  product_specification_id, feature_code, parameter_code, parameter_type,
  mandatory, modifiable, cloneable, displayable, default_value
)
select * from (
select distinct i.icim_product_code, fp.feature_code, fp.parameter_code, fp.parameter_type,
       fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value
  from feature_parameters fp, socs s, icim_product i
 where /*s.soc_type    IN ('DATA')
   and */s.soc          = fp.soc
   and s.soc_type     = i.soc_type
   and s.soc_group    = i.soc_group
   and fp.displayable = 'Y'
   and (
     not (
         i.icim_product_code IN ('BEDRIFTSVAR')
     and fp.feature_code      = 'V-PERS'
     and fp.parameter_code    = 'PO-PHONE-NUM'
     and fp.mandatory         = 'Y' 
     )
   )
 order by i.icim_product_code, fp.feature_code, fp.parameter_code, fp.parameter_type
);

/*******************************************************************************
**                                Descriptions
*******************************************************************************/
   
select fd.*
  from feature_parameter_desc fd
;

select distinct sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description
  from feat_parms_parm_desc fp, feature_parameter_desc fd, srm_feature_parameters sp
 where fp.language_code     = fd.language_code
   and fp.parameter_name_id = fd.parameter_name_id
   and fp.feature_code      = sp.feature_code
   and fp.parameter_code    = sp.parameter_code
 order by sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code
;

select count(*)
--from (select distinct * 
  from feat_parms_parm_desc fp, feature_parameter_desc fd, srm_feature_parameters sp
 where fp.language_code     = fd.language_code
   and fp.parameter_name_id = fd.parameter_name_id
   and fp.feature_code      = sp.feature_code
   and fp.parameter_code    = sp.parameter_code
--)
;

/*
**
** Descriptions: Add dummy-values known to be flawed - in order to continue testing.
** Errors:
**   1. CONNECT_EVENING_AP; we get both CONNECT and GPRS descriptions...
**
*/
insert into srm_feature_parameters_desc 
(
  product_specification_id, feature_code, parameter_code, language_code, description
)
select * from (
select distinct sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description
  from feat_parms_parm_desc fp, feature_parameter_desc fd, srm_feature_parameters sp
 where fp.language_code     = fd.language_code
   and fp.parameter_name_id = fd.parameter_name_id
   and fp.feature_code      = sp.feature_code
   and fp.parameter_code    = sp.parameter_code
   and (
     not (
         sp.product_specification_id IN ('CONNECT_EVENING_AP', 'CONNECT_MAXPRIS_AP')
     and fp.feature_code              = 'B-GPRS'
     and fp.parameter_code            = 'APN'
     and fd.description            LIKE 'GPRS%' 
     )
   )
 order by sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code
);

/*******************************************************************************
**                              Driver table(s)
*******************************************************************************/

/*
** Create table...
*/
create table srm_feature_parameters_driver as
select i.icim_product_code, s.soc, s.soc_type, s.soc_group,
       fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory,
       fp.modifiable, fp.is_cloneable as "CLONEABLE", fp.displayable, 
       fp.default_value 
       -- , i.icim_product_code as "SP"
       -- , count(*) as "COUNT"
       , b.account_type, b.account_sub_type
  from feature_parameters fp, socs s, icim_product i, subscription_types_socs sts, bill_agr_types_sub_types b
 where --s.soc_type IN ('TSIM') and
       s.soc       = fp.soc
   and s.soc_type  = i.soc_type
   and s.soc_group = i.soc_group
/*   and (
       fp.displayable  = 'Y'
    or (fp.mandatory = 'Y' and fp.modifiable = 'Y')
)*/
   and s.soc                  = sts.soc
   and sysdate          between sts.effective_date and sts.expiration_date
   and sts.subscription_type_id = b.subscription_type_id
   and sysdate          between b.effective_date and b.expiration_date
group by i.icim_product_code, s.soc, s.soc_type, s.soc_group, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value, b.account_type, b.account_sub_type
order by i.icim_product_code, s.soc, s.soc_type, s.soc_group, fp.feature_code, fp.parameter_code, fp.parameter_type, fp.mandatory, fp.modifiable, fp.is_cloneable, fp.displayable, fp.default_value, b.account_type, b.account_sub_type
;

/*
** Investigate records in the temporary driver table...
*/
select distinct a.icim_product_code, a.soc, a.soc_type, a.soc_group, a.feature_code,
       a.parameter_code, a.parameter_type, a.mandatory, a.modifiable,
       a.cloneable, a.displayable, a.default_value
       , a.account_type, a.account_sub_type
       -- , fp.soc
       , count(1) as "COUNT"
  from srm_feature_parameters_driver a, srm_feature_parameters_driver b, feature_parameters fp
 where a.icim_product_code = b.icim_product_code
   and a.soc_type          = b.soc_type 
   and a.soc_group         = b.soc_group
   and a.feature_code      = b.feature_code
   and a.parameter_code    = b.parameter_code
   and a.parameter_type    = b.parameter_type
   and
   (
       a.mandatory     != b.mandatory
    or a.modifiable    != b.modifiable
    or a.cloneable     != b.cloneable
    or a.displayable   != b.displayable
    or a.default_value != b.default_value
   )
   and a.feature_code      = fp.feature_code
   and a.parameter_code    = fp.parameter_code
   and a.parameter_type    = fp.parameter_type
   and a.mandatory         = fp.mandatory
   and a.modifiable        = fp.modifiable
   and a.cloneable         = fp.is_cloneable
   and a.displayable       = fp.displayable
   and a.default_value     = fp.default_value
--   and a.account_type in ('B', 'I', 'P')
group by a.icim_product_code, a.soc, a.soc_type, a.soc_group, a.feature_code, a.parameter_code, a.parameter_type, a.mandatory, a.modifiable, a.cloneable, a.displayable, a.default_value, a.account_type, a.account_sub_type
order by a.icim_product_code, a.soc, a.soc_type, a.soc_group, a.feature_code, a.parameter_code, a.parameter_type, a.mandatory, a.modifiable, a.cloneable, a.displayable, a.default_value, a.account_type, a.account_sub_type
;

/*
** Investigate regular products (account_type IN ('B', 'I', 'P')
*/
select a.account_type, a.account_sub_type, count(1) as "COUNT"
  from srm_feature_parameters_driver a
group by a.account_type, a.account_sub_type
order by a.account_type, a.account_sub_type
;

select distinct a.icim_product_code, a.soc, a.soc_type, a.soc_group, a.feature_code,
       a.parameter_code, a.parameter_type, a.mandatory, a.modifiable,
       a.cloneable, a.displayable, a.default_value
       --, a.account_type, a.account_sub_type
  from srm_feature_parameters_driver a
 where a.account_type in ('B', 'I', 'P')
order by a.icim_product_code, a.soc, a.soc_type, a.soc_group, a.feature_code,
         a.parameter_code, a.parameter_type, a.mandatory, a.modifiable,
         a.cloneable, a.displayable, a.default_value
         --, a.account_type, a.account_sub_type
;


select distinct a.icim_product_code, a.feature_code, a.parameter_code, 
       a.parameter_type, a.mandatory, a.modifiable, a.cloneable, a.displayable,
       a.default_value
  from srm_feature_parameters_driver a, srm_feature_parameters_driver b
 where a.account_type in ('B', 'I', 'P')
   and a.icim_product_code = b.icim_product_code
   and a.feature_code      = b.feature_code
   and a.parameter_code    = b.parameter_code
   and a.parameter_type    = b.parameter_type
   and (
       a.mandatory     != b.mandatory
    or a.modifiable    != b.modifiable
    or a.cloneable     != b.cloneable
    or a.displayable   != b.displayable
    or a.default_value != b.default_value
   )
order by a.icim_product_code, a.feature_code, a.parameter_code, 
         a.parameter_type, a.mandatory, a.modifiable, a.cloneable, a.displayable,
         a.default_value
;

/*
** Drop table...
*/
drop table srm_feature_parameters_driver purge;
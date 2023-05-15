/*******************************************************************************
**                           Feature Parameters
*******************************************************************************/

/*
**
**
**
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
 where s.soc          = fp.soc
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
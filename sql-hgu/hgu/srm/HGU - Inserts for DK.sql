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

insert into srm_feature_parameters 
(
  product_specification_id, feature_code, parameter_code, parameter_type,
  mandatory, modifiable, cloneable, displayable, default_value
)
select * from (
select distinct a.icim_product_code, a.feature_code, a.parameter_code, a.parameter_type,
                a.mandatory, a.modifiable, a.cloneable, a.displayable, a.default_value
  from srm_feature_parameters_driver a
group by a.icim_product_code, a.feature_code, a.parameter_code, a.parameter_type, a.mandatory, a.modifiable, a.cloneable, a.displayable, a.default_value
order by a.icim_product_code, a.feature_code, a.parameter_code, a.parameter_type, a.mandatory, a.modifiable, a.cloneable, a.displayable, a.default_value
);



/*
**
** DESC
**
*/

insert into srm_feature_parameters_desc 
(
  product_specification_id, feature_code, parameter_code, language_code, description
)
select * from (
select sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description
  from feat_parms_parm_desc fp, feature_parameter_desc fd, srm_feature_parameters sp
 where fp.language_code     = fd.language_code
   and fp.parameter_name_id = fd.parameter_name_id
   and fp.feature_code      = sp.feature_code
   and fp.parameter_code    = sp.parameter_code
group by sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description
order by sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description
);

/*
select distinct sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description
  from feat_parms_parm_desc fp, feature_parameter_desc fd, srm_feature_parameters sp
 where fp.language_code     = fd.language_code
   and fp.parameter_name_id = fd.parameter_name_id
   and fp.feature_code      = sp.feature_code
   and fp.parameter_code    = sp.parameter_code
   and (
       
   )
group by sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code
order by sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code
;


select * from (
select distinct sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description, count(1) as "COUNT"
  from feat_parms_parm_desc fp, feature_parameter_desc fd, srm_feature_parameters sp
 where fp.language_code     = fd.language_code
   and fp.parameter_name_id = fd.parameter_name_id
   and fp.feature_code      = sp.feature_code
   and fp.parameter_code    = sp.parameter_code
group by sp.product_specification_id, fp.feature_code, fp.parameter_code, fp.language_code, fd.description
order by count(1) DESC
);
*/

select product_specification_id, feature_code, parameter_code, language_code, description, count(1) as "COUNT"
  from srm_feature_parameters_desc
group by product_specification_id, feature_code, parameter_code, language_code, description
order by count(1) DESC
;

/*
**
** DROP
**
*/
drop table srm_feature_parameters_driver purge;
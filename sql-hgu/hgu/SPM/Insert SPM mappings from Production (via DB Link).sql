delete
  from spm_priceplan_mapping
;

insert into spm_priceplan_mapping
select p.*
  from spm_priceplan_mapping@prod p
;

delete
  from spm_service_mapping
;

insert into spm_service_mapping
select p.*
  from spm_service_mapping@prod p
;

delete
  from spm_feature_mapping
;

insert into spm_feature_mapping
select p.*
  from spm_feature_mapping@prod p
;
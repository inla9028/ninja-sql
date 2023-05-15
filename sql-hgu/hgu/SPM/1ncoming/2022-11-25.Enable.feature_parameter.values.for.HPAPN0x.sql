INSERT INTO feature_parameter_mappings (param_type,param_value,operation,new_value,effective_date,expiration_date,comments)
values ('IP_TYPE','both','R',null,TRUNC(SYSDATE),to_date('4700-12-31','YYYY-MM-DD'),'IP_TYPE should be either 4 or 6 (SPAPN01-5, HPAPN01-5)');

INSERT INTO feature_parameter_mappings (param_type,param_value,operation,new_value,effective_date,expiration_date,comments)
values ('IP_TYPE','both','W',null,TRUNC(SYSDATE),to_date('4700-12-31','YYYY-MM-DD'),'IP_TYPE should be either 4 or 6 (SPAPN01-5, HPAPN01-5)');

UPDATE feature_parameter_mappings a
   SET a.comments   = 'IP_TYPE should be either 4 or 6, or "both" (since Nov 2022) for SOCs SPAPN01-5, HPAPN01-5'
 WHERE a.param_type = 'IP_TYPE'
;


select a.*
  from feature_parameter_mappings a
 where a.param_type = 'IP_TYPE'
--   and a.param_value = 'ipv4'
order by 1,2,3
;


select rtrim(rf.soc) as "SOC", rtrim(f.feature_code) as "FEATURE_CODE", 
       rtrim(f.mps_feature_code) as "MPS_FEATURE_CODE", f.service_level, 
       rtrim(f.feature_desc) as "FEATURE_DESC", nvl(rf.max_members, 0) as "MAX_MEMBERS"
  from rated_feature@fokus rf, feature@fokus f, feature_types@fokus ft
       , socs_features sf
 where f.feature_code  = rf.feature_code 
   and f.feature_group = 'SF' 
   and ft.feature_type = f.feature_type 
   and sysdate between rf.effective_date and nvl(rf.expiration_date, sysdate + 1) 
   and rtrim(rf.soc)   = sf.soc 
   and f.feature_code  = sf.feature_code
   and sf.feature_type = 'F-AND-F'
order by rtrim(rf.soc), rtrim(f.feature_code)
;
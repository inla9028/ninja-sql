/*
select 'grant ALTER on ' || a.table_name || ' to ninjamain;' as "ALTER"
      ,'grant DELETE on ' || a.table_name || ' to ninjamain;' as "DELETE"
      ,'grant INDEX on ' || a.table_name || ' to ninjamain;' as "INDEX"
      ,'grant INSERT on ' || a.table_name || ' to ninjamain;' as "INSERT"
      ,'grant SELECT on ' || a.table_name || ' to ninjamain;' as "SELECT"
      ,'grant UPDATE on ' || a.table_name || ' to ninjamain;' as "UPDATE"
      ,'grant REFERENCES on ' || a.table_name || ' to ninjamain;' as "REFERENCES"
      ,'grant ON COMMIT REFRESH on ' || a.table_name || ' to ninjamain;' as "ON COMMIT REFRESH"
      ,'grant QUERY REWRITE on ' || a.table_name || ' to ninjamain;' as "QUERY REWRITE"
      ,'grant DEBUG on ' || a.table_name || ' to ninjamain;' as "DEBUG"
      ,'grant FLASHBACK on ' || a.table_name || ' to ninjamain;' as "FLASHBACK"
  from all_tables a
 where a.owner = 'NINJARULES'
   and a.table_name like 'SRM%'
order by a.table_name
;
*/

grant ALTER on SRM_FEATURE_PARAMETERS to ninjamain;
grant DELETE on SRM_FEATURE_PARAMETERS to ninjamain;
grant INDEX on SRM_FEATURE_PARAMETERS to ninjamain;
grant INSERT on SRM_FEATURE_PARAMETERS to ninjamain;
grant SELECT on SRM_FEATURE_PARAMETERS to ninjamain;
grant UPDATE on SRM_FEATURE_PARAMETERS to ninjamain;
grant REFERENCES on SRM_FEATURE_PARAMETERS to ninjamain;
grant ON COMMIT REFRESH on SRM_FEATURE_PARAMETERS to ninjamain;
grant QUERY REWRITE on SRM_FEATURE_PARAMETERS to ninjamain;
grant DEBUG on SRM_FEATURE_PARAMETERS to ninjamain;
grant FLASHBACK on SRM_FEATURE_PARAMETERS to ninjamain;
grant ALTER on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant DELETE on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant INDEX on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant INSERT on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant SELECT on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant UPDATE on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant REFERENCES on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant ON COMMIT REFRESH on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant QUERY REWRITE on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant DEBUG on SRM_FEATURE_PARAMETERS_DESC to ninjamain;
grant FLASHBACK on SRM_FEATURE_PARAMETERS_DESC to ninjamain;


/*
select 'CREATE OR REPLACE SYNONYM "NINJAMAIN"."' || a.table_name || '" FOR "' || a.owner || '"."' || a.table_name || '";' as "SYNONYM"
  from all_tables a
 where a.owner = 'NINJARULES'
   and a.table_name like 'SRM%'
order by a.table_name
;
*/

CREATE OR REPLACE SYNONYM "NINJAMAIN"."SRM_FEATURE_PARAMETERS" FOR "NINJARULES"."SRM_FEATURE_PARAMETERS";
CREATE OR REPLACE SYNONYM "NINJAMAIN"."SRM_FEATURE_PARAMETERS_DESC" FOR "NINJARULES"."SRM_FEATURE_PARAMETERS_DESC";

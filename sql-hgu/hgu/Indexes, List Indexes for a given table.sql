select ai.owner, ai.index_name, ai.table_owner, ai.table_name, aic.column_name
     , ai.index_type, ai.uniqueness, aie.column_expression
 from all_ind_columns aic, all_indexes ai, all_ind_expressions aie
 WHERE 1                   = 1
   and ai.table_owner      = 'NINJADATA'
   and ai.table_name       = 'PARTY_MANAGER_EVENTS'
   and ai.index_name       = aic.index_name
   and ai.owner            = aic.indeX_owner
   and aic.index_owner     = aie.index_owner(+)
   and aic.index_name      = aie.index_name(+)
   and aic.table_owner     = aie.table_owner(+)
   and aic.table_name      = aie.table_name(+)
   and aic.column_position = aie.column_position(+)
order by 1,2,3,4,5
;

/*
** all_indexes  -- all indexes that you can see
** user_indexes -- all indexes in your schema
** dba_indexes  -- all indexes in database
*/
select ai.owner, ai.index_name, ai.table_name, ai.table_owner, ai.index_type, ai.uniqueness
  from all_indexes ai
 where ai.table_name = 'PARTY_MANAGER_EVENTS'
order by 1,2,3
;


select ai.*
  from all_indexes ai
 where ai.table_name = 'PARTY_MANAGER_EVENTS' 
order by 1,2
;

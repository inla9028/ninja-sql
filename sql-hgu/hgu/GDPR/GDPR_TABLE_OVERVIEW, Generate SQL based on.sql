SELECT a.*
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
ORDER BY 1,2,3
;

/*
** Generate select row-count based on retention.
*/
SELECT 'SELECT COUNT(1) AS "' || UPPER(a.table_name) || '"'
       || ' FROM ' || LOWER(a.schema_name) || '.' || LOWER(a.table_name) 
       || ' WHERE ' || LOWER(a.retention_column) || ' < TRUNC(SYSDATE - ' || LOWER(a.retention_days) || ');'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
ORDER BY 1
;

/*
** Generate select row-count
*/
SELECT 'SELECT COUNT(1) AS "' || UPPER(a.table_name) || '"' 
       || ' FROM ' || LOWER(a.schema_name) || '.' || LOWER(a.table_name) || ';'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
ORDER BY 1
;

/*
** Generate DELETE based on retention.
*/
SELECT 'DELETE FROM ' || LOWER(a.schema_name) || '.' || LOWER(a.table_name) 
       || ' WHERE ' || LOWER(a.retention_column) || ' < TRUNC(SYSDATE - ' || LOWER(a.retention_days) || ');'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
ORDER BY 1
;

/*
** Generate GRANT for DELETE
*/
SELECT 'GRANT DELETE ON ' || LOWER(a.table_name) || ' TO ninjamain;'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
ORDER BY 1
;

/*
** Generate GRANT for SELECT
*/
SELECT 'GRANT SELECT ON ' || LOWER(a.table_name) || ' TO ninjamain;'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
ORDER BY 1
;


/*
** Generate GRANT for UPDATE
*/
SELECT 'GRANT UPDATE ON ' || LOWER(a.table_name) || ' TO ninjamain;'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
ORDER BY 1
;

/*
** Generate creation of indexes for all searchable columns.
*/
SELECT 'CREATE INDEX gdpr_idx_' || LOWER(a.data_type) || '_' || SUBSTR(LOWER(a.table_name), 0, (30-13)) || ' ON ' || LOWER(a.table_name) || ' ( ' || LOWER(a.column_name) || ' ASC );'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.column_name IS NOT NULL
   AND a.data_type   IS NOT NULL
   AND 0 = (
        SELECT COUNT(1)
          FROM all_ind_columns b
         WHERE a.schema_name = b.table_owner
           AND a.table_name  = b.table_name
           AND a.column_name = b.column_name
   )
ORDER BY 1
;

/*
** Generate creation of indexes for all retention columns.
*/
SELECT 'CREATE INDEX gdpr_idx_' || SUBSTR(LOWER(a.table_name), 0, (30-9)) || ' ON ' || LOWER(a.table_name) || ' ( ' || LOWER(a.retention_column) || ' ASC );'
       AS "SQL"
  FROM gdpr_table_overview a
 WHERE a.retention_column IS NOT NULL
   AND 0 = (
        SELECT COUNT(1)
          FROM all_ind_columns b
         WHERE a.schema_name      = b.table_owner
           AND a.table_name       = b.table_name
           AND a.retention_column = b.column_name
   )
ORDER BY 1
;



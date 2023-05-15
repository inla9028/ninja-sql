/*
** 1...
*/
SELECT a.*
  FROM all_tab_cols a
 WHERE a.owner = 'NINJADATA'
   AND a.column_name LIKE '%REQUEST%'
;

/*
** 2...
*/
SELECT a.*
  FROM all_tab_cols a
 WHERE a.owner        = 'NINJADATA'
   AND a.column_name IN ('REQUEST_ID', 'REQUEST_REFERENCE_ID', 'REQUEST_USER_ID', 'REQUESTOR_ID')
   AND a.data_type    = 'VARCHAR2'
   AND a.data_length  < 60
;

/*
** 3... Go!
*/
SELECT 'ALTER TABLE ' || LOWER(a.owner) || '.' || LOWER(a.table_name) || ' MODIFY ' || LOWER(a.column_name) || ' VARCHAR2(60 CHAR);'
       AS "SQL"
  FROM all_tab_cols a
 WHERE a.owner        = 'NINJADATA'
   AND a.column_name IN ('REQUEST_ID', 'REQUEST_REFERENCE_ID', 'REQUEST_USER_ID', 'REQUESTOR_ID')
   AND a.data_type    = 'VARCHAR2'
   AND a.data_length  < 60
;


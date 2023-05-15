--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Find a table where a certain column exists...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.owner, a.table_name, a.column_name
  FROM all_tab_columns a
 WHERE a.column_name LIKE '%BILL_INFO%';


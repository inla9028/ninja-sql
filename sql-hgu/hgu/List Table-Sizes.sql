--
-- List the size of tables in Ninja, largest on top.
--
select a.owner, a.table_name, a.num_rows, a.avg_row_len
     ,        (a.num_rows * a.avg_row_len)                             AS "BYTES"
     , round(((a.num_rows * a.avg_row_len) / (1024 * 1024)), 1)        AS "MB"
     , round(((a.num_rows * a.avg_row_len) / (1024 * 1024 * 1024)), 1) AS "GB"
  from all_tables a
 where a.num_rows is not null
--   and a.owner like 'NINJA%'
--   and a.owner      = 'NINJADATA'
--   and a.table_name = 'BATCH_SOCS'
order by "BYTES" desc
;
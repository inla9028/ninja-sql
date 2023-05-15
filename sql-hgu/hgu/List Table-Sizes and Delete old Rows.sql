--
-- List the largest tables...
--
select a.owner, a.table_name, a.num_rows, a.avg_row_len
     ,        (a.num_rows * a.avg_row_len)                             AS "BYTES"
     , round(((a.num_rows * a.avg_row_len) / (1024 * 1024)), 1)        AS "MB"
     , round(((a.num_rows * a.avg_row_len) / (1024 * 1024 * 1024)), 1) AS "GB"
  from all_tables a
 where a.num_rows is not null
--   and a.owner  like 'NINJA%'
   and a.owner         = 'NINJADATA'
 --   and a.table_name LIKE 'ARC%'
order by "BYTES" desc
;

--
-- Investigate a certain table (needs to change for each individual table)
--
select /*+parallel(4) */ year, count(1) AS "COUNT"
  from (
select /*+parallel(4) */ TO_CHAR(a.enter_time, 'YYYY') AS "YEAR"
  from ARCH_MASTER_MEMO_TRANSACTIONS a
-- where 1 = 1
--   and rownum < 21
)
group by year
order by year
;

--
-- Delete and commit.
--
delete /*+parallel(4) */
  from ARCH_MASTER_MEMO_TRANSACTIONS a
-- where a.enter_time < trunc(SYSDATE, 'YEAR')
 where a.enter_time < to_date('2022-06-01', 'YYYY-MM-DD')
;

commit work;

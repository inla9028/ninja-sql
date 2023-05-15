select *
  from user_db_links
 where db_link = 'FOKUS'
;

drop database link FOKUS;

-- Old ST
create database link FOKUS
  connect to NTCNAPPS identified by "TELIA2019" using 'TEST7_ORG'
;

-- New UAT
--create database link FOKUS
--  connect to NTCNAPPS identified by "TELIA2019" using 'FTST01'
--;
create database link FOKUS
  connect to NTCTAPP10 identified by "NTCTAPP10" using 'FTST01'
;

-- New Pre-prod
create database link FOKUS
  connect to ntcappc_lng5 identified by "NTCAPPC_LNG5" using 'T01OL1'
;

-- Pre-prod test 2021-12-08
create database link FOKUS
  connect to ntcappc_lng5 identified by "NTCAPPC_LNG5" using 'E01OL1'
;


-- ST......:    84.987
-- UAT.....:    84.984
-- Pre-Prod: 7.723.922
select /*+ driving_site(a)*/ count(1) AS "COUNT"
  from subscriber@fokus a
;

select '1' from dual
;
select a.*
  from soc_illegal_comb@fokus a
;

select a.*
  from soc_illegal_comb@fokus a
;


SELECT RTRIM(sic.soc_first) AS "SOC_FIRST",
       RTRIM(sic.soc_second) AS "SOC_SECOND",
       RTRIM(soc1.soc_group) AS "GROUP_FIRST",
       RTRIM(soc2.soc_group) AS "GROUP_SECOND",
       sic.illegal_ind,
       sic.effective_date,
       NVL(sic.expiration_date, TO_DATE('4700-12-31','YYYY-MM-DD')) AS "EXPIRATION_DATE"
  FROM soc_illegal_comb@fokus sic, soc@fokus soc1, soc@fokus soc2
 WHERE RTRIM(sic.soc_first) = RTRIM(soc1.soc)
   AND RTRIM(sic.soc_second) = RTRIM(soc2.soc)
   AND SYSDATE BETWEEN soc1.effective_date AND NVL(soc1.expiration_date, SYSDATE + 1)
   AND SYSDATE BETWEEN soc2.effective_date AND NVL(soc2.expiration_date, SYSDATE + 1)
;

select *
from (
SELECT sic.illegal_ind,
       sic.effective_date,
       NVL(sic.expiration_date, TO_DATE('4700-12-31','YYYY-MM-DD')) AS "EXPIRATION_DATE"
     , count(1) as "COUNT"
  FROM soc_illegal_comb@fokus sic, soc@fokus soc1, soc@fokus soc2
 WHERE RTRIM(sic.soc_first) = RTRIM(soc1.soc)
   AND RTRIM(sic.soc_second) = RTRIM(soc2.soc)
   AND SYSDATE BETWEEN soc1.effective_date AND NVL(soc1.expiration_date, SYSDATE + 1)
   AND SYSDATE BETWEEN soc2.effective_date AND NVL(soc2.expiration_date, SYSDATE + 1)
group by sic.illegal_ind, sic.effective_date, NVL(sic.expiration_date, TO_DATE('4700-12-31','YYYY-MM-DD'))
order by sic.illegal_ind, sic.effective_date, NVL(sic.expiration_date, TO_DATE('4700-12-31','YYYY-MM-DD'))
)
where "COUNT" > 1
;


select sum("COUNT") "COUNT_COMB_ENTRY"
from (
SELECT sic.illegal_ind,
       sic.effective_date,
       NVL(sic.expiration_date, TO_DATE('4700-12-31','YYYY-MM-DD')) AS "EXPIRATION_DATE"
     , count(1) as "COUNT"
  FROM soc_illegal_comb@fokus sic, soc@fokus soc1, soc@fokus soc2
 WHERE RTRIM(sic.soc_first) = RTRIM(soc1.soc)
   AND RTRIM(sic.soc_second) = RTRIM(soc2.soc)
   AND SYSDATE BETWEEN soc1.effective_date AND NVL(soc1.expiration_date, SYSDATE + 1)
   AND SYSDATE BETWEEN soc2.effective_date AND NVL(soc2.expiration_date, SYSDATE + 1)
group by sic.illegal_ind, sic.effective_date, NVL(sic.expiration_date, TO_DATE('4700-12-31','YYYY-MM-DD'))
order by sic.illegal_ind, sic.effective_date, NVL(sic.expiration_date, TO_DATE('4700-12-31','YYYY-MM-DD'))
)
--where "COUNT" > 1
;
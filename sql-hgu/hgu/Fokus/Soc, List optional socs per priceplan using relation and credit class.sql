/*
** This query is used by Ninja in PPOptionalSocsReferenceTable
** which hosts "optional" socs per Fokus configuration.
*/
SELECT RTRIM (sr.soc_src)       AS "SOC_SRC",
       RTRIM (s.soc)            AS "SOC",
       RTRIM (s.soc_level_code) AS "SOC_LEVEL_CODE",
       RTRIM (s.soc_group)      AS "SOC_GROUP",
       s.effective_date,
       s.expiration_date
  FROM soc_relation sr, soc s, soc_credit_class scc
 WHERE s.soc                   = sr.soc_dest
   AND s.soc                   = scc.soc
   AND s.effective_date        = scc.effective_date
   AND scc.credit_class       >= 'X'
   AND s.service_type          = 'O'
   AND s.soc_status            = 'A'
   AND s.for_sale_ind          = 'Y'
   AND sr.relation_type        = 'O'
   AND TRUNC(SYSDATE)    BETWEEN s.effective_date AND NVL (s.expiration_date, TO_DATE ('31124700', 'DDMMYYYY'))
   AND sr.src_effective_date  <= TRUNC(SYSDATE)
   AND sr.dest_effective_date <= TRUNC(SYSDATE)
   AND NVL(sr.expiration_date, TRUNC(SYSDATE) + 1) >= TRUNC(SYSDATE)
ORDER BY sr.soc_src ASC, s.soc ASC, s.soc_level_code ASC
;

/*
** Same as above, using db-link.
*/
SELECT RTRIM (sr.soc_src)       AS "SOC_SRC",
       RTRIM (s.soc)            AS "SOC",
       RTRIM (s.soc_level_code) AS "SOC_LEVEL_CODE",
       RTRIM (s.soc_group)      AS "SOC_GROUP",
       s.effective_date,
       s.expiration_date
  FROM soc_relation@fokus sr, soc@fokus s, soc_credit_class@fokus scc
 WHERE s.soc                   = sr.soc_dest
   AND s.soc                   = scc.soc
   AND s.effective_date        = scc.effective_date
   AND scc.credit_class       >= 'X'
   AND s.service_type          = 'O'
   AND s.soc_status            = 'A'
   AND s.for_sale_ind          = 'Y'
   AND sr.relation_type        = 'O'
   AND TRUNC(SYSDATE)    BETWEEN s.effective_date AND NVL (s.expiration_date, TO_DATE ('31124700', 'DDMMYYYY'))
   AND sr.src_effective_date  <= TRUNC(SYSDATE)
   AND sr.dest_effective_date <= TRUNC(SYSDATE)
   AND NVL(sr.expiration_date, TRUNC(SYSDATE) + 1) >= TRUNC(SYSDATE)
   AND (RTRIM(sr.soc_src)) = 'PPUT' -- Filter...
ORDER BY sr.soc_src ASC, s.soc ASC, s.soc_level_code ASC
;



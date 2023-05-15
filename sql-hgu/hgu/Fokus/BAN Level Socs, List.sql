--==
--== List all known BAN level socs.
--==
SELECT /*+ driving_site(a)*/
       RTRIM(a.soc) AS "SOC", a.soc_description, a.soc_status, a.sale_eff_date 
     , a.sale_exp_date, a.customer_type, a.customer_subtype, a.for_sale_ind
     , a.promotion_ind
  FROM soc@fokus a
 WHERE a.soc_level_code != 'B' -- A = User, B = Ban
--  WHERE RTRIM(a.soc) IN ('PUMC', 'PUMD')
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1000)
--   AND RTRIM(a.soc) IN ('EPOSTSUPF')
ORDER BY 1
;

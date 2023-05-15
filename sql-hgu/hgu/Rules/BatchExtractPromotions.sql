--==
--== Display the entire content.
--==
SELECT a.base_soc, a.promotion_soc, a.priceplan_soc, a.effective_date,
       a.expiration_date, a.description
  FROM BATCH_EXTRACT_PROMOTIONS A;

--==
--== Display the effective rows content.
--==
SELECT a.base_soc, a.promotion_soc, a.priceplan_soc, a.effective_date,
       A.EXPIRATION_DATE, A.DESCRIPTION
  FROM BATCH_EXTRACT_PROMOTIONS A
 WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date;

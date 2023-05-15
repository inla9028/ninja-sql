SELECT RTRIM (a.soc) AS "PP_SOC",
       RTRIM (b.soc) AS "TB_SOC",
       COUNT (*)     AS "COUNT"
  FROM dd.service_agreement a, dd.service_agreement b
 WHERE RTRIM (b.soc)  IN ('MCTB1', 'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE')
   AND SYSDATE   BETWEEN b.effective_date
                     AND NVL (b.expiration_date, SYSDATE + 1)
   AND a.subscriber_no = b.subscriber_no
   AND a.ban           = b.ban
   AND a.service_type  = 'P'
   AND SYSDATE   BETWEEN a.effective_date
                     AND NVL(a.expiration_date, SYSDATE + 1)
GROUP BY RTRIM (a.soc), RTRIM (b.soc)
ORDER BY RTRIM (a.soc), RTRIM (b.soc);
/*ADVICE(16): This item has not been declared, or it refers to a label [131] */
/*ADVICE(16): This item has not been declared, or it refers to a label [131] */

-- Exec.time: 10891.693 s (From 14:38 to 17:40)

SELECT RTRIM(a.soc) AS "PP_SOC", RTRIM(b.soc) AS "TB_SOC", COUNT(*) AS "COUNT"
  FROM dd.service_agreement a, dd.service_agreement b
  WHERE a.service_type  = 'P'
    AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.subscriber_no = b.subscriber_no
    AND a.ban           = b.ban
    AND SYSDATE   BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
    AND RTRIM(b.soc)   IN ('MCTB1', 'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE')
GROUP BY RTRIM(a.soc), RTRIM(b.soc)
ORDER BY RTRIM(a.soc), RTRIM(b.soc)
;

/*
** List the actual subscribers with these socs.
*/

SELECT a.ban,
       a.subscriber_no
       RTRIM (a.soc) AS "PP_SOC",
       RTRIM (b.soc) AS "TB_SOC",
       b.effective_date,
       b.expiration_date
  FROM dd.service_agreement a, dd.service_agreement b
 WHERE RTRIM (b.soc)  IN ('MCTB1', 'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE')
   AND SYSDATE   BETWEEN b.effective_date
                     AND NVL (b.expiration_date, SYSDATE + 1)
   AND a.subscriber_no = b.subscriber_no
   AND a.ban           = b.ban
   AND a.service_type  = 'P'
   AND SYSDATE   BETWEEN a.effective_date
                     AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY a.ban. a.subscriber_no
;


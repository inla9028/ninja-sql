DELETE
  FROM tmp_msisdns_w_soc_soc_soc
;

/*

DROP TABLE tmp_msisdns_w_soc_soc_soc PURGE
;


CREATE TABLE tmp_msisdns_w_soc_soc_soc (
  subscriber_no VARCHAR2(20 CHAR) NOT NULL ENABLE, 
  ban           NUMBER(9,0) NOT NULL ENABLE, 
  sub_status    CHAR(1 CHAR) NOT NULL ENABLE, 
  soc1          VARCHAR2(9 CHAR), 
  eff_date1     DATE, 
  soc2          VARCHAR2(9 CHAR), 
  eff_date2     DATE, 
  soc3          VARCHAR2(9 CHAR), 
  eff_date3     DATE
)
;

*/

--
-- Pt.1: LOPTF1 + INSURLS1 / INSURLS2 + INSURLS1U / INSURLS2U / INSURLS2V
--
INSERT INTO tmp_msisdns_w_soc_soc_soc
SELECT s.subscriber_no
     , s.customer_id     AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc)     AS "SOC1"
     , a1.effective_date AS "EFF_DATE1"
     , RTRIM(a2.soc)     AS "SOC2"
     , a2.effective_date AS "EFF_DATE2"
     , RTRIM(a3.soc)     AS "SOC3"
     , a3.effective_date AS "EFF_DATE3"
  FROM subscriber s, service_agreement a1, service_agreement a2, service_agreement a3
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)    = 'LOPTF1'
   --
   AND s.customer_id    = a2.ban
   AND s.subscriber_no  = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)   IN ( 'INSURLS1', 'INSURLS2' )
   --
   AND s.customer_id    = a3.ban
   AND s.subscriber_no  = a3.subscriber_no
   AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
   AND a3.service_type  = 'Q'
   AND a3.soc        LIKE RTRIM(a2.soc) || '%'
--
--   AND ROWNUM < 11
;

COMMIT WORK;

--
-- Pt.2: LOPTF1 + INSURLS1 / INSURLS2 + No Promo
--
INSERT INTO tmp_msisdns_w_soc_soc_soc
SELECT s.subscriber_no
     , s.customer_id     AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc)     AS "SOC1"
     , a1.effective_date AS "EFF_DATE1"
     , RTRIM(a2.soc)     AS "SOC2"
     , a2.effective_date AS "EFF_DATE2"
     , NULL              AS "SOC3"
     , NULL              AS "EFF_DATE3"
  FROM subscriber s, service_agreement a1, service_agreement a2
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)    = 'LOPTF1'
   --
   AND s.customer_id    = a2.ban
   AND s.subscriber_no  = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)   IN ( 'INSURLS1', 'INSURLS2' )
   --
   AND 0                = (SELECT COUNT(1)
                             FROM service_agreement a3
                            WHERE a3.ban           = s.customer_id
                              AND a3.subscriber_no = s.subscriber_no
                              AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
                              AND a3.service_type  = 'Q'
                              AND a3.soc        LIKE RTRIM(a2.soc) || '%')
--
--   AND ROWNUM < 11
;

COMMIT WORK;

--
-- Pt.3: LOBTF1 + INSURLS3 + INSURLS3V
--
INSERT INTO tmp_msisdns_w_soc_soc_soc
SELECT s.subscriber_no
     , s.customer_id     AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc)     AS "SOC1"
     , a1.effective_date AS "EFF_DATE1"
     , RTRIM(a2.soc)     AS "SOC2"
     , a2.effective_date AS "EFF_DATE2"
     , RTRIM(a3.soc)     AS "SOC3"
     , a3.effective_date AS "EFF_DATE3"
  FROM subscriber s, service_agreement a1, service_agreement a2, service_agreement a3
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)     = 'LOBTF1'
   --
   AND s.customer_id    = a2.ban
   AND s.subscriber_no  = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)    = 'INSURLS3'
   --
   AND s.customer_id    = a3.ban
   AND s.subscriber_no  = a3.subscriber_no
   AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
   AND a3.service_type  = 'Q'
   AND a3.soc        LIKE RTRIM(a2.soc) || '%'
--
--   AND ROWNUM < 11
;

COMMIT WORK;

--
-- Pt.4: LOPTFREP1 + INSURLS2 + INSURLS2U
--
INSERT INTO tmp_msisdns_w_soc_soc_soc
SELECT s.subscriber_no
     , s.customer_id     AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc)     AS "SOC1"
     , a1.effective_date AS "EFF_DATE1"
     , RTRIM(a2.soc)     AS "SOC2"
     , a2.effective_date AS "EFF_DATE2"
     , RTRIM(a3.soc)     AS "SOC3"
     , a3.effective_date AS "EFF_DATE3"
  FROM subscriber s, service_agreement a1, service_agreement a2, service_agreement a3
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)    = 'LOPTFREP1'
   --
   AND s.customer_id    = a2.ban
   AND s.subscriber_no  = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)    = 'INSURLS2'
   --
   AND s.customer_id    = a3.ban
   AND s.subscriber_no  = a3.subscriber_no
   AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
   AND a3.service_type  = 'Q'
   AND a3.soc        LIKE RTRIM(a2.soc) || '%'
--
--   AND ROWNUM < 11
;

COMMIT WORK;

--
-- Pt.5: LOPTFREP1 + INSURLS2 / INSURLS3 + No Promo
--
INSERT INTO tmp_msisdns_w_soc_soc_soc
SELECT s.subscriber_no
     , s.customer_id     AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc)     AS "SOC1"
     , a1.effective_date AS "EFF_DATE1"
     , RTRIM(a2.soc)     AS "SOC2"
     , a2.effective_date AS "EFF_DATE2"
     , NULL              AS "SOC3"
     , NULL              AS "EFF_DATE3"
  FROM subscriber s, service_agreement a1, service_agreement a2
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)    = 'LOPTFREP1'
   --
   AND s.customer_id    = a2.ban
   AND s.subscriber_no  = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)   IN ( 'INSURLS2', 'INSURLS3' )
   --
   AND 0                = (SELECT COUNT(1)
                             FROM service_agreement a3
                            WHERE a3.ban           = s.customer_id
                              AND a3.subscriber_no = s.subscriber_no
                              AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
                              AND a3.service_type  = 'Q'
                              AND a3.soc        LIKE RTRIM(a2.soc) || '%')
--
--   AND ROWNUM < 11
;

COMMIT WORK;


SELECT a.soc1, a.sub_status, a.soc2, a.soc3, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_soc_soc_soc a
GROUP BY a.soc1, a.sub_status, a.soc2, a.soc3
ORDER BY a.soc1, a.sub_status, a.soc2, a.soc3
;

SELECT a.soc1, a.soc2, a.soc3, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_soc_soc_soc a
GROUP BY a.soc1, a.soc2, a.soc3
ORDER BY a.soc1, a.soc2, a.soc3
;


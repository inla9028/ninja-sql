SELECT a.ban, a.subscriber_no, a.soc, a.effective_date, a.expiration_date
  FROM service_agreement a
--  WHERE a.expiration_date BETWEEN SYSDATE - 30 AND SYSDATE
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.service_type    = 'R' -- 'P'riceplan Soc, 'R'egular Soc, 'N'=Promotion, 'G'=Leasing
    AND RTRIM(a.soc)      = 'MCTBFREE'
    AND a.subscriber_no  != '0000000000'
    AND ROWNUM           <= 20
  ORDER BY dbms_random.value();

SELECT a.ban, a.subscriber_no, a.soc AS "SOC A", a.effective_date AS "EFF_DATE_A", a.expiration_date AS "EXP_DATE_A",
       b.soc AS "SOC_B", b.effective_date AS "EFF_DATE_B", b.expiration_date AS "EXP_DATE_B"
  FROM service_agreement a, service_agreement b
--  WHERE a.expiration_date BETWEEN SYSDATE - 30 AND SYSDATE
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.service_type    = 'R' -- 'P'riceplan Soc, 'R'egular Soc
    AND RTRIM(a.soc)     IN ('MCTBFREE', 'MCTB1', 'MCTB2', 'MCTB3', 'MCTB4')
    AND a.subscriber_no  != '0000000000'
    AND a.subscriber_no  = b.subscriber_no
    AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
    AND RTRIM(b.soc)     IN ('PSBA', 'PSBB', 'PSBC', 'PSBD', 'PSBE')
    AND ROWNUM           <= 20
  ORDER BY dbms_random.value();
/*
GSM04748235154	MCTBFREE 	2008-09-29 00:00	4700-12-31 00:00	PSBA     
GSM04745506345	MCTBFREE 	2009-12-15 00:00	4700-12-31 00:00	PSBC     
GSM04790833483	MCTBFREE 	2006-01-12 00:00	4700-12-31 00:00	PSBC     
GSM04791794244	MCTBFREE 	2013-09-30 00:00	4700-12-31 00:00	PSBC     
GSM04795983052	MCTBFREE 	2011-09-26 00:00	4700-12-31 00:00	PSBC     
GSM04792081603	MCTBFREE 	2011-11-13 00:00	4700-12-31 00:00	PSBC     
GSM04740232470	MCTBFREE 	2012-03-02 00:00	4700-12-31 00:00	PSBC     
GSM04794828896	MCTBFREE 	2011-10-19 00:00	4700-12-31 00:00	PSBA     
GSM04741211755	MCTBFREE 	2012-04-24 00:00	4700-12-31 00:00	PSBC     
GSM04799512484	MCTBFREE 	2010-02-25 00:00	4700-12-31 00:00	PSBA     
GSM04791530374	MCTBFREE 	2011-01-24 00:00	4700-12-31 00:00	PSBC     
GSM04793218156	MCTBFREE 	2008-10-14 00:00	4700-12-31 00:00	PSBA     
GSM04740487602	MCTBFREE 	2012-08-20 00:00	4700-12-31 00:00	PSBC     
GSM04791102150	MCTBFREE 	2006-05-03 00:00	4700-12-31 00:00	PSBA     
GSM04793477380	MCTBFREE 	2012-04-24 00:00	4700-12-31 00:00	PSBC     
GSM04745396196	MCTBFREE 	2008-10-02 00:00	4700-12-31 00:00	PSBC     
GSM04792235990	MCTBFREE 	2008-09-17 00:00	4700-12-31 00:00	PSBA     
GSM04740724421	MCTBFREE 	2012-11-12 00:00	4700-12-31 00:00	PSBA     
GSM04793217018	MCTBFREE 	2012-04-24 00:00	4700-12-31 00:00	PSBC     
GSM04792077328	MCTBFREE 	2011-02-03 00:00	4700-12-31 00:00	PSBB     
*/

SELECT a.ban, a.subscriber_no, a.soc, a.effective_date, a.expiration_date
  FROM service_agreement a
--  WHERE a.expiration_date BETWEEN SYSDATE - 30 AND SYSDATE
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.service_type    = 'P' -- 'P'riceplan Soc, 'R'egular Soc, 'N'=Promotion, 'G'=Leasing
    AND a.subscriber_no  IN (
        'GSM04791794244', 'GSM04740232470', 'GSM04793477380', 'GSM04740553025',
        'GSM04790833483', 'GSM04741211755', 'GSM04792077328', 'GSM04794828896',
        'GSM04792235990', 'GSM04791327773', 'GSM04740550020', 'GSM04740487602',
        'GSM04793404615', 'GSM04793252463', 'GSM04740724421', 'GSM04793026294',
        'GSM04746622224'
    )
order by a.soc, a.subscriber_no
;

SELECT a.ban, a.subscriber_no, RTRIM(a.soc) AS "SOC", a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, a.act_reason_code
  FROM service_agreement a
--  WHERE a.ban = 705660017
  WHERE a.subscriber_no IN ('GSM047' || '91794244')
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2010-11-17', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2012-01-23', 'YYYY-MM-DD') < a.effective_date
--    AND a.service_type = 'P'
  ORDER BY a.subscriber_no, a.ban, a.campaign desc, a.soc
--  order by A.EFFECTIVE_DATE, A.EXPIRATION_DATE
;

SELECT a.ban, a.subscriber_no, a.soc, a.operator_id, a.application_id,
       a.campaign, a.feature_code, a.service_type, a.ftr_effective_date,
       a.ftr_expiration_date, a.ftr_add_sw_prm
  FROM service_feature a
 WHERE a.subscriber_no IN ('GSM047' || '91794244')
--   AND */a.ban = 113672505 AND a.subscriber_no = '0000000000'
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--   AND TO_DATE('2008-10-01', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--   AND a.service_type = 'P'
--   AND RTRIM(a.soc) IN ('TSIMA', 'TSIMB', 'TWINCON')
   AND RTRIM(a.soc) LIKE 'MCTB%'
ORDER BY a.subscriber_no, a.ban, a.campaign, a.service_type, a.soc, a.feature_code, a.ftr_effective_date
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List 10 subscribers with the specified priceplan.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT /*+ driving_site(a)*/ a.ban, a.subscriber_no, a.soc, a.effective_date, a.expiration_date
  FROM service_agreement@fokus a
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
--    AND a.service_type    = 'R' -- 'P'riceplan Soc, 'R'egular Soc
    AND RTRIM(a.soc)     IN ('PPEN')
--    AND a.subscriber_no  != '0000000000'
    AND ROWNUM           <= 11
--  ORDER BY dbms_random.value()
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List 10 subscribers with the specified priceplan, also print the account-
--== type and account sub type.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.effective_date, b.account_type, b.account_sub_type
  FROM service_agreement a, billing_account b
  WHERE a.expiration_date > SYSDATE
    AND a.service_type    = 'P' -- 'P'riceplan Soc, 'R'egular Soc
    AND RTRIM(a.soc)     IN ('PSFB')
    AND a.subscriber_no  != '0000000000'
    AND a.ban             = b.ban
    AND b.account_type    = 'B'
    AND b.account_sub_type= 'R'
    AND ROWNUM           <= 10
  ORDER BY dbms_random.value();



--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List subscribers with the specified soc(s).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.effective_date, a.expiration_date
  FROM service_agreement a
--  WHERE a.expiration_date BETWEEN SYSDATE - 30 AND SYSDATE
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.service_type    = 'R' -- 'P'riceplan Soc, 'R'egular Soc, 'N'=Promotion, 'G'=Leasing
    AND RTRIM(a.soc)     IN ('MCTBFREE', 'MCBT1', 'MCBT2', 'MCBT3', 'MCBT4')
    AND a.subscriber_no  != '0000000000'
    AND ROWNUM           <= 20
  ORDER BY dbms_random.value();



--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List subscribers a combination of two sets of socs.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc AS "SOC A", a.effective_date AS "EFF_DATE_A", a.expiration_date AS "EXP_DATE_A",
       b.soc AS "SOC_B", b.effective_date AS "EFF_DATE_B", b.expiration_date AS "EXP_DATE_B"
  FROM service_agreement a, service_agreement b
--  WHERE a.expiration_date BETWEEN SYSDATE - 30 AND SYSDATE
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.service_type    = 'R' -- 'P'riceplan Soc, 'R'egular Soc
    AND RTRIM(a.soc)     IN ('MCTBFREE', 'MCBT1', 'MCBT2', 'MCBT3', 'MCBT4')
    AND a.subscriber_no  != '0000000000'
    AND a.subscriber_no  = b.subscriber_no
    AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
    AND RTRIM(b.soc)     IN ('TWINCON')
    AND ROWNUM           <= 20
  ORDER BY dbms_random.value();

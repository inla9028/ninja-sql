/*
CON10 -> CON10P
CON17 -> CON17P
CON19 -> CON19P
*/
SELECT pp.subscriber_no, base.effective_date, 'CON10P' AS "PROMO_SOC"
  FROM service_agreement pp, service_agreement base
  WHERE RTRIM(base.soc)      = 'CON10'
    AND base.expiration_date > SYSDATE
    AND base.effective_date BETWEEN TO_DATE('2009-12-07', 'YYYY-MM-DD') AND TO_DATE('2010-02-03', 'YYYY-MM-DD')
    AND pp.ban               = base.ban
    AND pp.subscriber_no     = base.subscriber_no
    AND RTRIM(pp.soc)       IN ('PSDS')
    AND NOT EXISTS (
      SELECT 1
        FROM service_agreement promo
        WHERE promo.ban           = base.ban
          AND promo.subscriber_no = base.subscriber_no
          AND RTRIM(promo.soc)    = 'CON10P'
    )
/

SELECT pp.subscriber_no, base.effective_date, 'CON17P' AS "PROMO_SOC"
  FROM service_agreement pp, service_agreement base
  WHERE RTRIM(base.soc)      = 'CON17'
    AND base.expiration_date > SYSDATE
    AND base.effective_date BETWEEN TO_DATE('2009-12-07', 'YYYY-MM-DD') AND TO_DATE('2010-02-03', 'YYYY-MM-DD')
    AND pp.ban               = base.ban
    AND pp.subscriber_no     = base.subscriber_no
    AND RTRIM(pp.soc)       IN ('PSCJ')
    AND NOT EXISTS (
      SELECT 1
        FROM service_agreement promo
        WHERE promo.ban           = base.ban
          AND promo.subscriber_no = base.subscriber_no
          AND RTRIM(promo.soc)    = 'CON17P'
    )
/

SELECT pp.subscriber_no, base.effective_date, 'CON19P' AS "PROMO_SOC"
  FROM service_agreement pp, service_agreement base
  WHERE RTRIM(base.soc)      = 'CON19'
    AND base.expiration_date > SYSDATE
    AND base.effective_date BETWEEN TO_DATE('2009-12-07', 'YYYY-MM-DD') AND TO_DATE('2010-02-03', 'YYYY-MM-DD')
    AND pp.ban               = base.ban
    AND pp.subscriber_no     = base.subscriber_no
    AND RTRIM(pp.soc)       IN ('PSCL')
    AND NOT EXISTS (
      SELECT 1
        FROM service_agreement promo
        WHERE promo.ban           = base.ban
          AND promo.subscriber_no = base.subscriber_no
          AND RTRIM(promo.soc)    = 'CON19P'
    )
/



SELECT a.msisdn, a.dato, a.created_by, a.modified_by, a.created_date,
       a.modified_date, a.type, a.sms_text
  FROM kontroll.gsm_bestilling@NETWEB a
  WHERE a.msisdn = '4746427642'

--==
SELECT a.type, COUNT(*) AS "COUNT"
  FROM kontroll.gsm_bestilling@NETWEB a
  GROUP BY a.type


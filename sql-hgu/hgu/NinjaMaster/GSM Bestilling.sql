--== Get the (entire) content of GSM Bestilling...
SELECT a.msisdn, a.dato, a.created_by, a.created_date, a.modified_by,
       a.modified_date, a.type, a.sms_text 
  FROM gsm_bestilling a
  ORDER BY a.created_date, a.modified_date

--== Type --== Explained --==--==--==--==--==--==--==--==--==--==--==--==--==--=
--==  2        Forbruk
--== 33        HomeRun  
--== 35        SMS Pluss
--== 36        Trilling SIM
--== 41        DataMania
--== 42        Trådløs Familie
--== 43        Kontant (PKOT)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--== Prod
SELECT a.msisdn, a.dato, a.created_by, a.created_date, a.modified_by,
       a.modified_date, a.type, a.sms_text 
  FROM gsm_bestilling a
  WHERE a.TYPE IN (2, 33, 35, 36, 41, 42, 43)
  ORDER BY a.created_date, a.modified_date

--== Test
SELECT a.msisdn, a.dato, a.created_by, a.created_date, a.modified_by,
       a.modified_date, a.type, a.sms_text 
  FROM gsm_bestilling_test a
  WHERE a.TYPE IN (2, 33, 35, 36, 41, 42, 43)
  ORDER BY a.created_date, a.modified_date

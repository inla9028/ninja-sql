INSERT INTO spm_priceplan_mapping (service_provider_code, sp_priceplan_code, soc_code, effective_date, expiration_date, comments)
VALUES ('Chilimobil','VOICE_2022','PVJK',TO_DATE('2022-02-08', 'YYYY-MM-DD'),NULL,'Håkan: Added PVJK as VOICE_2022.');

COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
 WHERE a.service_provider_code = 'Chilimobil'
ORDER BY 1,3,2
;

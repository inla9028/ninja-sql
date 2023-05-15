/*
** Replace:
** NewCo   - The code of the service provider
** VOICE   - The code of the priceplan
** PW20    - The Fokus SOC of the priceplan
*/
--INSERT INTO spm_priceplan_mapping 
--VALUES('NewCo','VOICE','PW20',NULL,NULL,'Håkan: Added PW20 as VOICE.');

--INSERT INTO spm_priceplan_mapping 
--VALUES('NewCo','FWA','PW21',TO_DATE('2020-01-27', 'YYYY-MM-DD'),NULL,'Håkan: Added PW21 as FWA.');

INSERT INTO spm_priceplan_mapping 
VALUES('NewCo','FWA_B2B','PW22',TO_DATE('2020-06-02', 'YYYY-MM-DD'),NULL,'Håkan: Added PW22 as FWA_B2B.');

COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
-- WHERE a.service_provider_code = 'NewCo'
ORDER BY 1,3,2
;


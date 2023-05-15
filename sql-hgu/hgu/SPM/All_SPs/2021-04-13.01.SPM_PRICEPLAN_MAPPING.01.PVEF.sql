/*
** Replace:
** SP_CODE   - The code of the service provider
** VOICE     - The code of the priceplan
** PP_SOC    - The Fokus SOC of the priceplan
*/
INSERT INTO spm_priceplan_mapping
VALUES('Telio','MBB_2021','PVEF',NULL,NULL,'Håkan: Added PVEF as MBB_2021.');

COMMIT WORK;

SELECT A.*
  FROM spm_priceplan_mapping A
 WHERE A.service_provider_code = 'Telio'
ORDER BY 1,2
;

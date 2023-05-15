/*
** Replace:
** SP_CODE   - The code of the service provider
** VOICE     - The code of the priceplan
** PP_SOC    - The Fokus SOC of the priceplan
*/
INSERT INTO spm_priceplan_mapping 
VALUES('SP_CODE','VOICE','PP_SOC',NULL,NULL,'Håkan: Added PP_SOC as VOICE.');

COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
ORDER BY 1,2
;


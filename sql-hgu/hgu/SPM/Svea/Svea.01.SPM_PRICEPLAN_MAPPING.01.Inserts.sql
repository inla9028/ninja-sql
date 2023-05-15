/*
** Replace:
** SP_CODE   - The code of the service provider
** VOICE     - The code of the priceplan
** PP_SOC    - The Fokus SOC of the priceplan
*/
INSERT INTO spm_priceplan_mapping 
VALUES('Svea','VOICE','PVSA',NULL,NULL,'Håkan: Added PVSA as VOICE.');

INSERT INTO spm_priceplan_mapping 
VALUES('Svea','MBB','PVSB',NULL,NULL,'Håkan: Added PVSB as MBB.');

COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
ORDER BY 1,2
;


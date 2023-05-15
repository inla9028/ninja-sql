/*
** Replace:
** SP_CODE   - The code of the service provider
** VOICE     - The code of the priceplan
** PP_SOC    - The Fokus SOC of the priceplan
*/
--INSERT INTO spm_priceplan_mapping 
--VALUES('Intility','MBB','PVIC',TRUNC(SYSDATE),TO_DATE('4100-12-31', 'YYYY-MM-DD'),'Håkan: Added PVIC (SP Intility MBB) as MBB.');

--INSERT INTO spm_priceplan_mapping 
--VALUES('Intility','DATA','PVID',TRUNC(SYSDATE),TO_DATE('4100-12-31', 'YYYY-MM-DD'),'Håkan: Added PVID (SP Intility General Data) as DATA.');

INSERT INTO spm_priceplan_mapping 
VALUES('Intility','VOICE','PVKA',trunc(SYSDATE),to_date('4100-12-31', 'YYYY-MM-DD'),'Håkan: Added PVKA (Videreselger Intility) as VOICE.');


COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
 WHERE a.service_provider_code = 'Intility'
ORDER BY 1,2
;


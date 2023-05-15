/*
** Replace:
** SP_CODE   - The code of the service provider
** VOICE     - The code of the priceplan
** PP_SOC    - The Fokus SOC of the priceplan
*/
INSERT INTO spm_priceplan_mapping 
VALUES('Telio','TELIO_MBB','PVEC',TRUNC(SYSDATE),TO_DATE('4100-12-31', 'YYYY-MM-DD'),'Håkan: Added PVEC (Bredbånd Telio Telecom) as TELIO_MBB.');

INSERT INTO spm_priceplan_mapping 
VALUES('Telio','NGT_VOICE','PVEE',TRUNC(SYSDATE),TO_DATE('4100-12-31', 'YYYY-MM-DD'),'Håkan: Added PVEE (Videreselger NextGenTel) as NGT_VOICE.');

INSERT INTO spm_priceplan_mapping 
VALUES('Telio','FWA','PW30',TRUNC(SYSDATE),TO_DATE('4100-12-31', 'YYYY-MM-DD'),'Håkan: Added PW30 (Proximo Fixed Wireless Access) as FWA.');

COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
ORDER BY 1,2
;


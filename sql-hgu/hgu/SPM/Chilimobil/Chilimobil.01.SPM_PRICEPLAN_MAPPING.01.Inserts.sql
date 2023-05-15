--INSERT INTO spm_priceplan_mapping 
--VALUES('Chilimobil','VOICE','PVJA',NULL,NULL,'Håkan: Added PVJA as VOICE.');


INSERT INTO spm_priceplan_mapping 
--VALUES('Chilimobil','VOICE_FD','PVJB',NULL,NULL,'Håkan: Added PVJB as VOICE_FD.');
VALUES('Chilimobil','VOICE_FD','PVJB',TO_DATE('2020-06-02', 'YYYY-MM-DD'),NULL,'Håkan: Added PVJB as VOICE_FD.');


--INSERT INTO spm_priceplan_mapping 
--VALUES('Chilimobil','MBB','PVJC',NULL,NULL,'Håkan: Added PVJC as MBB.');


--INSERT INTO spm_priceplan_mapping 
--VALUES('Chilimobil','PREPAID_A','PVJD',NULL,NULL,'Håkan: Added PVJD as PREPAID_A.');


--INSERT INTO spm_priceplan_mapping 
--VALUES('Chilimobil','PREPAID_B','PVJE',NULL,NULL,'Håkan: Added PVJE as PREPAID_B.');


COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
 WHERE a.service_provider_code = 'Chilimobil'
ORDER BY 1,3,2
;


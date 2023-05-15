INSERT INTO spm_priceplan_mapping 
VALUES('Telavox','VOICE','PVGA',NULL,NULL,'Håkan: Added PVGA as VOICE.');

INSERT INTO spm_priceplan_mapping 
VALUES('Telavox','MBB','PVGC',NULL,NULL,'Håkan: Added PVGC as MBB.');


COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping a
ORDER BY 1,2
;


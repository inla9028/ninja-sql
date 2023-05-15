INSERT INTO spm_priceplan_mapping 
VALUES('PhoneroSIP','SIP','PW11',NULL,NULL,'Håkan: Added PW11 as SIP.');

COMMIT WORK;

SELECT a.*
  FROM spm_priceplan_mapping A
 WHERE SYSDATE BETWEEN A.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
ORDER BY 1,3,2
;


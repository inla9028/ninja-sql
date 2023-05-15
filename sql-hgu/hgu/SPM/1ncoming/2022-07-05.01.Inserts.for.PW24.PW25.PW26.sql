SELECT a.*
  FROM spm_priceplan_mapping a
 WHERE a.service_provider_code = 'NewCo'
ORDER BY 1,3
;

INSERT INTO SPM_PRICEPLAN_MAPPING (SERVICE_PROVIDER_CODE,SP_PRICEPLAN_CODE,SOC_CODE,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS)
VALUES ('NewCo','MBB','PW24',TRUNC(SYSDATE),TO_DATE('4700-12-31','YYYY-MM-DD'),'Håkan: Added PW24 as MBB.');

INSERT INTO SPM_PRICEPLAN_MAPPING (SERVICE_PROVIDER_CODE,SP_PRICEPLAN_CODE,SOC_CODE,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS)
VALUES ('NewCo','M2M_NO_VOICE','PW25',TRUNC(SYSDATE),TO_DATE('4700-12-31','YYYY-MM-DD'),'Håkan: Added PW25 as M2M_NO_VOICE.');

INSERT INTO SPM_PRICEPLAN_MAPPING (SERVICE_PROVIDER_CODE,SP_PRICEPLAN_CODE,SOC_CODE,EFFECTIVE_DATE,EXPIRATION_DATE,COMMENTS)
VALUES ('NewCo','M2M_VOICE','PW26',TRUNC(SYSDATE),TO_DATE('4700-12-31','YYYY-MM-DD'),'Håkan: Added PW26 as M2M_VOICE.');

-- Check if NCT has configured parameters for the priceplans.... 
SELECT a.*
  FROM feature_parameters a
 WHERE a.soc IN ( 'PW24', 'PW25', 'PW26' )
ORDER BY 1,2,3,4
;

-- Check if we need cancel/resume... Nope!

-- Check if the priceplans are configured for channels, and which ones.
SELECT a.subscription_type_id, a.channel_code, COUNT(1) AS "COUNT"
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id IN ( 'PW24REG1', 'PW25REG1', 'PW26REG1' )
   AND SYSDATE           BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
GROUP BY a.subscription_type_id, a.channel_code
ORDER BY a.subscription_type_id, a.channel_code
;
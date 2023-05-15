SELECT UNIQUE
       sp.sp_service_code AS "SP_CODE"
     , spm.sp_code        AS "SPM_CODE"
  FROM spm_service_mapping     spm
     , sp_services_mapping     sp
     , socs                    s
     , subscription_types_socs sts
 WHERE SYSDATE             BETWEEN spm.effective_date AND NVL(spm.expiration_date, SYSDATE + 1)
   AND spm.soc_type              = sp.soc_type
   AND spm.soc_group             = sp.soc_group
   AND s.soc_type                = sp.soc_type
   AND s.soc_group               = sp.soc_group
   AND s.soc                     = sts.soc
   AND SYSDATE             BETWEEN sts.effective_date AND NVL(sts.expiration_date, SYSDATE + 1)
   AND sts.add_mode              = 'O'
   AND sts.subscription_type_id IN (SELECT p.soc_code || 'REG1'
                                      FROM spm_priceplan_mapping p
                                     WHERE p.service_provider_code = 'Telio'
                                       AND SYSDATE BETWEEN p.effective_date AND NVL(p.expiration_date, SYSDATE + 1))
ORDER BY 1,2
;

/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, COUNT(1) AS "COUNT"
  FROM spm_service_mapping a, socs s
 WHERE a.sp_code  LIKE 'VOICEMAIL%'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.soc_type    = s.soc_type
   AND a.soc_group   = s.soc_group
GROUP BY a.sp_code, a.soc_type, a.soc_group
ORDER BY 1,2,3
;

/*
** Voicemail MINI
*/
DELETE
  FROM spm_service_mapping a
 WHERE a.soc_type  = 'VOICEMAIL'
   AND a.soc_group = 'VMMINI'
;

/*
** Old Voicemail, not to be added, but still lingering...?
*/
--DELETE
SELECT a.*
  FROM spm_service_mapping a
 WHERE a.soc_type  = 'VOICEMAIL'
   AND a.soc_group = 'VMS'
--   AND 
;

/*
** List after...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, COUNT(1) AS "COUNT"
  FROM spm_service_mapping a, socs s
 WHERE a.sp_code  LIKE 'VOICEMAIL%'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.soc_type    = s.soc_type
   AND a.soc_group   = s.soc_group
GROUP BY a.sp_code, a.soc_type, a.soc_group
ORDER BY 1,2,3
;


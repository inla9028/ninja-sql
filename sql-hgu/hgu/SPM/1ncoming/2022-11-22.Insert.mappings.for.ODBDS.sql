/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
 WHERE a.soc_type = 'ODB'
ORDER BY 2,3,1
;

INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('BAR_DUAL_STACK_IPV4_IPV6','ODB','ODBDS',TRUNC(SYSDATE),TO_DATE('4700-12-31','YYYY-MM-DD'), 'Barring of IPv4 and IPv6 dual stack  ');

SELECT r.*
  FROM soc_action_rules r
 WHERE r.group_id IN ( 'VMACC02_DELETE_MBNU01' )
--   AND SYSDATE BETWEEN r.effective_date AND NVL(r.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

UPDATE soc_action_rules r
   SET r.expiration_date = TRUNC(SYSDATE)
 WHERE r.group_id IN ( 'VMACC02_DELETE_MBNU01' )
   AND SYSDATE BETWEEN r.effective_date AND NVL(r.expiration_date, SYSDATE + 1)
;

UPDATE soc_action_rules r
   SET r.expiration_date = TO_DATE('4700-12-31', 'YYYY-MM-DD')
 WHERE r.group_id IN ( 'VMACC02_DELETE_MBNU01' )
   AND r.expiration_date = TRUNC(SYSDATE)
;




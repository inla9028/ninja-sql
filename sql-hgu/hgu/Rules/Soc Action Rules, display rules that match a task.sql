/*
** Display a flat view of the rules that triggers the processing of a soc or type or group..
*/
SELECT r.group_id, r.soc, r.soc_type, r.soc_group, r.condition, r.effective_date,
       r.expiration_date, r.task_id, t.process_order, t.process_action,
       t.soc, t.soc_type, t.soc_group, t.exception_text
  FROM soc_action_rules r, soc_action_tasks t
 WHERE 1 = 1
   AND r.task_id        = t.task_id
--   AND t.soc            IN ( 'VMMINI' )
   AND t.soc_type       IN ( 'VOICEMAIL' )
   AND t.soc_group      IN ( 'VMMINI' )
   AND t.process_action IN ( 'add' )
   AND SYSDATE BETWEEN r.effective_date AND r.expiration_date
--   AND TO_DATE('2015-05-01', 'YYYY-MM-DD') BETWEEN r.effective_date AND r.expiration_date
   AND SYSDATE BETWEEN t.effective_date AND t.expiration_date
--   AND TO_DATE('2015-05-01', 'YYYY-MM-DD') BETWEEN t.effective_date AND t.expiration_date
ORDER BY r.group_id, r.condition, r.soc, r.soc_type, r.soc_group, r.task_id, t.process_order
;

--==
--== Display the rules that causes a soc (or soc of type and group) to be handled.
--==
SELECT   a.group_id, a.soc, a.condition, a.task_id, a.effective_date,
         a.expiration_date, a.soc_type, a.soc_group
    FROM soc_action_rules a, soc_action_tasks b
   WHERE b.process_action IN ( 'add', 'delete' )
     AND (b.soc_type = 'GPRS' AND b.soc_group IN ( 'BASIC_NEW', 'REGULAR' ))
--     AND (b.soc IN ( 'CON21', 'MPODPRE01' ) OR (b.soc_type = 'GPRS' AND b.soc_group IN ( 'BASIC_NEW', 'REGULAR' )))
--     AND (b.soc           = 'CON01P' OR (b.soc_type = 'PROMO' AND b.soc_group = 'CON01P'))
     AND b.task_id        = a.task_id
     AND a.soc            = 'PPUC'
     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
--     AND TO_DATE('2010-05-10', 'YYYY-MM-DD') BETWEEN a.effective_date AND a.expiration_date
ORDER BY a.group_id, a.task_id, a.soc, a.soc_type, a.soc_group;

--==
--== Display all rules of the specified groups.
--==
SELECT   a.group_id, a.soc, a.condition, a.task_id, a.effective_date,
         a.expiration_date, a.soc_type, a.soc_group
    FROM soc_action_rules a
   WHERE a.group_id IN ('MBNx_IMS01_ADD')
     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
--     AND TO_DATE('2010-05-10', 'YYYY-MM-DD') BETWEEN a.effective_date AND a.expiration_date
ORDER BY a.group_id, a.task_id, a.soc, a.soc_type, a.soc_group;

--==
--== Display all tasks of the specified groups.
--==
SELECT   a.task_id, a.process_order, a.process_action, a.soc, a.soc_type,
         a.soc_group, a.exception_text, a.effective_date, a.expiration_date
    FROM soc_action_tasks a
   WHERE a.task_id IN ( 9 )
     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
--     AND TO_DATE('2010-05-10', 'YYYY-MM-DD') BETWEEN a.effective_date AND a.expiration_date
ORDER BY a.task_id, a.process_order;



 

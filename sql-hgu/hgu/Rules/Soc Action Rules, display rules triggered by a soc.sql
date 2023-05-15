--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Select all rules that are triggered on one or more socs.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.group_id, a.soc, a.condition, a.task_id, a.effective_date,
         a.expiration_date, a.soc_type, a.soc_group
    FROM soc_action_rules a
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.group_id IN (
            SELECT DISTINCT b.group_id
                       FROM soc_action_rules b
                      WHERE b.soc IN ('PKOU')
                        AND SYSDATE BETWEEN b.effective_date AND b.expiration_date)
ORDER BY a.task_id, a.group_id, a.condition,  a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Select all tasks that are triggered on one or more socs.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.task_id, a.process_order, a.process_action, a.soc, a.effective_date, 
         a.expiration_date, a.soc_type, a.soc_group, a.exception_text
    FROM soc_action_tasks a
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.task_id IN (
            SELECT DISTINCT b.task_id
                       FROM soc_action_rules b
                      WHERE SYSDATE BETWEEN b.effective_date AND b.expiration_date
                        AND b.group_id IN (
                               SELECT DISTINCT c.group_id
                                          FROM soc_action_rules c
                                         WHERE c.soc IN ('VO2MMS')
                                           AND SYSDATE BETWEEN c.effective_date AND c.expiration_date))
ORDER BY a.task_id, a.process_order;


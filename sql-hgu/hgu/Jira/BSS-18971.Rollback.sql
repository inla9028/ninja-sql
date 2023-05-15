/*
** 1. Delete the tasks to perform.
*/
DELETE FROM soc_action_tasks
      WHERE task_id = 47
;

/*
** 2. Delete the rules that invoke the defined tasks.
*/
DELETE FROM soc_action_rules
      WHERE group_id LIKE 'WDFPRE_PK__'
        AND task_id     = 47
;

-- Scripts to test...
/*
SELECT   a.*
    FROM soc_action_rules a
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.task_id = 47
ORDER BY a.task_id, a.group_id, a.condition,  a.soc;

SELECT   a.*
    FROM soc_action_tasks a
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.task_id = 47
ORDER BY a.task_id, a.process_order;
*/

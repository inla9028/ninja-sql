/*
** 1. Insert the tasks to perform.
*/
INSERT INTO soc_action_tasks
SELECT 48    AS "TASK_ID",
       1     AS "PROCESS_ORDER",
       'add' AS "PROCESS_ACTION",
       NULL  AS "SOC",
       TRUNC(SYSDATE) - 1 AS "EFFECTIVE_DATE",
       TO_DATE('4700-12-31', 'YYYY-MM-DD') AS "EXPIRATION_DATE",
       'MMS' AS "SOC_TYPE",
       'DUMMY' AS "SOC_GROUP",
       NULL AS "EXCEPTION_TEXT"
  FROM DUAL
 WHERE 1 = 1
;

/*
** 2a. Insert the rules that invoke the defined tasks.
*/
INSERT INTO soc_action_rules
SELECT 'MMS_' || SUBSTR(a.subscription_type_id, 0, 4) AS "GROUP_ID",
       SUBSTR(a.subscription_type_id, 0, 4) AS "SOC",
       'exists_or_added_not_deleted' AS "CONDITION",
       48 AS "TASK_ID", -- Manually entered. Previous max value is 46.
       TRUNC(SYSDATE) - 1 AS "EFFECTIVE_DATE",
       TO_DATE('4700-12-31', 'YYYY-MM-DD') AS "EXPIRATION_DATE",
       NULL AS "SOC_TYPE",
       NULL AS "SOC_GROUP"
  FROM subscription_types_socs a
 WHERE a.subscription_type_id LIKE 'PK__REG1'
   AND a.soc = 'WDFPRE'
   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
ORDER BY a.subscription_type_id
;

/*
** 2b. Insert the rules that invoke the defined tasks.
*/
INSERT INTO soc_action_rules
SELECT 'MMS_' || SUBSTR(a.subscription_type_id, 0, 4) AS "GROUP_ID",
       NULL AS "SOC",
       'not_exist_nor_added_or_deleted' AS "CONDITION",
       48 AS "TASK_ID", -- Manually entered. Previous max value is 47.
       TRUNC(SYSDATE) - 1 AS "EFFECTIVE_DATE",
       TO_DATE('4700-12-31', 'YYYY-MM-DD') AS "EXPIRATION_DATE",
       'MMS' AS "SOC_TYPE",
       NULL AS "SOC_GROUP"
  FROM subscription_types_socs a
 WHERE a.subscription_type_id LIKE 'PK__REG1'
   AND a.soc = 'WDFPRE'
   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
ORDER BY a.subscription_type_id
;

-- Scripts to test...
/*
SELECT   a.*
    FROM soc_action_rules a
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.task_id = 48
ORDER BY a.task_id, a.group_id, a.condition,  a.soc;

SELECT   a.*
    FROM soc_action_tasks a
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.task_id = 48
ORDER BY a.task_id, a.process_order;
*/

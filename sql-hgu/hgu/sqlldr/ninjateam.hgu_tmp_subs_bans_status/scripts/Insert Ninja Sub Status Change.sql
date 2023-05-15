SELECT /*+ driving_site(a)*/
       a.subscriber_no, a.customer_id, a.sub_status, a.sub_status_date
     , a.operator_id, u.user_full_name, a.dealer_code, a.sales_agent
     , a.subscriber_id, RTRIM(a.publish_level) AS "PUBLISH_LEVEL"
 FROM subscriber@fokus a, users@fokus u
WHERE a.subscriber_no IN (SELECT t.subscriber_no FROM NINJATEAM.HGU_TMP_SUBS_BANS_STATUS t WHERE t.sub_status = 'C')
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.operator_id   = u.user_id(+)
;

INSERT INTO NINJA_SUB_CHANGE_STATUS
SELECT NULL AS "TRANS_NUMBER"
     , t.subscriber_no
     , 'RESUME'         AS "ACTION_CODE"
     , t.dealer_code
     , 'Resuming failed during NP MOVE due to Tuxedo Upgrade' AS "MEMO_TEXT"
     , 'PR'             AS "REASON_CODE"
     , NULL             AS "FEE_WAIVER_CODE"
     , NULL             AS "ENTER_TIME"
     , NULL             AS "REQUEST_TIME"
     , 1                AS "PRIORITY"
     , NULL             AS "PROCESS_TIME"
     , 'WAITING'        AS "PROCESS_STATUS"
     , NULL             AS "STATUS_DESC"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_REFERENCE_ID"
     , 'N'              AS "RELEASE_CTN"
     , 'N'              AS "PREPAID_USER"
     , NULL             AS "HLR_STREAM"
     , 'C'              AS "CURRENT_STATUS"
  FROM ninjateam.hgu_tmp_subs_bans_status t
 WHERE t.sub_status = 'C'
;
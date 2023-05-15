/*
** Populate the renamed subscriptions using the correct target priceplan.
*/
SELECT UNIQUE n.subscriber_no AS "SUBSCRIBER_NO"
     , NULL            AS "NEW_BAN"
     , DECODE(RTRIM(sa.soc)
            , 'PVHG', 'PKOA'
            , 'PVHR', 'PKOB'
            , RTRIM(sa.soc))   AS "NEW_PRICEPLAN"
     , '000000000'     AS "NEW_CAMPAIGN_CODE"
     , 'K'             AS "HANDLE_COMMITMENT"
     , 'NET'           AS "DEALER"
     , 'A'             AS "SALES_AGENT"
     , 'KON1'          AS "REASON_CODE"
     , 'Chess Migration: Moving unregistered prepaid from Chess to Telia' AS "MEMO_TEXT"
     , 'Y'             AS "KEEP_USER_NAME"
     , 'Y'             AS "WAIVE_FEES"
     , 'Y'             AS "IS_MOVE_FROM_SP"
     , 'N'             AS "IS_MOVE_TO_SP"
     --, NULL            AS "ENTER_TIME"
     --, NULL            AS "REQUEST_TIME"
     --, NULL            AS "PROCESS_TIME"
     --, 'WAITING'       AS "PROCESS_STATUS"
     --, NULL            AS "STATUS_DESC"
     --, '3'             AS "PRIORITY"
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , 'HGU'           AS "REQUEST_USER_ID"
     , 'Y'             AS "SKIP_NINJA_VALIDATION"
  FROM batch_name_address_update n
     , service_agreement@nrep11  sa
     , subscriber@nrep11         s
 WHERE n.request_id      IN ('2018-08-31')
   AND n.request_user_id IN ('HGU')
   AND n.process_status   = 'PRSD_SUCCESS'
   AND n.subscriber_no    = sa.subscriber_no
   AND sa.service_type    = 'P'
   AND SYSDATE      BETWEEN sa.effective_date AND NVL(sa.expiration_date, SYSDATE + 1)
   AND sa.ban             = s.customer_id
   AND sa.subscriber_no   = s.subscriber_no
   AND s.sub_status       = 'A'
ORDER BY 1
;


SELECT m.*, s.customer_id, s.sub_status, s.sub_status_date
  FROM tmp_msisdns@nrep11 m, subscriber@nrep11 s
 WHERE m.ctn NOT IN (SELECT a.subscriber_no
                       FROM batch_move_subscribers a
                      WHERE a.request_id      IN ( '2018-08-31' )
                        AND a.request_user_id IN ( 'HGU' ))
   AND m.ctn = s.subscriber_no
   AND s.sub_status_date = (SELECT max(s2.sub_status_date)
                              FROM subscriber@nrep11 s2
                             WHERE s2.subscriber_no = s.subscriber_no)
ORDER BY 1
;

--
SELECT tm.ctn AS "SUBSCRIBER_NO"
     , '' AS "NEW_BAN"
     , '' AS "NEW_PRICEPLAN"
     , '' AS "NEW_CAMPAIGN_CODE"
     , '' AS "HANDLE_COMMITMENT"
     , '' AS "DEALER"
     , '' AS "SALES_AGENT"
     , '' AS "REASON_CODE"
     , '' AS "MEMO_TEXT"
     , '' AS "KEEP_USER_NAME"
     , '' AS "WAIVE_FEES"
     , '' AS "IS_MOVE_FROM_SP"
     , '' AS "IS_MOVE_TO_SP"
     , '' AS "ENTER_TIME"
     , '' AS "REQUEST_TIME"
     , '' AS "PROCESS_TIME"
     , '' AS "PROCESS_STATUS"
     , '' AS "STATUS_DESC"
     , '' AS "PRIORITY"
     , '' AS "REQUEST_ID"
     , '' AS "REQUEST_USER_ID"
     , '' AS "SKIP_NINJA_VALIDATION"
  FROM tmp_msisdns@nrep11 tm
 WHERE tm.ctn IN ('GSM04745117593', 'GSM04745134883')
ORDER BY 1
;       

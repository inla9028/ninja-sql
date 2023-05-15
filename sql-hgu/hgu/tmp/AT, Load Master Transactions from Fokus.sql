create table tmp_hgu_sub_ban_sts_pp
as
SELECT /*+ driving_site(s)*/ s.subscriber_no, s.customer_id AS "BAN", s.sub_status
     , RTRIM(a1.soc) AS "PRICE_PLAN"
     , a1.effective_date
  FROM subscriber@fokus s
    , service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PP%'
   and rownum           < 51
ORDER BY 1,2;


select a.*
  from subscription_types_socs a
 where a.subscription_type_id = 'PPBAREG1'
;

select a.*
  from tmp_hgu_sub_ban_sts_pp a
;

select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAAT2_SH1'
order by a.job_id
;

select a.*
  from master_transactions a
;



INSERT INTO master_transactions
SELECT NULL             AS "TRANS_NUMBER"
     , a.subscriber_no  AS "SUBSCRIBER_NO"
     , 'ODBCPA'         AS "SOC"
     , 'DELETE'            AS "ACTION_CODE"
     , NULL             AS "NEW_SOC"
     , SYSDATE          AS "ENTER_TIME"
     , SYSDATE          AS "REQUEST_TIME"
     , NULL             AS "PROCESS_TIME"
     , 'ON_HOLD'        AS "PROCESS_STATUS"
     , NULL             AS "STATUS_DESC"
     , 'NET'            AS "DEALER_CODE"
     , 'A'              AS "SALES_AGENT"
     , 1                AS "PRIORITY"
     , 'HGU 2019-11-09' AS "REQUEST_ID"
     , 'Stresser...'    AS "MEMO_TEXT"
     , NULL             AS "WAIVE_ACT_FEE"
     , '10'              AS "STREAM"
  FROM tmp_hgu_sub_ban_sts_pp a
;

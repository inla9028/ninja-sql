select *
  from batch_socs
 where request_time between trunc(sysdate) and sysdate
;

select request_id, add_socs, delete_socs, process_status, count(1) AS "COUNT"
  from batch_socs
 where request_time between trunc(sysdate) and sysdate
group by request_id, add_socs, delete_socs, process_status
order by request_id, add_socs, delete_socs, process_status
;

INSERT INTO batch_socs (subscriber_no, delete_socs, request_id, process_status)
SELECT /*+ driving_site(s)*/
       s.subscriber_no                                             AS "SUBSCRIBER_NO"
     , 'BASIS, ODB1'                                               AS "DELETE_SOCS"
     , 'NINJA TEST HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') AS "REQUEST_ID"
     , 'WAITING'                                                   AS "PROCESS_STATUS"
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND nvl(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PPU%'
   AND ROWNUM < 101
;

INSERT INTO batch_socs (subscriber_no, add_socs, request_id, process_status)
SELECT /*+ driving_site(s)*/
       a.subscriber_no                                             AS "SUBSCRIBER_NO"
     , a.delete_socs                                               AS "ADD_SOCS"
     , 'NINJA TEST HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') AS "REQUEST_ID"
     , 'WAITING'                                                   AS "PROCESS_STATUS"
  FROM batch_socs a
 WHERE a.request_id  LIKE 'NINJA TEST HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24') || '%'
   AND a.process_status = 'WAITING'
   AND a.add_socs       IS NULL
   AND a.delete_socs    IS NOT NULL
;

select *
  from batch_change_priceplan
 where request_time between trunc(sysdate) and sysdate
;

select old_priceplan, new_priceplan, process_status, requestor_id, count(1) AS "COUNT"
  from batch_change_priceplan
 where request_time between trunc(sysdate) and sysdate
group by old_priceplan, new_priceplan, process_status, requestor_id
order by old_priceplan, new_priceplan, process_status, requestor_id
;

INSERT INTO batch_change_priceplan (SUBSCRIBER_NO, OLD_PRICEPLAN, NEW_PRICEPLAN, NEW_CAMPAIGN_CODE, NEW_SUBSCRIPTION_TYPE, HANDLE_COMMITMENT, DEALER, SALES_AGENT, REASON_CODE, MEMO_TEXT, REQUESTOR_ID, SKIP_NINJA_VALIDATION, PROCESS_STATUS)
SELECT /*+ driving_site(s)*/
       s.subscriber_no                                         AS "SUBSCRIBER_NO"
     , RTRIM(a1.soc)                                           AS "OLD_PRICEPLAN"
     , DECODE(RTRIM(a1.soc), 'PPUR', 'PPUY', 'PPUR')           AS "NEW_PRICEPLAN"
     , DECODE(RTRIM(a1.soc), 'PPUR', 'PPUY00D1', 'PPUR00D1')   AS "NEW_CAMPAIGN_CODE"
     , DECODE(RTRIM(a1.soc), 'PPUR', 'PPUYREG1', 'PPURREG1')   AS "NEW_SUBSCRIPTION_TYPE"
     , 'N'                                                     AS "HANDLE_COMMITMENT"
     , 'NET'                                                   AS "DEALER"
     , 'A'                                                     AS "SALES_AGENT"
     , 'KON1'                                                  AS "REASON_CODE"
     , 'No more secrets...'                                    AS "MEMO_TEXT"
     , 'NINJA TEST ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') AS "REQUESTOR_ID"
     , 'Y'                                                     AS "SKIP_NINJA_VALIDATION"
     , 'WAITING'                                               AS "PROCESS_STATUS"
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND nvl(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)   IN ( 'PPUR', 'PPUY' )
   AND ROWNUM           < 101
;

/*
** Misc stuff...
*/

SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, RTRIM(a.soc) AS "SOC", a.campaign, a.soc_seq_no, a.effective_date
     , A.expiration_date, A.operator_id, u.user_full_name, A.application_id
     , A.loan_seq_no, A.trx_id, c.min_commit_period AS "CAMPAIGN_MONTHS"
     , A.effective_date + (365 * c.min_commit_period / 12) AS "CAMPAIGN_EXP_DATE"
  FROM service_agreement@fokus A, campaign_commitments@fokus c, users@fokus u
 WHERE A.subscriber_no        = 'GSM04795019966'
   AND SYSDATE          BETWEEN A.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
--   AND TO_DATE('2021-09-28', 'YYYY-MM-DD') BETWEEN A.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
   AND A.operator_id          = u.user_id(+)
   AND A.campaign             = c.campaign(+)
   AND A.effective_date BETWEEN c.effective_date(+) AND nvl(c.expiration_date(+), SYSDATE + 1)
--   AND A.soc               LIKE 'LEAS%'
ORDER BY 1,2,3
;

select a.*
  from allowable_upgrades a
 where 'PPUR' IN (a.CURRENT_PRICEPLAN, a.NEW_PRICEPLAN)
   and 'PPUY' IN (a.CURRENT_PRICEPLAN, a.NEW_PRICEPLAN)
--   and a.new_campaign = a.NEW_PRICEPLAN || '12SPS'
   and a.curr_a_band_rem_comm_months = 0
order by 1,2,3
;

select a.*
  from allowable_upgrades a
 where a.CURRENT_PRICEPLAN        LIKE  'PPU_'
   and a.NEW_PRICEPLAN            LIKE  'PPU_'
   and a.curr_a_band_rem_comm_months = 0
   and 2                             = (select count(1)
                                          from allowable_upgrades b
                                         where b.CURRENT_PRICEPLAN = a.NEW_PRICEPLAN
                                           and b.NEW_PRICEPLAN     = a.CURRENT_PRICEPLAN
                                           and b.curr_a_band_rem_comm_months = 0)
order by 1,2,3
;

select a.*
  from allowable_upgrades a
 where a.CURRENT_PRICEPLAN = 'PPUY'
   and a.new_priceplan    IN ( 'PPUR', 'PPUS', 'PPUT', 'PPUX' )
--   and 'PPUB' IN (a.CURRENT_PRICEPLAN, a.NEW_PRICEPLAN)
--   and a.new_campaign = a.NEW_PRICEPLAN || '12SPS'
   and a.curr_a_band_rem_comm_months = 0
order by 1,2,3
;

select a.*
  from subscription_types_socs a
 where a.subscription_type_id like 'PPU%'
   and a.soc like 'BASIS%'
   AND SYSDATE          BETWEEN A.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
;

select /*+ driving_site(a)*/
       a.soc, a.sale_eff_date, a.soc_description, a.network_ind
  from soc@fokus a
 where a.soc like 'BASIS%'
 and SYSDATE BETWEEN A.effective_date and nvl(A.expiration_date, SYSDATE + 1)
 and sysdate < nvl(a.sale_exp_date, sysdate + 1)
order by 1
;
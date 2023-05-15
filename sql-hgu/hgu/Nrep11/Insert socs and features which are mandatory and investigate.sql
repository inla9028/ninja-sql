select a.*
  from feature_parameters a
 where a.soc = 'MPODPRE01'
order by 1,2,3,4
;

--delete
--  from tmp_msisdns_w_status_pp_soc_fp
---- where soc LIKE 'NSANR_'
--;

select a.*
  from tmp_msisdns_w_status_pp_soc_fp a
 where a.soc       LIKE 'NSANR_'
--   and a.feature_code = 'B-GPRP'
   and rownum         < 21
order by 1,7,10
;

-- Modify...
select NULL AS BAN
     , SUBSCRIBER_NO
     , NULL AS ADD_SOCS
     , a.soc || '/' || a.feature_code || '/' || fp.parameter_code || '=' || fp.default_value AS "MODIFY_SOCS"
     , NULL AS DELETE_SOCS
     , NULL AS CHK_PRICEPLAN
     , NULL AS DEALER_CODE
     , NULL AS SALES_AGENT
     , 'Fixing broken/missing feature parameter' AS MEMO_TEXT
     , NULL AS OPERATOR_ID
     , 'HGU 2022-03-15' AS REQUEST_ID
     , NULL AS WAIVE_ACT_FEE
     , NULL AS ENTER_TIME
     , NULL AS REQUEST_TIME
     , NULL AS PROCESS_TIME
     , 'ON_HOLD' AS PROCESS_STATUS
  from tmp_msisdns_w_status_pp_soc_fp a, feature_parameters fp
 where a.soc       LIKE 'NSANR_'
   and a.soc          = fp.soc
   and a.feature_code = fp.feature_code
order by 2
;

-- Delete
select UNIQUE NULL AS BAN
     , SUBSCRIBER_NO
     , NULL AS ADD_SOCS
     , NULL AS MODIFY_SOCS
     , a.soc AS DELETE_SOCS
     , NULL AS CHK_PRICEPLAN
     , NULL AS DEALER_CODE
     , NULL AS SALES_AGENT
     , 'Fixing broken/missing feature parameter' AS MEMO_TEXT
     , NULL AS OPERATOR_ID
     , 'HGU 2022-03-15' AS REQUEST_ID
     , NULL AS WAIVE_ACT_FEE
     , NULL AS ENTER_TIME
     , NULL AS REQUEST_TIME
     , NULL AS PROCESS_TIME
     , 'ON_HOLD' AS PROCESS_STATUS
  from tmp_msisdns_w_status_pp_soc_fp a, feature_parameters fp
 where a.soc       LIKE 'NSANR_'
   and a.soc          = fp.soc
   and a.feature_code = fp.feature_code
order by 2
;

-- Add
select UNIQUE NULL AS BAN
     , SUBSCRIBER_NO
     , a.soc AS ADD_SOCS
     , NULL AS MODIFY_SOCS
     , NULL AS DELETE_SOCS
     , NULL AS CHK_PRICEPLAN
     , NULL AS DEALER_CODE
     , NULL AS SALES_AGENT
     , 'Fixing broken/missing feature parameter' AS MEMO_TEXT
     , NULL AS OPERATOR_ID
     , 'HGU 2022-03-15' AS REQUEST_ID
     , NULL AS WAIVE_ACT_FEE
     , NULL AS ENTER_TIME
     , NULL AS REQUEST_TIME
     , NULL AS PROCESS_TIME
     , 'ON_HOLD' AS PROCESS_STATUS
  from tmp_msisdns_w_status_pp_soc_fp a, feature_parameters fp
 where a.soc       LIKE 'NSANR_'
   and a.soc          = fp.soc
   and a.feature_code = fp.feature_code
order by 2
;

-- Insert all active relevant socs...
INSERT INTO tmp_msisdns_w_status_pp_soc_fp
with my_filter as (
select unique a.soc, a.feature_code
  from feature_parameters a
)
SELECT s.subscriber_no
     , s.customer_id            AS "BAN"
     , s.sub_status
     , 'N/A'                    AS "SIM_NUMBER"
     , 'N/A'                    AS "IMSI"
     , RTRIM(a1.soc)            AS "PRICE_PLAN"
     , RTRIM(a2.soc)            AS "SOC"
     , a2.soc_seq_no
     , a2.effective_date
     , RTRIM(f1.feature_code)   AS "FEATURE_CODE"
     , RTRIM(f1.ftr_add_sw_prm) AS "FTR_ADD_SW_PRM"
  FROM subscriber s, service_agreement a1, service_agreement a2, service_feature f1, my_filter fp
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   --
--   AND RTRIM(a1.soc)   IN ( 'PW20' )
  AND a1.service_type   = 'P'
  --
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   --
   AND a2.service_type  = 'R' -- G = Flex lease
   AND RTRIM(a2.soc)    = fp.soc
   --
   AND f1.soc           = a2.soc
   AND f1.soc_seq_no    = a2.soc_seq_no
   AND RTRIM(f1.feature_code) = fp.feature_code
   --
--   AND ROWNUM < 101
;

commit work
;

select count(1) from tmp_msisdns_w_status_pp_soc_fp;

--
delete
  from tmp_msisdns_w_status_pp_soc_fp a
 where exists (select *
                 from feature_parameters fp
                where a.soc          = fp.soc
                  and a.feature_code = fp.feature_code
                  and a.ftr_add_sw_prm     LIKE '%' || fp.parameter_code || '=%'
                  and a.ftr_add_sw_prm NOT LIKE '%' || fp.parameter_code || '=@%')
;

commit work
;
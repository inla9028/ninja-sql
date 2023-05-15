SELECT /*+ driving_site(b)*/
       b.ban, b.curr_root_ban, b.sys_creation_date, b.ban_status
     , b.account_type, b.account_sub_type, b.operator_id, u.user_full_name
     , b.credit_class, b.bill_cycle, b.bl_last_prod_date, b.bl_prt_category
  FROM billing_account@fokus b, subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'41362354'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.customer_id   = b.ban
  AND b.operator_id   = u.user_id(+)
;

SELECT /*+ driving_site(b)*/
       b.ban, b.sys_creation_date, b.ban_status
     , b.account_type, b.account_sub_type
     , b.bill_cycle, b.bl_last_prod_date, b.bl_prt_category, b.*
  FROM billing_account@fokus b, subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'41362354'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.customer_id   = b.ban
  AND b.operator_id   = u.user_id(+)
;

SELECT /*+ driving_site(c)*/
       c.cycle_code
  FROM cycle_control@fokus c
WHERE c.cycle_start_date = TRUNC(SYSDATE)
;

SELECT cycle_code, cycle_start_date, cycle_close_date
  FROM cycle_control@fokus
 WHERE SYSDATE BETWEEN cycle_start_date AND cycle_close_date
ORDER BY 1
;

SELECT /*+ driving_site(c)*/
       c1.CYCLE_CODE, c1.CYCLE_RUN_YEAR, c1.CYCLE_RUN_MONTH, c1.CYCLE_START_DATE, c1.CYCLE_CLOSE_DATE
     , c2.CYCLE_CODE, c2.CYCLE_RUN_YEAR, c2.CYCLE_RUN_MONTH, c2.CYCLE_START_DATE, c2.CYCLE_CLOSE_DATE
  FROM cycle_control@fokus c1, cycle_control@fokus c2
 WHERE c1.cycle_start_date > TRUNC(SYSDATE, 'YEAR')
   AND c1.cycle_start_date = c2.cycle_start_date
   AND c1.cycle_code      != c2.cycle_code
;

SELECT ai.table_name, ai.index_name, ai.index_type, ai.uniqueness
     , aic.column_name
  FROM all_indexes@fokus ai, all_ind_columns@fokus aic
 WHERE 1 = 1
--  AND ai.owner = UPPER('owner')
  AND ai.table_name IN ('BILLING_ACCOUNT', 'SUBSCRIBER', 'SERVICE_AGREEMENT', 'SERVICE_FEATURE')
  AND ai.owner      = aic.index_owner
  AND ai.index_name = aic.index_name
ORDER BY 1,5,2,3,4
;

SELECT /*+ driving_site(ba)*/
       ba.ban, ba.ban_status, ba.account_type, ba.account_sub_type, ba.bill_cycle
     , RTRIM(sf.soc) AS "SOC", RTRIM(sf.feature_code) AS "FEATURE_CODE"
     , sf.ftr_add_sw_prm
  FROM billing_account@fokus ba, service_feature@fokus sf
 WHERE ba.ban_status           = 'O'
   AND ba.bill_cycle          IN ( 13 ) -- xXx
   AND ba.ban                  = sf.ban
   AND SYSDATE           BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
   AND RTRIM(sf.soc)          IN ( '&socname' ) -- xXx
   AND RTRIM(sf.feature_code) IN ( '&featurecode' ) -- xXx
;


SELECT /*+ driving_site(ba)*/
       ba.ban, ba.ban_status, ba.account_type, ba.account_sub_type, ba.bill_cycle
     , RTRIM(sf.soc) AS "SOC", RTRIM(sf.feature_code) AS "FEATURE_CODE"
     , sf.ftr_add_sw_prm
  FROM billing_account@fokus ba, subscriber@fokus s, service_feature@fokus sf
 WHERE ba.ban_status           = 'O'
   AND ba.bill_cycle          IN ( 13 ) -- xXx
   AND ba.ban                  = s.customer_id
   AND s.sub_status            = 'A'
   AND ba.ban                  = sf.ban
   AND s.subscriber_no         = sf.subscriber_no
   AND SYSDATE           BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
   AND (( ba.account_type = '&acctype1' AND RTRIM(sf.soc) = '&socname1' AND RTRIM(sf.feature_code) = '&featurecode1' )
     OR ( ba.account_type = '&acctype2' AND RTRIM(sf.soc) = '&socname2' AND RTRIM(sf.feature_code) = '&featurecode2' )
     OR ( ba.account_type = '&acctype3' AND RTRIM(sf.soc) = '&socname3' AND RTRIM(sf.feature_code) = '&featurecode3' )
   )
;

/*
feature        =            rset.getString( "FEATURE",         index); // TODO: Do we need the feature?
frequency      =            rset.getInteger("FREQUENCY",       index); // Not used as of today....
productId      =            rset.getString( "PRODUCT_ID",      index); // Identification of the product , eg. DATABOOST_60MIN, DATABOOST_1D
productType    =            rset.getString( "PRODUCT_TYPE",    index); // Identification of a group of product, eg. DATABOOST
rechargeAmount =            rset.getInteger("RECHARGE_AMOUNT", index); // Amount of RECHARGE_UNIT to recharge the product balance identified by is_product_id
rechargeCount  =            rset.getInteger("RECHARGE_COUNT",  index); // Count of product balances identified by is_product_id to recharge
rechargeUnit   =            rset.getString( "RECHARGE_UNIT",   index); // Type describing what to recharge, eg. MINUTE, MIN, HOUR, DAY, KR
rowid          = (ROWID)    rset.getValue ( "ROWID",           index, null);
sms            = toBoolean( rset.getString( "SMS",             index));
soc            =            rset.getString( "SOC",             index);
subscriberNo   =            rset.getString( "SUBSCRIBER_NO",   index);
validFrom      =            rset.getDate(   "VALID_FROM",      index); // Start date/time when product is available for usage
validTo        =            rset.getDate(   "VALID_TO",        index); // End date/time when product is available for usage
*/

SELECT ROWID, subscriber_no, soc, feature
     , product_id, product_type, recharge_amount, recharge_count, recharge_unit
     , sms, valid_from, valid_to
  FROM batch_voucher
 WHERE process_status = 'WAITING'
   AND request_time   < SYSDATE
ORDER BY request_time
;

-- Olav
WITH billing_account_filter
        AS (SELECT ba.ban,
                   ba.ban_status,
                   ba.account_type,
                   ba.account_sub_type,
                   ba.bill_cycle
              FROM billing_account ba
             WHERE 1 = 1
                   AND ba.bill_cycle IN
                          (SELECT cycle_code
                             FROM cycle_control
                            WHERE cycle_start_date = TRUNC (SYSDATE) + 4)
                   AND ba.account_type IN ('I', 'P')    -- INDIVIDUAL, PREPAID
                   AND ba.ban_status NOT IN ('C', 'N', 'T') -- CLOSED, CANCELLED, TENTATIVE
                                                           )
SELECT ba.ban,
       ba.ban_status,
       ba.account_type,
       ba.account_sub_type,
       ba.bill_cycle,
       RTRIM (sf.soc) AS "SOC",
       RTRIM (sf.feature_code) AS "FEATURE_CODE",
       sf.ftr_add_sw_prm
  FROM billing_account_filter ba, service_feature sf, subscriber s
 WHERE     1 = 1
       AND ba.ban = s.customer_id
       AND ba.ban = sf.ban
       AND s.subscriber_no = sf.subscriber_no
       AND s.sub_status IN ('A', 'S')                     -- ACTIVE, SUSPENDED
       AND NVL (s.rms_ref_od, '0') IN ('1', '2') -- PREPAID, PREPAID CONTROLLED
       AND SYSDATE BETWEEN sf.ftr_effective_date
                       AND NVL (sf.ftr_expiration_date, SYSDATE + 1)
       AND (sf.service_type, RTRIM (sf.soc), RTRIM (sf.feature_code)) IN
              (SELECT s.service_type, rf.soc, rf.feature_code
                 FROM soc s, rated_feature rf, feature f
                WHERE     1 = 1
                      AND s.soc = rf.soc
                      AND f.feature_code = rf.feature_code
                      AND NVL (s.expiration_date, SYSDATE + 1) > SYSDATE
                      AND NVL (rf.expiration_date, SYSDATE + 1) > SYSDATE
                      AND RTRIM (f.feature_Type) = 'REV')
;

-- HGU

WITH billing_account_filter
  AS (SELECT ba.ban, ba.ban_status, ba.account_type, ba.account_sub_type, ba.bill_cycle
        FROM billing_account ba
       WHERE ba.bill_cycle IN (
               SELECT cycle_code
                 FROM cycle_control
                WHERE cycle_start_date  = TRUNC(SYSDATE))
         AND ba.account_type   IN ('I', 'P')      -- INDIVIDUAL, PREPAID
         AND ba.ban_status NOT IN ('C', 'N', 'T') -- CLOSED, CANCELLED, TENTATIVE
     )
SELECT ba.ban, ba.ban_status, ba.account_type, ba.account_sub_type, ba.bill_cycle
     , RTRIM (sf.soc) AS "SOC", RTRIM (sf.feature_code) AS "FEATURE_CODE", sf.ftr_add_sw_prm
  FROM billing_account_filter ba, service_feature sf, subscriber s
 WHERE ba.ban          = s.customer_id
   AND ba.ban          = sf.ban
   AND s.subscriber_no = sf.subscriber_no
   AND s.sub_status   IN ('A', 'S')               -- ACTIVE, SUSPENDED
   AND SYSDATE   BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
   AND (sf.service_type, RTRIM(sf.soc), RTRIM(sf.feature_code)) IN (
         SELECT s.service_type, rf.soc, rf.feature_code
           FROM soc s, rated_feature rf, feature f
          WHERE s.soc                 = rf.soc
            AND f.feature_code        = rf.feature_code
            AND SYSDATE               < NVL(s.expiration_date,  SYSDATE + 1)
            AND SYSDATE               < NVL(rf.expiration_date, SYSDATE + 1)
            AND RTRIM(f.feature_Type) = 'REV')
;



SELECT a.*
  from batch_voucher_status a
order by 2
;

delete 
  from batch_voucher_status
;

select a.*
  from batch_voucher a
;

update batch_voucher a
  set a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
;

/*
"no.netcom.ninja.core.system.sql.exception.NinjaSQLException: processVoucher(); Failed to process VoucherRequest{]} due to SQLException: Invalid column index:  [ID=ptl5m59ud3o12i4fgaj6l2kp30mixf1] [ID=ptl5m59ud3o12i4fgaj6l2kp30mixf1]
	at no.netcom.demon.batchjobs.BatchVoucherJob.processVoucher(BatchVoucherJob.java:437)
	at no.netcom.demon.batchjobs.BatchVoucherJob.processTransaction(BatchVoucherJob.java:105)
	at no.netcom.demon.batchjobs.AncestorBatchJobManagerDB.processRequestsImpl(AncestorBatchJobManagerDB.java:498)
	at no.netcom.demon.batchjobs.AncestorBatchJobManagerDB.processRequests(AncestorBatchJobManagerDB.java:373)
	at no.netcom.demon.batchjobs.BatchJobFacade.batchProcessVouchers(BatchJobFacade.java:2210)
	at no.netcom.ninjatest.TestNinjaBatchJobs.testBatchVouchersProcess(TestNinjaBatchJobs.java:1347)
	at no.netcom.ninjatest.TestNinjaBatchJobs.test(TestNinjaBatchJobs.java:91)
	at no.netcom.ninjatest.TestNinjaBatchJobs.main(TestNinjaBatchJobs.java:134)
Caused by: java.sql.SQLException: Invalid column index
	at oracle.jdbc.driver.OracleCallableStatement.getString(OracleCallableStatement.java:651)
	at oracle.jdbc.driver.OracleCallableStatementWrapper.getString(OracleCallableStatementWrapper.java:860)
	at no.netcom.demon.batchjobs.BatchVoucherJob.processVoucher(BatchVoucherJob.java:504)
	at no.netcom.demon.batchjobs.BatchVoucherJob.processVoucher(BatchVoucherJob.java:426)
	... 7 more
Caused by: java.sql.SQLException: Invalid column index
	at oracle.jdbc.driver.OracleCallableStatement.getString(OracleCallableStatement.java:651)
	at oracle.jdbc.driver.OracleCallableStatementWrapper.getString(OracleCallableStatementWrapper.java:860)
	at no.netcom.demon.batchjobs.BatchVoucherJob.processVoucher(BatchVoucherJob.java:504)
	at no.netcom.demon.batchjobs.BatchVoucherJob.processVoucher(BatchVoucherJob.java:426)
	at no.netcom.demon.batchjobs.BatchVoucherJob.processTransaction(BatchVoucherJob.java:105)
	at no.netcom.demon.batchjobs.AncestorBatchJobManagerDB.processRequestsIm"
*/

select /*+ driving_site(f)*/ f.*
  from feature@fokus f
 where f.feature_type = 'REV'
;

SELECT a.*
  FROM feature_parameters a, feature@fokus f
 WHERE a.feature_code = f.feature_code
   AND f.feature_type = 'REV'
ORDER BY 1,2,3,4
;



SELECT COUNT(1) AS "COUNT_SUBSCRIBERS" FROM tmp_disc_subscribers;
SELECT COUNT(1) AS "COUNT_SUBSCRIBERS_2016" FROM tmp_disc_subscribers WHERE effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD');
SELECT COUNT(1) AS "COUNT_CAMPAIGNS" FROM tmp_disc_campaigns;
SELECT COUNT(1) AS "COUNT_DISCOUNTS" FROM tmp_disc_ban_discount;

SELECT s.*
  FROM tmp_disc_subscribers s
-- WHERE s.ban = 101953206
 WHERE s.subscriber_no = 'GSM047' || '99779936'
ORDER BY s.effective_date
;

SELECT c.*
  FROM tmp_disc_campaigns c
;

SELECT d.*
  FROM tmp_disc_ban_discount d
 WHERE d.subscriber_no = 'GSM047' || '99779936'
-- WHERE d.subscriber_no IN ('GSM047' || '41550240', 'GSM047' || '45450394', 'GSM047' || '93021351', 'GSM04740005554')
;

SELECT d.*
  FROM mdcust_ny.ban_discount@wh10p d
 WHERE d.subscriber_no = 'GSM047' || '99779936'
;

SELECT d.*
  FROM ban_discount@fokus d
 WHERE d.ban           = 869342501
   AND d.subscriber_no = 'GSM047' || '99779936'
;
 
-- 41550240 - Is correctly registered with discount
-- 45450394 - New sub, is missing discount
-- 93021351 - Is missing discount, had a discount which ended in May 2014.

SELECT s.*
  FROM tmp_disc_subscribers s
 WHERE s.subscriber_no IN ('GSM047' || '41550240', 'GSM047' || '45450394', 'GSM047' || '93021351', 'GSM04740005554')
ORDER BY s.subscriber_no, s.ban
;

-- add use of commitment date as well... only when commitment is started on the same date should they have the discount...
-- Check for commit-start date and soc eff date, and check if the same Campaign Sequence has been used for the same subscriber
SELECT s.ban, s.subscriber_no, s.sub_status, s.soc, s.service_type, c.price_plan
     , c.price_plan_desc, s.campaign , c.campaign_desc, s.effective_date AS "SOC_EFF_DATE"
     , s.expiration_date AS "SOC_EXP_DATE", s.commit_start_date, s.commit_end_date
     , c.keep_discount_ind, c.campaign_seq, c.effective_date AS "CAMP_EFF_DATE"
     , c.expiration_date AS "CAMP_EXP_DATE"
  FROM tmp_disc_subscribers s, tmp_disc_campaigns c
 WHERE s.subscriber_no IN ('GSM047' || '41550240', 'GSM047' || '45450394', 'GSM047' || '93021351', 'GSM04740005554')
   AND s.campaign = c.campaign
   AND s.effective_date BETWEEN c.effective_date AND c.expiration_date
   AND s.effective_date BETWEEN s.commit_start_date AND s.commit_end_date
   AND s.effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD')
   AND NOT EXISTS (
        SELECT ''
          FROM tmp_disc_ban_discount d
         WHERE s.ban            = d.ban
           AND s.subscriber_no  = d.subscriber_no
           AND s.campaign       = d.campaign
           -- AND s.effective_date = d.effective_date
           AND s.effective_date BETWEEN d.effective_date AND d.expiration_date
   )
ORDER BY s.subscriber_no, s.effective_date, s.expiration_date, s.ban
;

SELECT d.*
  FROM tmp_disc_ban_discount d
 WHERE d.subscriber_no IN ('GSM047' || '41550240', 'GSM047' || '45450394', 'GSM047' || '93021351')
   AND d.effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD')
ORDER BY d.ban
;


/*
** List all subscribers and campaigns which are missing an entry in BAN_DISCOUNT
*/
SELECT s.ban, s.ban_status, s.account_type, s.account_sub_type, s.subscriber_no
     , s.sub_status, s.soc, s.service_type, c.price_plan
     , c.price_plan_desc, s.campaign , c.campaign_desc, s.effective_date AS "SOC_EFF_DATE"
     , s.expiration_date AS "SOC_EXP_DATE", s.commit_start_date, s.commit_end_date
     , c.keep_discount_ind, c.campaign_seq, c.effective_date AS "CAMP_EFF_DATE"
     , c.expiration_date AS "CAMP_EXP_DATE"
  FROM tmp_disc_subscribers s, tmp_disc_campaigns c
 WHERE 1 = 1
--   AND s.subscriber_no  IN ('GSM047' || '41550240', 'GSM047' || '45450394', 'GSM047' || '93021351')
   AND s.campaign = c.campaign
   AND s.effective_date BETWEEN c.effective_date AND c.expiration_date
   AND s.effective_date BETWEEN s.commit_start_date AND s.commit_end_date
   AND s.effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD')
   AND NOT EXISTS (
        SELECT ''
          FROM tmp_disc_ban_discount d
         WHERE s.ban            = d.ban
           AND s.subscriber_no  = d.subscriber_no
           AND s.campaign       = d.campaign
           -- AND s.effective_date = d.effective_date
           AND s.effective_date BETWEEN d.effective_date AND d.expiration_date
   )
--   AND ROWNUM < 101
ORDER BY s.subscriber_no, s.effective_date, s.expiration_date, s.ban

;

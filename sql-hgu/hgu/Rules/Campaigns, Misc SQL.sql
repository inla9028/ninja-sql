SELECT a.*, b.*, c.*
  FROM campaign@fokus a, campaign_commitments@fokus b, soc@fokus c
 WHERE RTRIM(a.campaign)  = RTRIM(b.campaign)
   AND RTRIM(b.pp_code)   = RTRIM(c.soc)
   AND SYSDATE      BETWEEN c.effective_date AND NVL(c.expiration_date, SYSDATE + 1)
   AND RTRIM(a.campaign) IN (
    'PPUT12R25', 'PSSL24BI'
 )
ORDER BY RTRIM(a.campaign)
;

SELECT a.*
  FROM penalties@fokus a
-- WHERE a.
;

SELECT UNIQUE RTRIM(a.campaign) AS "CAMPAIGN", RTRIM(a.campaign_desc) AS "CAMPAIGN_DESC"
            , b.pp_code AS "PRICE_PLAN", RTRIM(c.soc_description) AS "PRICE_PLAN_DESC"
            , b.customer_type, b.min_commit_period, b.penalty_amount, b.penalty_base_amt
  FROM campaign@fokus a, campaign_commitments@fokus b, soc@fokus c, rating_account_types r
 WHERE RTRIM(a.campaign)  = RTRIM(b.campaign)
   AND RTRIM(b.pp_code)   = RTRIM(c.soc)
   AND SYSDATE      BETWEEN c.effective_date AND NVL(c.expiration_date, SYSDATE + 1)
   AND RTRIM(b.pp_code) IN (
    'PPEM'
   )
   AND RTRIM(b.pp_code)   = r.priceplan_code
   AND RTRIM(a.campaign)  = r.campaign_code
ORDER BY RTRIM(a.campaign)
;

SELECT a.*
  FROM rating_account_types r, allowable_upgrades a
 WHERE r.account_type      = 'B'
   AND r.account_sub_type  = 'R'
   AND r.priceplan_code    = a.new_priceplan
   AND r.campaign_code     = a.new_campaign
   AND a.current_priceplan = 'PPUT'
--   AND r.campaign_code    = 'PPEM12T1'
;

SELECT a.*
  FROM allowable_upgrades a
 WHERE a.current_priceplan = 'PPUT'
;

SELECT b.account_type, b.account_sub_type, b.ban_status
  FROM billing_account@fokus b, subscriber@fokus s
 WHERE s.subscriber_no = 'GSM047' || '90106140'
   AND s.sub_status    = 'A'
   AND s.customer_id   = b.ban
   AND b.ban_status    = 'O'
;


SELECT a.*
  FROM allowable_upgrades a, rating_account_types r, billing_account@fokus b, subscriber@fokus s
 WHERE s.subscriber_no     = 'GSM047' || '90106140'
   AND s.sub_status        = 'A'
   AND s.customer_id       = b.ban
   AND b.ban_status        = 'O'
   AND r.account_type      = b.account_type
   AND r.account_sub_type  = b.account_sub_type
   AND r.priceplan_code    = a.new_priceplan
   AND a.current_priceplan = 'PPUT'
;


/*
** Based on a (set of) campaign(s), list description, price plan and price plan's description.
*/
SELECT UNIQUE RTRIM(a.campaign) AS "CAMPAIGN", RTRIM(a.campaign_desc) AS "CAMPAIGN_DESC"
            , b.pp_code AS "PRICE_PLAN", RTRIM(c.soc_description) AS "PRICE_PLAN_DESC"
            , b.customer_type, b.min_commit_period, b.penalty_amount, b.penalty_base_amt
  FROM campaign a, campaign_commitments b, soc c
 WHERE RTRIM(a.campaign)  = RTRIM(b.campaign)
   AND RTRIM(b.pp_code)   = RTRIM(c.soc)
   AND SYSDATE      BETWEEN c.effective_date AND NVL(c.expiration_date, SYSDATE + 1)
   AND RTRIM(a.campaign) IN (
    'PPEF12R50'
 )
ORDER BY RTRIM(a.campaign)
;

/*
** Display the tiers (the progress of a penalty) for a campaign.
*/
SELECT cc.campaign, p.*
  FROM campaign_commitments cc, penalties p
 WHERE RTRIM(cc.campaign) IN (
        'PPEF12R50'
    )
   AND cc.campaign_seq = p.campaign_seq_no
;

/******************************************************************************
** Same as above, but via db-link(s).
******************************************************************************/

/*
** Based on a (set of) campaign(s), list description, price plan and price plan's description.
*/
SELECT UNIQUE RTRIM(a.campaign) AS "CAMPAIGN", RTRIM(a.campaign_desc) AS "CAMPAIGN_DESC"
            , b.pp_code AS "PRICE_PLAN", RTRIM(c.soc_description) AS "PRICE_PLAN_DESC"
            , b.customer_type, b.min_commit_period, b.penalty_amount, b.penalty_base_amt
  FROM campaign@fokus a, campaign_commitments@fokus b, soc@fokus c
 WHERE RTRIM(a.campaign)  = RTRIM(b.campaign)
   AND RTRIM(b.pp_code)   = RTRIM(c.soc)
   AND SYSDATE      BETWEEN c.effective_date AND NVL(c.expiration_date, SYSDATE + 1)
   AND RTRIM(a.campaign) IN (
    'PPEF12R50'
 )
ORDER BY RTRIM(a.campaign)
;

/*
** Display the tiers (the progress of a penalty) for a campaign.
*/
SELECT cc.campaign, p.*
  FROM campaign_commitments@fokus cc, penalties@fokus p
 WHERE RTRIM(cc.campaign) IN (
        'PPEF12R50'
    )
   AND cc.campaign_seq = p.campaign_seq_no
;


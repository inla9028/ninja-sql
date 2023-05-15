SELECT 0 AS "BILL_AGR_TYPES_SUB_ID"
     , bat.agreement_type
     , DECODE (bat.non_tree_allowed, 'Y', 'N', bat.non_tree_allowed) AS "BAN_TREE_IND"
     , rat.account_type
     , rat.account_sub_type
     , rat.priceplan_code  AS "NEW_PRICEPLAN"
     , rat.campaign_code   AS "NEW_CAMPAIGN_ID"
     , c.commitment_months AS "NEW_COMMITMENT_MONTHS"
     , rat.subscription_type_id
     , d.description
     , '_'                 AS "ORG_COMMITMENT_BAND"
     , 99                  AS "REMAINING_COM_MONTHS"
  FROM rating_account_types rat,
       priceplans p,
       campaigns c,
       billing_agreement_types bat,
       priceplan_campaign_descr d
 WHERE rat.agreement_type          = 'SP' -- 'R'
   AND rat.account_type         LIKE 'S'
   AND rat.account_sub_type     LIKE 'IN'
   AND TRUNC(SYSDATE)        BETWEEN rat.effective_date AND rat.sales_expiry_date
   AND bat.agreement_type          = rat.agreement_type
   AND bat.account_type            = rat.account_type
   AND bat.account_sub_type        = rat.account_sub_type
   -- One of these...
   AND bat.tree_allowed            = 'Y'
   --AND bat.non_tree_allowed        = 'Y'
   --
   AND TRUNC(SYSDATE)        BETWEEN bat.effective_date AND bat.expiry_date
   AND d.priceplan                 = rat.priceplan_code
   AND d.campaign_id               = rat.campaign_code
   AND d.language_code             = 'NO'
   AND p.priceplan_code            = rat.priceplan_code
   AND TRUNC(SYSDATE)        BETWEEN p.sales_effective_date AND p.sales_expiry_date
   AND c.campaign_code             = rat.campaign_code
   AND TRUNC(SYSDATE)        BETWEEN c.sales_effective_date AND c.sales_expiry_date
   AND c.new_subscriptions_allowed = 'Y'
ORDER BY rat.priceplan_code, rat.campaign_code
;

/*
** Investigations below...
*/

SELECT a.*
  FROM rating_account_types a
 WHERE a.priceplan_code IN ( 'PVIC', 'PVID', 'PVJA' )
   OR (a.account_type = 'S' AND a.account_sub_type = 'TE')
;

SELECT a.*
  FROM priceplans a
 WHERE a.priceplan_code IN ( 'PVIC', 'PVID', 'PVJA' )
;

SELECT a.*
  FROM campaigns a
 WHERE a.campaign_code = '000000000'
;

SELECT a.*
  FROM billing_agreement_types a
 WHERE a.account_type = 'S'
   AND a.account_sub_type IN ( 'IN', 'CI' )
;


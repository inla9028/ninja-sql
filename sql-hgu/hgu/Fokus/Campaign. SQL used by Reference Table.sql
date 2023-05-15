SELECT campaign_seq,  RTRIM(campaign) AS "CAMPAIGN", RTRIM(pp_code) AS "PP_CODE",
       customer_type, RTRIM(customer_subtype) AS "CUSTOMER_SUBTYPE",
       NVL(min_commit_period, 0) AS "MIN_COMMIT_PERIOD",
       RTRIM(discount_group_code) AS "DISCOUNT_GROUP_CODE",
       RTRIM(keep_discount_ind) AS "KEEP_DISCOUNT_IND",
       prep_coverage, NVL(prep_amount, 0) AS "PREP_AMOUNT", prep_cover_debts,
       NVL(act_fee, 0) AS "ACT_FEE", NVL(penalty_amount, 0) AS "PENALTY_AMOUNT",
       reduced_eqp_ind, NVL(sale_eff_date, SYSDATE+1) AS "SALE_EFF_DATE",
       NVL(sale_exp_date, TO_DATE('4700-12-31','YYYY-MM-DD')) AS "SALE_EXP_DATE",
       imei_ind
  FROM campaign_commitments
 WHERE (RTRIM(campaign), campaign_seq) IN (
    SELECT RTRIM(campaign) AS "CAMPAIGN", MAX(campaign_seq) AS "CAMPAIGN_SEQ" -- TODO: Rewrite this to use a correlated sub-query and remove the order by?
      FROM campaign_commitments
     WHERE sale_eff_date <= SYSDATE -- inl 09.12.08 TD3382 - we shouldn't retrieve rows with future sale_eff_date
    GROUP BY campaign)
ORDER BY pp_code, campaign, campaign_seq
;

/*
** Sames as above, but filtered.
*/
SELECT *
FROM (
    SELECT campaign_seq,  RTRIM(campaign) AS "CAMPAIGN", RTRIM(pp_code) AS "PP_CODE",
           customer_type, RTRIM(customer_subtype) AS "CUSTOMER_SUBTYPE",
           NVL(min_commit_period, 0) AS "MIN_COMMIT_PERIOD",
           RTRIM(discount_group_code) AS "DISCOUNT_GROUP_CODE",
           RTRIM(keep_discount_ind) AS "KEEP_DISCOUNT_IND",
           prep_coverage, NVL(prep_amount, 0) AS "PREP_AMOUNT", prep_cover_debts,
           NVL(act_fee, 0) AS "ACT_FEE", NVL(penalty_amount, 0) AS "PENALTY_AMOUNT",
           reduced_eqp_ind, NVL(sale_eff_date, SYSDATE+1) AS "SALE_EFF_DATE",
           NVL(sale_exp_date, TO_DATE('4700-12-31','YYYY-MM-DD')) AS "SALE_EXP_DATE",
           imei_ind
      FROM campaign_commitments
     WHERE (RTRIM(campaign), campaign_seq) IN (
        SELECT RTRIM(campaign) AS "CAMPAIGN", MAX(campaign_seq) AS "CAMPAIGN_SEQ" -- TODO: Rewrite this to use a correlated sub-query and remove the order by?
          FROM campaign_commitments
         WHERE sale_eff_date <= SYSDATE -- inl 09.12.08 TD3382 - we shouldn't retrieve rows with future sale_eff_date
        GROUP BY campaign)
    ORDER BY pp_code, campaign, campaign_seq
) WHERE campaign IN ( 'PPEF12R50' )
;

SELECT c.*
  FROM campaign_commitments c
 WHERE (RTRIM(c.campaign), c.campaign_seq) IN (
        SELECT RTRIM(c2.campaign) AS "CAMPAIGN", MAX(c2.campaign_seq) AS "CAMPAIGN_SEQ" -- TODO: Rewrite this to use a correlated sub-query and remove the order by?
          FROM campaign_commitments c2
         WHERE c2.sale_eff_date <= SYSDATE -- inl 09.12.08 TD3382 - we shouldn't retrieve rows with future sale_eff_date
        GROUP BY c2.campaign)
   AND RTRIM(c.campaign) IN ( 'PPEF12R50' )
ORDER BY c.pp_code, c.campaign, c.campaign_seq
;

SELECT c.campaign, c.campaign_seq, c.sys_creation_date
     , c.effective_date, c.expiration_date, c.sale_eff_date, c.sale_exp_date
  FROM campaign_commitments c
 WHERE RTRIM(c.campaign) IN ( 'PPEF12R50' )
ORDER BY c.pp_code, c.campaign, c.campaign_seq
;

-- Find an equal campaign...
SELECT c1.*
  FROM campaign_commitments c1, campaign_commitments c2
 WHERE (RTRIM(c1.campaign), c1.campaign_seq) IN (
        SELECT RTRIM(c3.campaign) AS "CAMPAIGN", MAX(c3.campaign_seq) AS "CAMPAIGN_SEQ"
          FROM campaign_commitments c3
         WHERE c3.sale_eff_date <= SYSDATE
        GROUP BY c3.campaign)
   AND RTRIM(c1.campaign) IN ( 'PPEF12R50' )
   AND c1.pp_code = c2.pp_code
   AND c1.discount_group_code = c2.discount_group_code
   AND c1.prep_amount = c2.prep_amount
   AND c1.prep_coverage = c2.prep_coverage
   AND c1.customer_type = c2.customer_type
;

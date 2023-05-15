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

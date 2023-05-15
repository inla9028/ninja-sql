--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all campaigns commitments for a specific priceplan
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.campaign, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.product_type, a.campaign_desc_seq,
       a.campaign_desc
  FROM campaign@fokus a
  WHERE a.campaign LIKE '%' || 'COOP' || '%';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all campaigns commitments for a specific priceplan
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.campaign_seq, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.campaign, a.effective_date, a.customer_type,
       a.customer_subtype, a.min_commit_period, a.pp_code,
       a.discount_group_code, a.prep_amount, a.prep_coverage,
       a.prep_cover_debts, a.act_fee, a.reduced_eqp_ind, a.dlr_act_fee,
       a.penalty_amount, a.penalty_pror_ind, a.sale_eff_date,
       a.sale_exp_date, a.expiration_date, a.imei_ind,
       a.second_discount_group, a.second_discgp_eff
  FROM campaign_commitments@fokus a
 WHERE RTRIM(a.pp_code) IN ('PPUP')
   AND SYSDATE between a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all socs that are part of a campaign for a given priceplan
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT b.pp_code, b.campaign, b.effective_date, b.expiration_date, a.soc, 
       a.sys_creation_date, a.sys_update_date, a.operator_id, a.application_id, 
       a.dl_service_code, a.dl_update_stamp
  FROM commit_soc_relation@fokus a, campaign_commitments@fokus b
 WHERE a.campaign_seq   = b.campaign_seq
   AND SYSDATE    BETWEEN b.effective_date AND NVL(b.expiration_date, TO_DATE('4700', 'YYYY'))
   AND RTRIM(b.pp_code) IN ('PPUP')
ORDER BY b.pp_code, b.campaign, a.soc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs that belongs to a priceplan, according to Fokus
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc_src, a.src_effective_date, a.soc_dest,
       a.dest_effective_date, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.relation_type, a.expiration_date
  FROM soc_relation@fokus a
  WHERE SYSDATE BETWEEN a.src_effective_date AND NVL(a.expiration_date, TO_DATE('4700', 'YYYY'))
    AND SYSDATE > a.dest_effective_date
    AND RTRIM(a.soc_src) IN ('PPUP')
  ORDER BY a.soc_src, a.soc_dest;



/*
**
** DK :: Display the Spotify campaigns that does not match the FLEX price plan
** @see FF-2654, FF-2779 and FF-2780.
**
*/
SELECT a.sys_creation_date, a.campaign, a.effective_date, a.customer_type,
       a.pp_code, a.sale_eff_date, a.sale_exp_date, a.expiration_date
  FROM campaign_commitments a
 WHERE a.campaign like 'SPOT%'
   AND SYSDATE BETWEEN a.effective_date AND NVL(expiration_date, SYSDATE + 1)
   AND a.pp_code LIKE 'FLEX%'
   AND a.campaign NOT LIKE 'SPOT' || SUBSTR(RTRIM(a.pp_code), 5) || '%' 
ORDER BY a.campaign, a.pp_code
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

/*
** List a dealer as Ninja does.
*/
SELECT RTRIM(dealer) AS "DEALER", dlr_tp_cd, dlr_class_cd, RTRIM(dlr_name) AS "DLR_NAME",
       vat_reg_ind, start_date, end_date, phone_no, phone_no_2, fax_no, nl_cd,
       dprt_department_code, sales_area, dealer_title, user_comments, vbank_account,
       ap_account, adr_attention, adr_primary_ln, adr_secondary_ln, adr_city,
       adr_post_code, adr_country, adr_county, vat_reg_no, credit_terms, credit_limit,
       credit_days, dealer_group, dlr_long_name, e_mail, collect_conn_fee,
       collect_deposit, collect_prepayment, default_pym_sts
  FROM dealer_profile
 WHERE RTRIM(dlr_tp_cd) IN ('2','3') -- '1' = SalesAgent, '2' = External, '3' = Dummy
   AND dealer = 'DRFT'
ORDER BY dealer ASC
;

/*
** List all number-locations associated with a dealer.
*/
SELECT RTRIM(nldl.dealer_code) AS "DEALER_CODE", RTRIM(nldl.nl_id) AS "NL_ID"
     , RTRIM(nl.nl_type) AS "NL_TYPE", RTRIM(ngpnl.ngp) AS "NGP_ID",
       nl.nl_dsc
  FROM nl_dealer_link nldl, number_location nl, ngp_nl_assignment ngpnl
 WHERE RTRIM(nldl.dealer_code) IN ( 'PO01', 'PO02' )
   AND SYSDATE            BETWEEN nldl.effective_date AND NVL(nldl.expiration_date, SYSDATE + 1)
   AND nldl.nl_id               = nl.nl_id
   AND nl.nl_id                 = ngpnl.nl (+)
ORDER BY 1, nl.NL_DSC ASC
;




SELECT  RTRIM(DEALER) AS DEALER, DLR_TP_CD, DLR_CLASS_CD, RTRIM(DLR_NAME) AS DLR_NAME,
        VAT_REG_IND, START_DATE, END_DATE, PHONE_NO, PHONE_NO_2, FAX_NO, NL_CD,
        DPRT_DEPARTMENT_CODE, SALES_AREA, DEALER_TITLE, USER_COMMENTS, VBANK_ACCOUNT,
        AP_ACCOUNT, ADR_ATTENTION, ADR_PRIMARY_LN, ADR_SECONDARY_LN, ADR_CITY,
        ADR_POST_CODE, ADR_COUNTRY, ADR_COUNTY, VAT_REG_NO, CREDIT_TERMS,
        CREDIT_LIMIT, CREDIT_DAYS, DEALER_GROUP, DLR_LONG_NAME, E_MAIL,
        COLLECT_CONN_FEE, COLLECT_DEPOSIT, COLLECT_PREPAYMENT, DEFAULT_PYM_STS
   FROM DEALER_PROFILE@fokus
  WHERE RTRIM(DLR_TP_CD) IN ('1') -- '1' = SalesAgent, '2' = External, '3' = Dummy
--    AND DEALER LIKE '19%' -- 19145
ORDER BY DEALER ASC
;

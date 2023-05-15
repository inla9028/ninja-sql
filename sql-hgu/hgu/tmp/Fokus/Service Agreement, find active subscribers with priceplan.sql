SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.soc_ver_no,
       a.sys_creation_date, a.sys_update_date, a.operator_id,
       a.application_id, a.dl_service_code, a.dl_update_stamp,
       a.campaign_seq, a.campaign, a.commit_orig_no_month,
       a.soc_effective_date, a.customer_id, a.effective_date,
       a.service_type, a.expiration_date, a.soc_level_code,
       a.dealer_code, a.sales_agent, a.effective_issue_date,
       a.expiration_issue_date, a.trx_id, a.ins_trx_id, a.conv_run_no,
       a.loan_ver_no, a.loan_seq_no, a.act_reason_code
  FROM service_agreement a
  WHERE a.expiration_date > SYSDATE
    AND a.service_type    = 'P' -- 'P'riceplan Soc, 'R'egular Soc
--    AND a.soc            IN ('PANA', 'PDEF', 'PFOR', 'PFUB', 'PHIB', 'PNET', 'PPCA', 'PPMA', 'PPMB', 'PPOA', 'PPOB', 'PPOC', 'PPOCSPL1', 'PPOCSPL2', 'PPOD', 'PPOE', 'PPOF', 'PPOG', 'PPTA', 'PPTB', 'PPTC', 'PPTE', 'PPTF', 'PQSFA', 'PQSFB', 'PQSKV', 'PSDH', 'PSFA', 'PSFB', 'PSFF', 'PSFU', 'PSGB', 'PSKV', 'PSUN', 'PTEK', 'PTKP', 'PTMC', 'PTMD')
--    AND a.soc            IN ('PSGB')
    AND a.subscriber_no = 'GSM04791355339' -- PSGB
    

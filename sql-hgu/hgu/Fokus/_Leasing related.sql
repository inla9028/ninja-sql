SELECT * FROM all_tables@fokus a
  WHERE a.table_name LIKE '%LOAN%'


SELECT * FROM soc_loan@fokus a

SELECT a.campaign_seq, a.campaign, a.pp_code, a.min_commit_period,
       a.campaign, a.penalty_amount, a.imei_ind
  FROM campaign_commitments@fokus a
  WHERE a.campaign = 'PKOF12OP'
    AND SYSDATE BETWEEN a.effective_date 
                    AND NVL(a.expiration_date, TO_DATE('4700', 'YYYY'))

/*
rw_change_rating.wf_data_ok:
ls_market_code = gnvuo_app_env.get_market_code()
IF(ls_market_code ='NTC' OR ls_market_code = 'NET') THEN
	IF (ic_loan_ind='Y') THEN
		
		SELECT "CAMPAIGN_COMMITMENTS"."IMEI_IND"
		INTO :ls_imei_ind
		FROM	"CAMPAIGN_COMMITMENTS" 
		WHERE "CAMPAIGN_COMMITMENTS"."CAMPAIGN_SEQ" = :istr_new_pp.campaign_seq AND
		"CAMPAIGN_COMMITMENTS"."CAMPAIGN"= :istr_new_pp.campaign ;
		
		IF ic_loan_ind='Y' AND ls_imei_ind='Y' THEN 
			IF (gnvuo_msg_util.uf_msgbox_code_0(gnvuo_msg_codes.SettleLoanSoc2) <>1) THEN // The subscriber's LOAN Soc will be automatically 															       			                   //settled. Would you like to continue?
				RETURN -1
			END IF
		END IF
		
	END IF//loan_ind
		
 END IF //market_code
END IF
*/

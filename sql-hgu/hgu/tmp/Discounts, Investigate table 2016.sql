/*
** List table - as is.
*/
SELECT a.*
  FROM tmp_disc_missing_campaigns a
ORDER BY a.subscriber_no, a.soc_eff_date, a.soc_exp_date, a.ban
;

/*
** List Individuals which are still active.
*/
SELECT a.*
  FROM tmp_disc_missing_campaigns a
 WHERE a.account_type = 'I'
   AND a.sub_status   = 'A'
ORDER BY a.subscriber_no, a.soc_eff_date, a.soc_exp_date, a.ban
;



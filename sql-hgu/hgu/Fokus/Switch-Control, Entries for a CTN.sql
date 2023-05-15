/*
** SRV_TRX_REPOS - CSM trx status (one trx per incoming CSM trx).
** Indexes:
**    * SRV_TRX_S_NO
**    * SRV_STS_CD
**    * TN (047 prefix)
** The number of sub-transactions are stored in column NO_REL_DEV_TRX.
** Status values (in column SRV_STS_CD) are...:
**  CS: Success
**  CE: Error
**  PE: Pending
** If errors, stored in ERR_CD
*/
SELECT a.*
  FROM srv_trx_repos@fokus a
 WHERE a.tn = '047'||'40000050'
ORDER BY a.srv_trx_s_no
;


SELECT a.srv_trx_s_no, a.issuing_date_time, a.complete_date_time, a.err_date_time
     , a.operator_id, a.user_id, a.tn, a.prev_imsi, a.imsi, a.srv_sts_cd
     , a.err_cd, a.no_rel_dev_trx
  FROM srv_trx_repos@fokus a
 WHERE a.tn = '047'||'40000050'
ORDER BY a.srv_trx_s_no
;

/*
** Via db-link, and with dealer code.
*/
SELECT a.srv_trx_s_no, a.issuing_date_time, a.complete_date_time, a.err_date_time
     , a.operator_id, n.dealer_code, a.user_id, a.tn, a.prev_imsi, a.imsi
     , a.srv_sts_cd, a.err_cd, a.no_rel_dev_trx
  FROM srv_trx_repos@fokus a, ninja_dealer_fokus_user n
 WHERE a.tn = '047'||'40000050'
   AND SUBSTR(a.user_id,0,6) = TO_CHAR(n.fokus_user_id(+))
ORDER BY a.srv_trx_s_no
;




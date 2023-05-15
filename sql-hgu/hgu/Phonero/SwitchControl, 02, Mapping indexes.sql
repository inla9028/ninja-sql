/*
** Q1 - incoming CSM trx queue, if SC is up and running the queue is consumed
**    * SRV_TRX_S_NO
**    * SRV_TRX_TP_CD + SRV_TRX_S_NO
**
** Q1_ALL - all CSM trx received since yesterday
**    * SRV_TRX_S_NO
**
** Q3 - pending network trx queue
**    * SRV_TRX_S_NO + DVC_SFX_NO
**    * TN + PHD_ID + DVC_TRX_STS_CD + SRV_TRX_S_NO
**    * PHD_ID + DVC_TRX_STS_CD + SWPRIORITYFIFO
**    * STARVE_TRX_CNT
**
** SRV_TRX_REPOS - CSM trx status (one trx per incoming CSM trx). Status value are CS (success), CE (Error), PE (pending)
**    * SRV_TRX_S_NO
**    * SRV_STS_CD
**    * TN
**
** DVC_TRX_REPOS - network trx status (many trx per incoming CSM trx)
**    * SRV_TRX_S_NO + DVC_SFX_NO
**    * TN + SYS_CREATION_DATE
**
*/

/*
** Q1 - Pending queue towards switch-control. Consumed when SC is running.
** Indexes:
**    * SRV_TRX_S_NO
**    * SRV_TRX_TP_CD + SRV_TRX_S_NO
*/
SELECT a.*
  FROM q1 a
-- WHERE ROWNUM < 11
;

SELECT COUNT(1) AS "PHONERO_COUNT"
  FROM q1
 WHERE user_id LIKE '402304%' -- Filtering does not work!?!?
;

/*
** Q1_ALL - All CSM trx's since yesterday.
** Indexes:
**    * SRV_TRX_S_NO
** Columns:
**    * USER_ID - The operator id (i.e. 
*/
SELECT a.*
  FROM q1_all a
 WHERE ROWNUM < 11
;

/*
** Q3 - Network trx queue since yesterday.
** Indexes:
**    * SRV_TRX_S_NO + DVC_SFX_NO
**    * TN + PHD_ID + DVC_TRX_STS_CD + SRV_TRX_S_NO
**    * PHD_ID + DVC_TRX_STS_CD + SWPRIORITYFIFO
**    * STARVE_TRX_CNT
*/
SELECT a.*
  FROM q3 a
 WHERE ROWNUM < 11
;

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
  FROM srv_trx_repos a
 WHERE ROWNUM < 11
;

/*
** DVC_TRX_REPOS - Network trx status (many trx per incoming CSM trx)
** Indexes:
**    * SRV_TRX_S_NO + DVC_SFX_NO
**    * TN + SYS_CREATION_DATE
*/
SELECT a.*
  FROM dvc_trx_repos a
 WHERE ROWNUM < 11
;









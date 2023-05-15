/*
From: Dobre, Sorin
Date: Thu 2017-08-17 10:44
Subj: SC Report

Hi Håkan,

Here are the tables you can use for the SC report

Q1 - incoming CSM trx queue, if SC is up and running the queue is consumed
Q1_ALL - all CSM trx received since yesterday
Q3 - pending network trx queue
SRV_TRX_REPOS - CSM trx status (one trx per incoming CSM trx). Status value are CS (success), CE (Error), PE (pending)
DVC_TRX_REPOS - network trx status (many trx per incoming CSM trx)

Regards

*/

/*
** List the size of each table.
*/
SELECT a.owner, a.table_name, a.logging, a.num_rows, a.avg_row_len
  FROM all_tables a
 WHERE a.table_name IN ('Q1', 'Q1_ALL', 'Q3', 'SRV_TRX_REPOS', 'DVC_TRX_REPOS')
ORDER BY a.num_rows
;

/*
** Q1 - Pending queue towards switch-control. Consumed when SC is running.
*/
SELECT a.*
  FROM q1 a
;

/*
** Q1_ALL - All CSM trx's since yesterday.
*/
SELECT a.*
  FROM q1_all a
;

/*
** Q3 - Network trx queue since yesterday.
*/
SELECT a.*
  FROM q3 a
;

/*
** SRV_TRX_REPOS - CSM trx status (one trx per incoming CSM trx).
** The number of sub-transactions are stored in column NO_REL_DEV_TRX.
** Status values (in column SRV_STS_CD) are...:
**  CS: Success
**  CE: Error
**  PE: Pending
** If errors, stored in ERR_CD
*/
SELECT a.*
  FROM srv_trx_repos a
;

-- No sequence accessed from a trigger, calling code must invoke it...
SELECT a.*
  FROM all_sequences a
 WHERE a.last_number BETWEEN (SELECT MAX(srv_trx_s_no) - 1000 FROM srv_trx_repos)
                         AND (SELECT MAX(srv_trx_s_no) + 1000 FROM srv_trx_repos)
ORDER BY 1,2
;

/*
** DVC_TRX_REPOS - Network trx status (many trx per incoming CSM trx)
*/
SELECT a.*
  FROM dvc_trx_repos a
;



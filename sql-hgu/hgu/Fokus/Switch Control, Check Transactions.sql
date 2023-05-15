SELECT * FROM pnp
--where pni = '10284'
where pni_type = 'C'
;


SELECT a.*
  FROM srv_trx_repos@fokus a
 WHERE a.tn IN (
--    '04740722421', '04745264071', '04745265591', '04745267085', '04745287940', '04745281976'
    '047' || '40505666'
   )
ORDER BY a.srv_trx_s_no
;

/*
** Old SQL...
*/
SELECT *
  FROM srvtrx_ftr
 WHERE SRV_TRX_S_NO IN (
    SELECT srv_trx_s_no
      FROM srv_trx_repos
     WHERE tn IN (
         '04798266189'
    )
 )
   AND feature_code = 'I-TB2'
ORDER BY sys_creation_date
;

/*
** New SQL...
*/
SELECT r.tn, f.*
  FROM srvtrx_ftr f, srv_trx_repos r
 WHERE r.tn          IN ( '04798266189' )
   AND r.srv_trx_s_no = f.srv_trx_s_no
   AND f.feature_code = 'I-TB2'
ORDER BY f.sys_creation_date
;

/*
** Via db-link
*/
SELECT r.tn, f.*
  FROM srvtrx_ftr@fokus f, srv_trx_repos@fokus r
 WHERE r.tn          IN ( '04798266189' )
   AND r.srv_trx_s_no = f.srv_trx_s_no
   AND f.feature_code = 'I-TB2'
ORDER BY f.sys_creation_date
;

/*
Here are the tables you can use for the SC report

Q1 - incoming CSM trx queue, if SC is up and running the queue is consumed
Q1_ALL - all CSM trx received since yesterday
Q3 - pending network trx queue
SRV_TRX_REPOS - CSM trx status (one trx per incoming CSM trx). Status value are CS (success), CE (Error), PE (pending)
DVC_TRX_REPOS - network trx status (many trx per incoming CSM trx)

Regards
Sorin
*/

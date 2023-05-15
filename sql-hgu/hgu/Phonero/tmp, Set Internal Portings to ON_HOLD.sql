SELECT a.status, a.ninja_ref_id, a.nrdb_ref_id, a.user_id, a.ctn, a.ban,
       a.number_owner_code, a.donor_code, a.recipient_code,
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.description, a.action, a.proc_attempts,
       a.ninja_action, a.dealer_code, a.sales_agent
  FROM ninja_time_port a
 WHERE a.ctn IN (
        '047' || '40019651',
        '047' || '45238433',
        '047' || '45241571',
        '047' || '45237512',
        '047' || '45242213',
        '047' || '40620437',
        '047' || '45243284',
        '047' || '45244615',
        '047' || '45245587',
        '047' || '45246750',
        '047' || '45249467',
        '047' || '45250852',
        '047' || '48861781'
     )
   AND a.user_id     = 'Phonero'
ORDER BY a.ctn, a.date_time_port
;

UPDATE ninja_time_port a
   SET a.status = 'ON_HOLD', a.description = NULL, a.proc_attempts = 0
 WHERE a.ctn IN (
        '047' || '40019651',
        '047' || '45238433',
        '047' || '45241571',
        '047' || '45237512',
        '047' || '45242213',
        '047' || '40620437',
        '047' || '45243284',
        '047' || '45244615',
        '047' || '45245587',
        '047' || '45246750',
        '047' || '45249467',
        '047' || '45250852',
        '047' || '48861781'
    )
   AND a.date_time_port BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE + 1)
   AND a.status         = 'WAITING'
   AND a.user_id        = 'Phonero'
;


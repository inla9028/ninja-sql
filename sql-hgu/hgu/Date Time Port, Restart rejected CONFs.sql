SELECT a.ctn, a.donor_code, a.recipient_code,
       a.date_time_created, a.date_time_port,
       a.action, a.ninja_action, a.proc_attempts,
       a.status, a.description
  FROM ninja_time_port a
 WHERE (a.ctn, a.ninja_ref_id) IN
           (SELECT b.ctn, MAX(b.ninja_ref_id)
              FROM ninja_time_port b
             WHERE b.ninja_action NOT IN ('CANCEL')
               AND b.ctn IN (
                        '04799441991',
                        '04740566940',
                        '04797362659',
                        '04794814224'
               )
            GROUP BY b.ctn)
ORDER BY a.date_time_port
;

UPDATE ninja_time_port ntp
   SET ntp.action        = 'CONF',
       ntp.description   = NULL,
       ntp.status        = 'WAITING',
       ntp.proc_attempts = 0
 WHERE (ntp.ctn, ntp.ninja_ref_id) IN
           (SELECT a.ctn, MAX(a.ninja_ref_id)
              FROM ninja_time_port a
             WHERE a.ninja_action NOT IN ('CANCEL')
               AND a.ctn IN (
                        '04799441991',
                        '04740566940',
                        '04797362659',
                        '04794814224'
               )
            GROUP BY a.ctn)
   AND ntp.action IN ('MOVE', 'CONF')
;

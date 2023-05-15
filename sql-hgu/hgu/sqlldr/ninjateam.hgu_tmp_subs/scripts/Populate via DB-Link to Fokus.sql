-- Clear table...
/*
DELETE 
  FROM ninjateam.hgu_tmp_subs
;
*/


-- Update status.
UPDATE ninjateam.hgu_tmp_subs t2
   SET t2.param3 = (SELECT /*+ driving_site(s)*/ s.sub_status
                      FROM subscriber@fokus s
                     WHERE s.subscriber_no = t2.subscriber_no
                       AND s.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                                                FROM subscriber@fokus b
                                               WHERE b.subscriber_no = s.subscriber_no))
;

-- Update names...
UPDATE ninjateam.hgu_tmp_subs t2
   SET t2.param4 = (SELECT /*+ driving_site(s)*/ nd.name_format
                      FROM subscriber@fokus        s
                         , address_name_link@fokus anl
                         , name_data@fokus         nd
                     WHERE s.subscriber_no    = t2.subscriber_no
                       AND s.cnt_seq_no       = (SELECT MAX(s2.cnt_seq_no)
                                                  FROM subscriber@fokus s2
                                                 WHERE s2.subscriber_no = s.subscriber_no)
                       AND anl.ban            = s.customer_id 
                       AND anl.subscriber_no  = s.subscriber_no
                       AND anl.link_type      = 'U'
                       AND SYSDATE      BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
                       AND anl.name_id        = nd.name_id)
     , t2.param5 = (SELECT /*+ driving_site(s)*/ nd.first_name
                      FROM subscriber@fokus        s
                         , address_name_link@fokus anl
                         , name_data@fokus         nd
                     WHERE s.subscriber_no    = t2.subscriber_no
                       AND s.cnt_seq_no       = (SELECT MAX(s2.cnt_seq_no)
                                                  FROM subscriber@fokus s2
                                                 WHERE s2.subscriber_no = s.subscriber_no)
                       AND anl.ban            = s.customer_id 
                       AND anl.subscriber_no  = s.subscriber_no
                       AND anl.link_type      = 'U'
                       AND SYSDATE      BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
                       AND anl.name_id        = nd.name_id)
     , t2.param6 = (SELECT /*+ driving_site(s)*/ nd.last_business_name
                      FROM subscriber@fokus        s
                         , address_name_link@fokus anl
                         , name_data@fokus         nd
                     WHERE s.subscriber_no    = t2.subscriber_no
                       AND s.cnt_seq_no       = (SELECT MAX(s2.cnt_seq_no)
                                                  FROM subscriber@fokus s2
                                                 WHERE s2.subscriber_no = s.subscriber_no)
                       AND anl.ban            = s.customer_id 
                       AND anl.subscriber_no  = s.subscriber_no
                       AND anl.link_type      = 'U'
                       AND SYSDATE      BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
                       AND anl.name_id        = nd.name_id)
  WHERE t2.param3 IN ( 'A', 'R', 'S' )
;


-- BAN type...
UPDATE ninjateam.hgu_tmp_subs t2
   SET t2.param7 = (SELECT /*+ driving_site(b)*/
                           b.account_type || '/' || b.account_sub_type
                      FROM billing_account@fokus b, subscriber@fokus A
                    WHERE a.subscriber_no = t2.subscriber_no
                      AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                                               FROM subscriber@fokus b
                                              WHERE b.subscriber_no = A.subscriber_no)
                      AND a.customer_id   = b.ban)
;

COMMIT WORK
;                           

SELECT t2.*
  FROM ninjateam.hgu_tmp_subs t2
ORDER BY t2.subscriber_no ASC, t2.sub_status
;

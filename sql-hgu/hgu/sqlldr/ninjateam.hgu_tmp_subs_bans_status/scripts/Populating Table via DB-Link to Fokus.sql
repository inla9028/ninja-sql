-- Clear table...
/*
DELETE 
  FROM ninjateam.hgu_tmp_subs_bans_status
;
*/

-- Clean the old information, since we're about to refresh anyway.
UPDATE ninjateam.hgu_tmp_subs_bans_status t2
   SET t2.ban            = NULL
     , t2.acc_type       = NULL
     , t2.acc_sub_type   = NULL
     , t2.sub_status     = NULL
     , t2.dealer_code    = NULL
;

-- Update BAN info for non-cancelled subscriptions.
UPDATE ninjateam.hgu_tmp_subs_bans_status t2
   SET t2.ban          = (SELECT b.ban              FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.cnt_seq_no = (SELECT MAX(s2.cnt_seq_no) FROM subscriber@fokus s2 WHERE s2.subscriber_no = s.subscriber_no))
     , t2.acc_type     = (SELECT b.account_type     FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.cnt_seq_no = (SELECT MAX(s2.cnt_seq_no) FROM subscriber@fokus s2 WHERE s2.subscriber_no = s.subscriber_no))
     , t2.acc_sub_type = (SELECT b.account_sub_type FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.cnt_seq_no = (SELECT MAX(s2.cnt_seq_no) FROM subscriber@fokus s2 WHERE s2.subscriber_no = s.subscriber_no))
;

-- Update BAN info for cancelled subscriptions.
--UPDATE ninjateam.hgu_tmp_subs_bans_status t2
--   SET t2.ban          = (SELECT b.ban              FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.sub_status = 'C' AND t2.ban IS NULL AND 1 = (SELECT COUNT(1) FROM subscriber@fokus s2 WHERE s2.subscriber_no = s.subscriber_no AND s2.sub_status = 'C'))
--     , t2.acc_type     = (SELECT b.account_type     FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.sub_status = 'C' AND t2.ban IS NULL AND 1 = (SELECT COUNT(1) FROM subscriber@fokus s2 WHERE s2.subscriber_no = s.subscriber_no AND s2.sub_status = 'C'))
--     , t2.acc_sub_type = (SELECT b.account_sub_type FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND s.sub_status = 'C' AND t2.ban IS NULL AND 1 = (SELECT COUNT(1) FROM subscriber@fokus s2 WHERE s2.subscriber_no = s.subscriber_no AND s2.sub_status = 'C'))
--;


-- Update status.
UPDATE ninjateam.hgu_tmp_subs_bans_status t2
   SET t2.sub_status      = (SELECT s.sub_status      FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
     , t2.sub_status_date = (SELECT s.sub_status_date FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
;

-- Update dealer and sales agent...
UPDATE ninjateam.hgu_tmp_subs_bans_status t2
   SET t2.dealer_code = (SELECT s.dealer_code FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
;

COMMIT WORK
;                           

SELECT t2.*
  FROM ninjateam.hgu_tmp_subs_bans_status t2
ORDER BY t2.subscriber_no ASC, t2.sub_status
;

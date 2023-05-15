-- Clean the old information, since we're about to refresh anyway.
UPDATE hgu_tmp_tele2 t2
   SET t2.ban            = NULL
     , t2.acc_type       = NULL
     , t2.acc_sub_type   = NULL
     , t2.sub_status     = NULL
     , t2.priceplan      = NULL
     , t2.soc_old        = NULL
     , t2.soc_new        = NULL
     , t2.dealer_code    = NULL
     , t2.sales_agent    = NULL
     , t2.job1_status    = NULL
     , t2.job2_status    = NULL
     , t2.job3_status    = NULL
     , t2.process_status = NULL
     , t2.process_time   = NULL
     , t2.memo_text      = NULL
;

-- Update BAN info.
UPDATE hgu_tmp_tele2 t2
   SET t2.ban          = (SELECT b.ban              FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND b.account_type = 'I' AND b.account_sub_type IN ('T2', 'TX') AND s.sub_status NOT IN ('C'))
     , t2.acc_type     = (SELECT b.account_type     FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND b.account_type = 'I' AND b.account_sub_type IN ('T2', 'TX') AND s.sub_status NOT IN ('C'))
     , t2.acc_sub_type = (SELECT b.account_sub_type FROM billing_account@fokus b, subscriber@fokus s WHERE s.subscriber_no IN (t2.subscriber_no) AND s.customer_id = b.ban AND b.account_type = 'I' AND b.account_sub_type IN ('T2', 'TX') AND s.sub_status NOT IN ('C'))
;

-- Update status
UPDATE hgu_tmp_tele2 t2
   SET t2.sub_status = (SELECT s.sub_status FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
;

-- Update priceplan
UPDATE hgu_tmp_tele2 t2
   SET t2.priceplan = (SELECT RTRIM(sa.soc) FROM service_agreement@fokus sa WHERE t2.ban IS NOT NULL AND sa.ban = t2.ban AND sa.subscriber_no = t2.subscriber_no AND sa.service_type = 'P' AND SYSDATE BETWEEN sa.effective_date AND nvl(sa.expiration_date, SYSDATE + 1))
;

-- Update traffic-shaping soc
UPDATE hgu_tmp_tele2 t2
   SET t2.soc_old = (SELECT RTRIM(sa.soc) FROM service_agreement@fokus sa WHERE t2.ban IS NOT NULL AND sa.ban = t2.ban AND sa.subscriber_no = t2.subscriber_no AND sa.service_type = 'R' AND SYSDATE BETWEEN sa.effective_date AND nvl(sa.expiration_date, SYSDATE + 1) AND sa.soc LIKE 'NSHAPE%')
;

-- Update dealer and sales agent...
UPDATE hgu_tmp_tele2 t2
   SET t2.dealer_code = (SELECT s.dealer_code FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
     , t2.sales_agent = (SELECT s.sales_agent FROM subscriber@fokus s WHERE t2.ban IS NOT NULL AND s.customer_id = t2.ban AND s.subscriber_no = t2.subscriber_no)
;

-- Update new soc
UPDATE hgu_tmp_tele2 t2
   SET t2.soc_new = decode(t2.priceplan,
                           'PPBC', 'NSHAPE37',
                           'PPBD', 'NSHAPE37',
                           'PPBE', 'NSHAPE37',
                           'PPUR', 'NSHAPE38',
                           'PPUS', 'NSHAPE39',
                           'PPBF', 'NSHAPE41',
                           'PPBA', 'NSHAPE41', 
                           'PPBB', 'NSHAPE41',
                           NULL)
 WHERE t2.priceplan  IS NOT NULL
   AND t2.ban        IS NOT NULL
   AND t2.sub_status IN ('A', 'R')
;

COMMIT WORK
;                           


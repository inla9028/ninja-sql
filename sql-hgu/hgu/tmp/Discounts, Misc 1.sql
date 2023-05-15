SELECT s.*
  FROM tmp_disc_subscribers s
 WHERE s.subscriber_no IN ('GSM047' || '92415158')
   AND s.effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD')
ORDER BY s.subscriber_no, s.ban
;

SELECT d.*
  FROM tmp_disc_ban_discount d
 WHERE d.subscriber_no IN ('GSM047' || '92415158')
   AND d.effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD')
;

SELECT d.*
  FROM mdcust_ny.ban_discount@wh10p d
 WHERE d.subscriber_no = 'GSM047' || '92415158'
;

SELECT d.*
  FROM ban_discount@fokus d
 WHERE d.ban           = 765037015
   AND d.subscriber_no = 'GSM047' || '92415158'
;

SELECT s.ban, s.subscriber_no, s.sub_status, s.soc, s.service_type, c.price_plan
     , c.price_plan_desc, s.campaign , c.campaign_desc, s.effective_date AS "SOC_EFF_DATE"
     , s.expiration_date AS "SOC_EXP_DATE", s.commit_start_date, s.commit_end_date
     , c.keep_discount_ind, c.campaign_seq, c.effective_date AS "CAMP_EFF_DATE"
     , c.expiration_date AS "CAMP_EXP_DATE"
  FROM tmp_disc_subscribers s, tmp_disc_campaigns c
 WHERE s.subscriber_no IN ('GSM047' || '92415158')
   AND s.campaign = c.campaign
   AND s.effective_date BETWEEN c.effective_date AND c.expiration_date
   AND s.effective_date BETWEEN s.commit_start_date AND s.commit_end_date
   AND s.effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD')
   AND NOT EXISTS (
        SELECT ''
          FROM tmp_disc_ban_discount d
         WHERE s.ban            = d.ban
           AND s.subscriber_no  = d.subscriber_no
           AND s.campaign       = d.campaign
           -- AND s.effective_date = d.effective_date
           AND s.effective_date BETWEEN d.effective_date AND d.expiration_date
   )
ORDER BY s.subscriber_no, s.effective_date, s.expiration_date, s.ban
;

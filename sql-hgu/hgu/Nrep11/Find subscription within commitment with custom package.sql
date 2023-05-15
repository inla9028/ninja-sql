SELECT s.subscriber_no, s.customer_id, s.sub_status, s.commit_start_date, s.commit_end_date
     , a.soc, a.campaign_seq, a.campaign, a.commit_orig_no_month
  FROM subscriber s, service_agreement a
 WHERE s.sub_status    = 'A'
   AND SYSDATE   BETWEEN s.commit_start_date AND NVL(s.commit_end_date, SYSDATE - 1)
   AND s.commit_orig_no_month > 0
   AND s.customer_id   = a.ban
   AND s.subscriber_no = a.subscriber_no
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.service_type  = 'P'
   AND a.campaign      = '000000000'
   AND ROWNUM < 11
;
/*
GSM04792484312      266030014   A   2017-08-21              PSJL        -1  000000000   0
GSM047580009052573  736136318   A   2017-08-30              PSOD        -1  000000000   0
GSM04799382065      100014901   A   2017-03-21  2018-03-20  PPEF        -1  000000000   0
GSM04740640186      121308217   A   2016-10-17              PTTB        -1  000000000   0
CDA04766971918      386502314   A   2016-10-17              PCFI        -1  000000000   0
CDA04766971914      386502314   A   2016-10-17              PCFI        -1  000000000   0
CDA04766971915      386502314   A   2016-10-17              PCFI        -1  000000000   0
CDA04766971916      386502314   A   2016-10-17              PCFI        -1  000000000   0
CDA04766971917      386502314   A   2016-10-17              PCFI        -1  000000000   0
GSM04797196416      882907314   A   2017-11-29              PW10        -1  000000000   0
*/

SELECT a.*
  FROM service_agreement a
;

SELECT a.*
  FROM subscriber a
;

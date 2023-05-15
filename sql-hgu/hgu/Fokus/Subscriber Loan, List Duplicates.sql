SELECT UNIQUE s.subscriber_no, s.subscriber_id, l1.soc
     , l1.loan_seq_no AS "SEQ_1", l1.sys_creation_date AS "DATE_1"
     , l2.loan_seq_no AS "SEQ_2", l2.sys_creation_date AS "DATE_2"
  FROM subscriber_loan l1, subscriber_loan l2, subscriber s
 WHERE l1.effective_date  > TO_DATE('2019-01-27', 'YYYY-MM-DD')
   AND l1.subscriber_id   = l2.subscriber_id
   AND l1.soc             = l2.soc
   AND l1.loan_seq_no + 1 = l2.loan_seq_no
   AND l2.subscriber_id   = s.subscriber_id
   AND s.sub_status      IN ('A', 'R', 'S')
ORDER BY 1,2,3

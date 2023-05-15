/*
** List the memos for the last/current month for the subscribers missing one of
** the targeted socs.
*/
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt, m.*
 FROM memo@fokus m, users@fokus u
  WHERE 1 = 1
    AND m.operator_id     = u.user_id(+)
--    AND m.memo_date       > TRUNC(SYSDATE, 'MON')
    AND m.memo_date       > TRUNC(SYSDATE - 30)
    AND (m.memo_ban, m.memo_subscriber) IN (
        SELECT UNIQUE ban, subscriber_no
          FROM tmp_mctb_missing_soc
        UNION
        SELECT UNIQUE ban, REPLACE(subscriber_no, 'GSM', '')
          FROM tmp_mctb_missing_soc
    )
  ORDER BY m.memo_ban, m.memo_subscriber, m.memo_date
;

/*
** List all existing socs for the subscribers missing one of the targeted socs.
*/
SELECT  /*+ parallel(sa3 , 6 )*/
        /*+ parallel(s , 6 )*/
        sa3.ban, sa3.subscriber_no, RTRIM(sa3.soc) soc, sa3.effective_date,
        sa3.service_type, s.sub_status, sa3.expiration_date, s.original_init_date
   FROM service_agreement@wh10p sa3, mdcust_ny.subscriber@wh10p s
  WHERE 1 = 1
    AND s.SUB_STATUS IN ( 'A', 'R' )
    AND sa3.expiration_date > SYSDATE + 1000
/*    AND RTRIM(sa3.soc) IN ( 'PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE', 'MCTB1',
                            'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE', 'MCTBCHG1')
*/    AND s.subscriber_no = sa3.subscriber_no
    AND s.customer_id   = sa3.ban
    AND (sa3.ban, sa3.subscriber_no) IN (
        SELECT ban, subscriber_no
          FROM tmp_mctb_missing_soc
    )
ORDER BY sa3.ban, sa3.subscriber_no, RTRIM(sa3.soc)
;


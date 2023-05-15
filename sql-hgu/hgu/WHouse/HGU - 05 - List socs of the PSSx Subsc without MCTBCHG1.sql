/*
** List 25 subscribers without the MCTBCHG1 soc.
*/
SELECT *
  FROM tmp_hgu_missing_soc ms
 WHERE 1 = 1
   AND ROWNUM < 26
ORDER BY ms.prisplan, ms.subscriber_no
;

/*
** Display overview of the subscribers without the MCTBCHG1 soc.
*/
SELECT ms.prisplan, ms.sub_status, COUNT(*) AS "COUNT"
  FROM tmp_hgu_missing_soc ms
GROUP BY ms.prisplan, ms.sub_status
ORDER BY ms.prisplan, ms.sub_status
;

/*
** Display the actual socs of the subscribers without the MCTBCHG1 soc.
*/
SELECT  /*+ parallel(sa3 , 6 )*/
        /*+ parallel(s , 6 )*/
        sa3.ban, sa3.subscriber_no, RTRIM(sa3.soc) soc, sa3.effective_date,
        sa3.service_type, s.sub_status, sa3.expiration_date, s.original_init_date
   FROM service_agreement@wh10p sa3, mdcust_ny.subscriber@wh10p s
  WHERE 1 = 1
    AND s.SUB_STATUS IN ( 'A', 'R' )
    AND sa3.expiration_date > SYSDATE + 1000
--    AND RTRIM(sa3.soc) IN ( 'PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE', 'MCTB1',
--                            'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE', 'MCTBCHG1')
    AND s.subscriber_no = sa3.subscriber_no
    AND s.customer_id   = sa3.ban
    AND (sa3.ban, sa3.subscriber_no) IN (
        SELECT ban, subscriber_no
          FROM tmp_hgu_missing_soc
    )
ORDER BY sa3.ban, sa3.subscriber_no, RTRIM(sa3.soc)
;

--==
--== Locate all subscriptions that has the same soc twice...
--== Last time (2009-10-28) this query took 3457,80 seconds to execute.
--==
SELECT a.ban, a.subscriber_no, RTRIM(a.soc) AS "SOC",
       a.effective_date AS "START_DATE_1", a.expiration_date AS "END_DATE_1",
       b.effective_date AS "START_DATE_2", b.expiration_date AS "END_DATE_2"
  FROM dd.service_agreement a, dd.service_agreement b
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND a.ban = b.ban
    AND a.subscriber_no = b.subscriber_no
    AND RTRIM(a.soc) = RTRIM(b.soc)
    AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
    AND a.ROWID != b.ROWID
  ORDER BY a.ban, a.subscriber_no, a.soc, a.effective_date;


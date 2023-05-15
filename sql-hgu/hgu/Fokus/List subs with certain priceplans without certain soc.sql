SELECT s.subscriber_no, s.sub_status, RTRIM(sa1.soc) AS "PP_SOC", ba.bill_cycle
  FROM subscriber s, service_agreement sa1, billing_account ba
 WHERE RTRIM(sa1.soc) IN ('PMBQ', 'PMAE') -- With these priceplans
   AND SYSDATE BETWEEN sa1.effective_date AND NVL(sa1.expiration_date, SYSDATE + 1)
   AND sa1.subscriber_no = s.subscriber_no
   AND s.sub_status      = 'A'
   AND 0                 = (SELECT COUNT(1)
                              FROM service_agreement sa2
                             WHERE sa2.ban           = sa1.ban
                               AND sa2.subscriber_no = sa1.subscriber_no
                               AND RTRIM(sa2.soc)   IN ('NSHAPE86') -- Not with this soc
                               AND SYSDATE     BETWEEN sa2.effective_date AND NVL(sa2.expiration_date, SYSDATE + 1))
   AND sa1.ban           = ba.ban
--   AND ba.bill_cycle     = 7 -- And with this bill-cycle
;

SELECT ba.*
  FROM billing_account ba
;

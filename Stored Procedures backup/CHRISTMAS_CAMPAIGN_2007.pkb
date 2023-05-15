CREATE OR REPLACE PACKAGE BODY NINJAMAIN.CHRISTMAS_CAMPAIGN_2007 AS
PROCEDURE POPULATE_SERVICE_TRANSACTIONS IS

CURSOR c1 IS

SELECT a.ban, a.subscriber_no, a.dealer_code, a.sales_agent, cs.soc
  FROM subscriber@nrep11 s, service_agreement@nrep11 a, campaign_soc_coexistance cs
 WHERE a.service_type    = 'P'
   AND a.effective_date >= cs.effective_date
   AND a.expiration_date > sysdate
   AND SYSDATE     BETWEEN cs.effective_date and cs.expiration_date
   AND RTRIM(a.campaign) = cs.campaign
   AND s.subscriber_no   = a.subscriber_no
   AND s.customer_id     = a.ban
   AND s.sub_status      = 'A'
   AND NOT EXISTS (
      SELECT '' FROM service_agreement@nrep11 b
       WHERE b.ban           = a.ban
         AND b.subscriber_no = a.subscriber_no
         AND RTRIM(b.soc)    = cs.soc
         AND SYSDATE   BETWEEN b.effective_date AND b.expiration_date
    );

coursor_row c1%ROWTYPE;

BEGIN
    FOR coursor_row IN c1 LOOP
        INSERT INTO service_transactions VALUES(
            NULL,
            coursor_row.subscriber_no,
            coursor_row.soc,
            'ADD',
            NULL,
            NULL,
            NULL,
            'WAITING',
            NULL,
            coursor_row.dealer_code,
            coursor_row.sales_agent,
            1,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL
        );
        COMMIT;
    END LOOP;

END POPULATE_SERVICE_TRANSACTIONS;
END CHRISTMAS_CAMPAIGN_2007;
/
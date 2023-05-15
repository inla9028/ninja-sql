/*
** Create a local temporary table with the BAN of the subscribers 
** we processed during the TB conversion...
*/
CREATE TABLE tmp_hgu_pp_combo
NOLOGGING
AS
    (SELECT /*+ parallel(sa3 , 6 )*/
            /*+ parallel(s , 6 )*/
            sa3.ban,
            sa3.subscriber_no,
            RTRIM (sa3.soc) soc,
            sa3.effective_date,
            sa3.service_type,
            sa3.expiration_date,
            s.original_init_date
       FROM mdcust_ny.service_agreement@wh10p sa3,
            mdcust_ny.subscriber@wh10p s
      WHERE     1 = 1
            AND s.sub_status = 'A'
            AND s.customer_id = sa3.ban
            AND s.subscriber_no = sa3.subscriber_no
            AND sa3.expiration_date > SYSDATE + 1000
            AND sa3.service_type = 'P'
            AND sa3.subscriber_no IN
                    (SELECT mt.subscriber_no
                       FROM ninjadata.master_transactions mt
                      WHERE mt.request_id = 'TB 2014-06-18'
                            AND mt.process_status = 'PRSD_SUCCESS'));
COMMIT;

CREATE INDEX tmp_hgu_pp_combo_index
    ON tmp_hgu_pp_combo (ban, subscriber_no);

COMMIT;

/*
** Display 25 if not more rows from the table.
*/
SELECT *
  FROM tmp_hgu_pp_combo pp
 WHERE 1 = 1
   AND ROWNUM < 26
;

/*
** Join the new table with a few Fokus-tables to list the CUG and VPNs.
*/
SELECT UNIQUE
       t1.ban,
       nd.identify AS "ORG_NUMBER",
       pp.pni,
       DECODE (pp.pni_type,  'C', 'CUG',  'V', 'VPN',  pp.pni_type) AS "PNI_TYPE",
       pp.pnp_desc
  --       , nd.*
  FROM tmp_hgu_pp_combo t1,
       address_name_link@fokus anl,
       name_data@fokus nd,
       pnp@fokus pp
 WHERE 1 = 1
--       AND t1.ban = 471891705
       AND t1.ban = anl.ban
       AND SYSDATE BETWEEN anl.effective_date
                       AND NVL (anl.expiration_date, SYSDATE + 1000)
       AND anl.link_type         = 'L'
       AND anl.name_id           = nd.name_id
       AND nd.last_business_name = pp.pnp_desc
--       AND ROWNUM < 26
ORDER BY t1.ban, nd.identify, "PNI_TYPE";

/*
** Eventually drop the table.
*/
DROP TABLE tmp_hgu_pp_combo;
COMMIT;

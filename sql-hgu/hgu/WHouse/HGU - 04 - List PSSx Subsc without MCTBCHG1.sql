-- Create temp table for priceplans

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
            s.sub_status,
            sa3.expiration_date,
            s.original_init_date
       FROM mdcust_ny.service_agreement@wh10p sa3,
            mdcust_ny.subscriber@wh10p s
      WHERE     1 = 1
      AND s.subscriber_no = 'GSM04740413756'
            AND s.sub_status IN ('A', 'R')
            AND s.customer_id = sa3.ban
            AND s.subscriber_no = sa3.subscriber_no
            AND sa3.expiration_date > SYSDATE + 1000
            AND RTRIM (sa3.soc) IN ('PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE'));

COMMIT;

CREATE INDEX tmp_hgu_pp_combo_index
    ON tmp_hgu_pp_combo (ban, subscriber_no);

COMMIT;



-- create temp tables for SOC

CREATE TABLE tmp_hgu_soc_combo
AS
    (SELECT /*+ parallel(sa3 , 6 )*/
            /*+ parallel(s , 6 )*/
            sa3.ban,
            sa3.subscriber_no,
            RTRIM (sa3.soc) soc,
            sa3.effective_date,
            sa3.service_type,
            s.sub_status,
            sa3.expiration_date,
            s.original_init_date
       FROM service_agreement@wh10p sa3, mdcust_ny.subscriber@wh10p s
      WHERE     1 = 1
            AND s.sub_status IN ('A', 'R')
            AND sa3.expiration_date > SYSDATE + 1000
            AND RTRIM (sa3.soc) IN ('MCTBCHG1', 'MCTBFREE')
            AND s.subscriber_no = sa3.subscriber_no
            AND s.customer_id = sa3.ban
            AND (sa3.ban, sa3.subscriber_no) IN
                    (SELECT ban, subscriber_no FROM tmp_hgu_pp_combo));


COMMIT;

CREATE INDEX tmp_hgu_soc_combo_index
    ON tmp_hgu_soc_combo (ban, subscriber_no, soc);

COMMIT;

-- Combining the two tables.

DROP TABLE tmp_hgu_missing_soc;
COMMIT;

CREATE TABLE tmp_hgu_missing_soc
AS
    (--SOC-combinasion
     -- By Grouping
     -- See below for single subscribers
    SELECT /*+ parallel(sa1 , 6 )*/
           /*+ parallel(sa2, 6 )*/
           sa2.ban,
           sa2.subscriber_no,
           sa2.soc prisplan,
           s2.soc_description beskrivelse_pp,
           sa2.sub_status
      FROM tmp_hgu_pp_combo sa2, refwh02.soc@wh10p s2
     WHERE     1 = 1
           AND RTRIM (sa2.soc) = RTRIM (s2.soc)
           AND s2.expiration_date IS NULL
           AND sa2.expiration_date > SYSDATE + 1000
           AND (SELECT COUNT(1)
                   FROM tmp_hgu_soc_combo sc
                  WHERE sa2.ban           = sc.ban
                    AND sa2.subscriber_no = sc.subscriber_no) < 2);

COMMIT;

CREATE INDEX tmp_hgu_missing_soc_index
    ON tmp_hgu_missing_soc (ban, subscriber_no, sub_status);

COMMIT;

-- select  count(*) from tmp_hgu_soc_combo

-- Deleting large temporary work tables

DROP TABLE tmp_hgu_pp_combo;
COMMIT;

DROP TABLE tmp_hgu_soc_combo;
COMMIT;


SELECT ms.*
  FROM tmp_hgu_missing_soc ms
 WHERE 1 = 1 AND ROWNUM < 26
ORDER BY ms.prisplan;

SELECT ms.prisplan, ms.sub_status, COUNT (*) AS "COUNT"
  FROM tmp_hgu_missing_soc ms
GROUP BY ms.prisplan, ms.sub_status
ORDER BY ms.prisplan, ms.sub_status;


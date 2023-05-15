/*
** Create temp table for the specific set of priceplans (PSS[A-E]).
*/
CREATE TABLE tmp_mctb_pp_combo
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
            AND s.sub_status IN ('A', 'R')
            AND s.customer_id = sa3.ban
            AND s.subscriber_no = sa3.subscriber_no
            AND sa3.expiration_date > SYSDATE + 1000
            AND RTRIM (sa3.soc) IN ('PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE'));

COMMIT;

CREATE INDEX tmp_mctb_pp_combo_index
    ON tmp_mctb_pp_combo (ban, subscriber_no);

COMMIT;


/*
** create temp tables for the SOCs we're interested in (MCTBCHG1 & MCTBFREE)
*/
CREATE TABLE tmp_mctb_soc_combo
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
                    (SELECT ban, subscriber_no FROM tmp_mctb_pp_combo));


COMMIT;

CREATE INDEX tmp_mctb_soc_combo_index
    ON tmp_mctb_soc_combo (ban, subscriber_no, soc);

COMMIT;

/*
** Combine the two tables: Since all subscribers listed in the table
** "tmp_mctb_pp_combo" should have both socs (MCTBCHG1 & MCTBFREE), we can just
** check if they have less than two rows in the table "tmp_mctb_soc_combo"
**
** Note! This "drop" will fail the first time this script is used as the table
** does not yet exist. Just skip it then, and proceed with the next steps.
*/
DROP TABLE tmp_mctb_missing_soc;
COMMIT;

CREATE TABLE tmp_mctb_missing_soc
AS
    (
    SELECT /*+ parallel(sa1 , 6 )*/
           /*+ parallel(sa2, 6 )*/
           sa2.ban,
           sa2.subscriber_no,
           sa2.soc prisplan,
           s2.soc_description beskrivelse_pp,
           sa2.sub_status
      FROM tmp_mctb_pp_combo sa2, refwh02.soc@wh10p s2
     WHERE     1 = 1
           AND RTRIM (sa2.soc) = RTRIM (s2.soc)
           AND s2.expiration_date IS NULL
           AND sa2.expiration_date > SYSDATE + 1000
           AND (SELECT COUNT(1)
                   FROM tmp_mctb_soc_combo sc
                  WHERE sa2.ban           = sc.ban
                    AND sa2.subscriber_no = sc.subscriber_no) < 2);

COMMIT;

CREATE INDEX tmp_mctb_missing_soc_index
    ON tmp_mctb_missing_soc (ban, subscriber_no, sub_status);

COMMIT;


/*
** Drop the temporary work tables.
*/
DROP TABLE tmp_mctb_pp_combo;
COMMIT;

DROP TABLE tmp_mctb_soc_combo;
COMMIT;


/*
** List 25 subscribers without the MCTBCHG1 or MCTBFREE soc.
*/
SELECT *
  FROM tmp_mctb_missing_soc ms
 WHERE 1 = 1
--   AND ROWNUM < 26
ORDER BY ms.prisplan, ms.subscriber_no
;

/*
** Display overview of the subscribers without the MCTBCHG1 or MCTBFREE soc.
*/
SELECT ms.prisplan, ms.sub_status, COUNT(*) AS "COUNT"
  FROM tmp_mctb_missing_soc ms
GROUP BY ms.prisplan, ms.sub_status
ORDER BY ms.prisplan, ms.sub_status
;

/*
** Display the actual MCTB-socs of the subscribers without the MCTBCHG1 or
** MCTBFREE soc.
*/
SELECT  /*+ parallel(sa3 , 6 )*/
        /*+ parallel(s , 6 )*/
        sa3.ban, sa3.subscriber_no, RTRIM(sa3.soc) soc, sa3.effective_date,
        sa3.service_type, s.sub_status, sa3.expiration_date, s.original_init_date
   FROM service_agreement@wh10p sa3, mdcust_ny.subscriber@wh10p s
  WHERE 1 = 1
    AND s.SUB_STATUS IN ( 'A', 'R' )
    AND sa3.expiration_date > SYSDATE + 1000
    AND RTRIM(sa3.soc) IN ( 'PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE', 'MCTB1',
                            'MCTB2', 'MCTB3', 'MCTB4', 'MCTB5', 'MCTBFREE', 'MCTBCHG1')
    AND s.subscriber_no = sa3.subscriber_no
    AND s.customer_id   = sa3.ban
    AND (sa3.ban, sa3.subscriber_no) IN (
        SELECT ban, subscriber_no
          FROM tmp_mctb_missing_soc
    )
ORDER BY sa3.ban, sa3.subscriber_no, RTRIM(sa3.soc)
;

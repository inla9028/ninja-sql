/*
** Create temp table for the specific set of campaigns... (PSS[A-E]).
*/
CREATE TABLE tmp_disc_subscribers
NOLOGGING
AS
    (SELECT /*+ parallel(sa3 , 6 )*/
            /*+ parallel(s , 6 )*/
            sa3.ban,
            ba.ban_status,
            ba.account_type,
            ba.account_sub_type,
            sa3.subscriber_no,
            RTRIM (sa3.soc) soc,
            RTRIM (sa3.campaign) campaign,
            sa3.effective_date,
            sa3.service_type,
            s.sub_status,
            sa3.expiration_date,
            s.commit_start_date,
            s.commit_end_date
       FROM mdcust_ny.service_agreement@wh10p sa3,
            mdcust_ny.subscriber@wh10p s,
            mdcust_ny.billing_account@wh10p ba
      WHERE     1 = 1
            AND s.customer_id   = sa3.ban
            AND s.subscriber_no = sa3.subscriber_no
            AND sa3.ban         = ba.ban
            AND sa3.campaign IN
               ('PPED12R15',
                'PPED12R20',
                'PPED12R33',
                'PPUA12RA1',
                'PPUR12R10',
                'PPUR12R15',
                'PPUR12R20',
                'PPUR12R25',
                'PPUR12R33',
                'PPUS12R10',
                'PPUS12R15',
                'PPUS12R20',
                'PPUS12R25',
                'PPUS12R33',
                'PPUT12A1 ',
                'PPUT12R15',
                'PPUT12R20',
                'PPUT12R25',
                'PPUT12R33',
                'PPUT12RD1',
                'PPUY12R15',
                'PPUY12R20',
                'PPUY12R25',
                'PPUY12R33',
                'PSEA24BI ',
                'PSEB24B1 ',
                'PSEB24BI ',
                'PSEB24T1 ',
                'PSEB24T2 ',
                'PSEC24B1 ',
                'PSEC24BI ',
                'PSEC24T1 ',
                'PSEC24T2 ',
                'PSED24BI ',
                'PSED24T1 ',
                'PSEE24BI ',
                'PSEE24T1 ',
                'PSEH24BI ',
                'PSEH24T1 ',
                'PSEH48T1 ',
                'PSEI24BI ',
                'PSEJ24BI ',
                'PSEJ24T1 ',
                'PSEK24BI ',
                'PSEK24T1 ',
                'PSEK36BI ',
                'PSEL24BI ',
                'PSEL24T1 ',
                'PSEM24BI ',
                'PSEM24T1 ',
                'PSEN24BI ',
                'PSEN24T1 ',
                'PSEO24BI ',
                'PSEO24T1 ',
                'PSFE24BR1',
                'PSFH24BR1',
                'PSFK24BR1',
                'PSMO12R20',
                'PSNA12R10',
                'PSNA12R15',
                'PSNB12R15',
                'PSNB12R20',
                'PSNC12R15',
                'PSNC12R20',
                'PSND12R15',
                'PSND12R20',
                'PSNE12R20',
                'PSNF12R20',
                'PSNF12R25',
                'PSSB24B1 ',
                'PSSB24BI ',
                'PSSB24T1 ',
                'PSSC24B1 ',
                'PSSC24BI ',
                'PSSC24T1 ',
                'PSSC24T2 ',
                'PSSC36BI ',
                'PSSD24BI ',
                'PSSD24T1 ',
                'PSSE24BI ',
                'PSSE24T1 ',
                'PSSH24BI ',
                'PSSI24BI ',
                'PSSJ24BI ',
                'PSSK24BI ',
                'PSSK24T1 ',
                'PSSK36BI ',
                'PSSL24BI ',
                'PSSL36BI ',
                'PSSM24BI ',
                'PSSM24T1 ',
                'PSSM36BI ',
                'PSSN24BI ',
                'PSSO24BI ',
                'PSSO24T1 ',
                'PSSO36BI ',
                'PSTE24BR1',
                'PSTH24BR1',
                'PSTI24BR1',
                'PSTK24BR1',
                'PSTM24BR1')
);

COMMIT;

CREATE INDEX tmp_disc_subscribers_idx1
    ON tmp_disc_subscribers (ban, subscriber_no);

CREATE INDEX tmp_disc_subscribers_idx2
    ON tmp_disc_subscribers (commit_start_date, commit_end_date);

COMMIT;


/*
** create temp tables for the campaigns we're interested in.
*/
CREATE TABLE tmp_disc_campaigns
AS
    (select UNIQUE RTRIM(a.campaign) as "CAMPAIGN", RTRIM(a.campaign_desc) as "CAMPAIGN_DESC"
            , b.pp_code as "PRICE_PLAN", RTRIM(c.soc_description) as "PRICE_PLAN_DESC"
            , b.keep_discount_ind, b.campaign_seq, b.min_commit_period AS "COMMIT_NO_MONTH"
            , c.effective_date AS "EFFECTIVE_DATE", nvl(c.expiration_date, to_date('4700-12-31', 'YYYY-MM-DD')) AS "EXPIRATION_DATE"
  from campaign@fokus a, campaign_commitments@fokus b, soc@fokus c
 where RTRIM(a.campaign)  = RTRIM(b.campaign)
   and RTRIM(b.pp_code)   = RTRIM(c.soc)
--   and sysdate      between c.effective_date and nvl(c.expiration_date, sysdate + 1)
   and a.campaign in (
                'PPED12R15',
                'PPED12R20',
                'PPED12R33',
                'PPUA12RA1',
                'PPUR12R10',
                'PPUR12R15',
                'PPUR12R20',
                'PPUR12R25',
                'PPUR12R33',
                'PPUS12R10',
                'PPUS12R15',
                'PPUS12R20',
                'PPUS12R25',
                'PPUS12R33',
                'PPUT12A1 ',
                'PPUT12R15',
                'PPUT12R20',
                'PPUT12R25',
                'PPUT12R33',
                'PPUT12RD1',
                'PPUY12R15',
                'PPUY12R20',
                'PPUY12R25',
                'PPUY12R33',
                'PSEA24BI ',
                'PSEB24B1 ',
                'PSEB24BI ',
                'PSEB24T1 ',
                'PSEB24T2 ',
                'PSEC24B1 ',
                'PSEC24BI ',
                'PSEC24T1 ',
                'PSEC24T2 ',
                'PSED24BI ',
                'PSED24T1 ',
                'PSEE24BI ',
                'PSEE24T1 ',
                'PSEH24BI ',
                'PSEH24T1 ',
                'PSEH48T1 ',
                'PSEI24BI ',
                'PSEJ24BI ',
                'PSEJ24T1 ',
                'PSEK24BI ',
                'PSEK24T1 ',
                'PSEK36BI ',
                'PSEL24BI ',
                'PSEL24T1 ',
                'PSEM24BI ',
                'PSEM24T1 ',
                'PSEN24BI ',
                'PSEN24T1 ',
                'PSEO24BI ',
                'PSEO24T1 ',
                'PSFE24BR1',
                'PSFH24BR1',
                'PSFK24BR1',
                'PSMO12R20',
                'PSNA12R10',
                'PSNA12R15',
                'PSNB12R15',
                'PSNB12R20',
                'PSNC12R15',
                'PSNC12R20',
                'PSND12R15',
                'PSND12R20',
                'PSNE12R20',
                'PSNF12R20',
                'PSNF12R25',
                'PSSB24B1 ',
                'PSSB24BI ',
                'PSSB24T1 ',
                'PSSC24B1 ',
                'PSSC24BI ',
                'PSSC24T1 ',
                'PSSC24T2 ',
                'PSSC36BI ',
                'PSSD24BI ',
                'PSSD24T1 ',
                'PSSE24BI ',
                'PSSE24T1 ',
                'PSSH24BI ',
                'PSSI24BI ',
                'PSSJ24BI ',
                'PSSK24BI ',
                'PSSK24T1 ',
                'PSSK36BI ',
                'PSSL24BI ',
                'PSSL36BI ',
                'PSSM24BI ',
                'PSSM24T1 ',
                'PSSM36BI ',
                'PSSN24BI ',
                'PSSO24BI ',
                'PSSO24T1 ',
                'PSSO36BI ',
                'PSTE24BR1',
                'PSTH24BR1',
                'PSTI24BR1',
                'PSTK24BR1',
                'PSTM24BR1')

);

COMMIT;

CREATE INDEX tmp_disc_campaigns_index
    ON tmp_disc_campaigns (campaign, price_plan, keep_discount_ind, effective_date, expiration_date);

COMMIT;

/*
** Create an overview of the discounts for these subscribers.
*/
CREATE TABLE tmp_disc_ban_discount
AS (
--
-- SELECT bd.*
SELECT bd.ban, bd.discount_code, bd.subscriber_no, bd.disc_seq_no, bd.sys_creation_date
     , bd.sys_update_date, bd.operator_id, bd.dl_service_code, bd.effective_date
     , bd.disc_by_opid, bd.expiration_date
     , RTRIM(bd.campaign) AS "CAMPAIGN", bd.commit_orig_no_month
--  FROM mdcust_ny.ban_discount@wh10p bd, tmp_disc_subscribers s -- , tmp_disc_campaigns c
  FROM ban_discount@fokus bd, tmp_disc_subscribers s
 WHERE 1 = 1
   AND s.ban           = bd.ban
   AND s.subscriber_no = bd.subscriber_no
   AND s.campaign      = RTRIM(bd.campaign)
--   AND s.soc           = c.price_plan
--   AND s.campaign      = c.campaign
--   AND s.effective_date BETWEEN bd.effective_date AND NVL(bd.expiration_date, SYSDATE + 1)
);

COMMIT;

CREATE INDEX tmp_disc_ban_discount_idx1
    ON tmp_disc_ban_discount (ban, subscriber_no);

CREATE INDEX tmp_disc_ban_discount_idx2
    ON tmp_disc_ban_discount (discount_code, effective_date, expiration_date);


COMMIT;

/*
** Create the primary table in which we list all missing discounts.
** From this table we can calculate the required adjustments, etc...
*/
CREATE TABLE tmp_disc_missing_campaigns
AS (
SELECT s.ban, s.ban_status, s.account_type, s.account_sub_type, s.subscriber_no
     , s.sub_status, s.soc, s.service_type, c.price_plan
     , c.price_plan_desc, s.campaign , c.campaign_desc, s.effective_date AS "SOC_EFF_DATE"
     , s.expiration_date AS "SOC_EXP_DATE", s.commit_start_date, s.commit_end_date
     , c.keep_discount_ind, c.campaign_seq, c.effective_date AS "CAMP_EFF_DATE"
     , c.expiration_date AS "CAMP_EXP_DATE"
  FROM tmp_disc_subscribers s, tmp_disc_campaigns c
 WHERE 1 = 1
   AND s.campaign = c.campaign
   AND s.effective_date BETWEEN c.effective_date    AND c.expiration_date -- LEAST(GREATEST(c.effective_date, c.expiration_date), (c.effective_date + (30 * c.commit_no_month)))
   AND s.effective_date BETWEEN s.commit_start_date AND s.commit_end_date
   AND s.effective_date > TO_DATE('2016-01-01', 'YYYY-MM-DD')
   AND NOT EXISTS (
        SELECT ''
          FROM tmp_disc_ban_discount d
         WHERE s.ban            = d.ban
           AND s.subscriber_no  = d.subscriber_no
           AND s.campaign       = d.campaign
           AND s.effective_date BETWEEN d.effective_date AND DECODE(GREATEST(d.effective_date, d.expiration_date)
                                                                  , d.effective_date, d.effective_date + (365 * DECODE(d.commit_orig_no_month, 24 , 2, 12, 1, (d.commit_orig_no_month / 30)))
                                                                  , d.expiration_date)
   )
-- ORDER BY s.subscriber_no, s.effective_date, s.expiration_date, s.ban
);

COMMIT;

CREATE INDEX tmp_disc_miss_campns_idx1
    ON tmp_disc_missing_campaigns (ban_status, account_type, account_sub_type);

CREATE INDEX tmp_disc_missinmpns_idx2
    ON tmp_disc_missing_campaigns (campaign, soc_eff_date, soc_exp_date);


COMMIT;

;

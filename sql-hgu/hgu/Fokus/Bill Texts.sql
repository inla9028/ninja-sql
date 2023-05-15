/*
** Display all the bill-texts...
*/
-- UB Ftr Texts
SELECT RTRIM(ci.feature_code)   AS "CODE",
       RTRIM(bd.language_code)  AS "LANGUAGE",
       RTRIM(fb.bp_bill_format) AS "BILL_FORMAT",
       RTRIM(bd.desc_text)      AS "DESC_TEXT",
       'U'                      AS "CHARGE_TYPE" -- UnbilledOverviewDTO.REVENUE_CODE_UNBILLED_USAGE
  FROM charge_info@fokus           ci,
       bill_category@fokus         bc,
       feature_bill_category@fokus fb,
       bill_desc@fokus             bd
 WHERE ci.charge_type        = 'F'
   AND ci.feature_category   = fb.feature_category
   AND fb.bp_bill_format     = bc.bp_bill_format
   AND fb.category_code      = bc.category_code
   AND bd.bill_desc_seq_num  = bc.desc_seq
-- Soc Texts
UNION
SELECT RTRIM(s.soc)             AS "CODE",
       RTRIM(bd.language_code)  AS "LANGUAGE",
       NULL                     AS "BILL_FORMAT",
       RTRIM(bd.desc_text)      AS "DESC_TEXT",
       'R'                      AS "CHARGE_TYPE" -- UnbilledOverviewDTO.REVENUE_CODE_EXPECTED_RECURRING
  FROM soc@fokus       s,
       bill_desc@fokus bd
 WHERE s.expiration_date is null
   AND s.soc_desc_seq    = bd.bill_desc_seq_num
-- Ftr Texts
UNION
SELECT RTRIM(f.feature_code)    AS "CODE",
       RTRIM(bd.language_code)  AS "LANGUAGE",
       NULL                     AS "BILL_FORMAT",
       RTRIM(bd.desc_text)      AS "DESC_TEXT",
       'O'                      AS "CHARGE_TYPE" -- UnbilledOverviewDTO.REVENUE_CODE_EXISTING_CHARGES
  FROM feature@fokus f, bill_desc@fokus bd
 WHERE f.ftr_desc_seq = bd.bill_desc_seq_num
;

/*
** Same as above, bot not via DB-link...
*/
-- UB Ftr Texts
SELECT RTRIM(ci.feature_code)   AS "CODE",
       RTRIM(bd.language_code)  AS "LANGUAGE",
       RTRIM(fb.bp_bill_format) AS "BILL_FORMAT",
       RTRIM(bd.desc_text)      AS "DESC_TEXT",
       'U'                      AS "CHARGE_TYPE" -- UnbilledOverviewDTO.REVENUE_CODE_UNBILLED_USAGE
  FROM charge_info           ci,
       bill_category         bc,
       feature_bill_category fb,
       bill_desc             bd
 WHERE ci.charge_type        = 'F'
   AND ci.feature_category   = fb.feature_category
   AND fb.bp_bill_format     = bc.bp_bill_format
   AND fb.category_code      = bc.category_code
   AND bd.bill_desc_seq_num  = bc.desc_seq
-- Soc Texts
UNION
SELECT RTRIM(s.soc)             AS "CODE",
       RTRIM(bd.language_code)  AS "LANGUAGE",
       NULL                     AS "BILL_FORMAT",
       RTRIM(bd.desc_text)      AS "DESC_TEXT",
       'R'                      AS "CHARGE_TYPE" -- UnbilledOverviewDTO.REVENUE_CODE_EXPECTED_RECURRING
  FROM soc       s,
       bill_desc bd
 WHERE s.expiration_date is null
   AND s.soc_desc_seq    = bd.bill_desc_seq_num
-- Ftr Texts
UNION
SELECT RTRIM(f.feature_code)    AS "CODE",
       RTRIM(bd.language_code)  AS "LANGUAGE",
       NULL                     AS "BILL_FORMAT",
       RTRIM(bd.desc_text)      AS "DESC_TEXT",
       'O'                      AS "CHARGE_TYPE" -- UnbilledOverviewDTO.REVENUE_CODE_EXISTING_CHARGES
  FROM feature f, bill_desc bd
 WHERE f.ftr_desc_seq = bd.bill_desc_seq_num
;

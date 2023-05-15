SELECT count(1)
  FROM ninjateam.hgu_tmp_bans_params A
;

DESC ninjateam.hgu_tmp_bans_params
;

SELECT A.*
  FROM ninjateam.hgu_tmp_bans_params A
-- where rownum < 101
ORDER BY 1,2,3
;

SELECT ban
     , param1                           AS "TPID"
     , param2                           AS "SF_CUSTOMER_TYPE"
     , decode(param5
                    , 'B', 'B2B'
                    , 'I', 'B2C'
                    , 'O', 'Org'
                    , 'P', 'Prepaid'
                    , param5)         AS "FOKUS_CUSTOMER_TYPE"
     , decode(param3, NULL, 'N', 'Y') AS "TPID_MATCH"
     , param4                         AS "BAN_STATUS"
     , decode(param4
           , 'C', 'Closed'
           , 'N', 'Cancelled'
           , 'O', 'Open'
           , 'S', 'Suspended'
           , 'T', 'Tentative'
           , param4)                    AS "BAN_STATUS_DESC"
     , param5                           AS "ACCOUNT_TYPE"
     , param6                           AS "ACCOUNT_SUB_TYPE"
     , param7                           AS "LO"
     , param8                           AS "IR"
     , param9                           AS "PU"
  FROM ninjateam.hgu_tmp_bans_params
-- WHERE ROWNUM < 101
ORDER BY 1,2,3
;

SELECT A.param2, count(1) AS "COUNT"
  FROM ninjateam.hgu_tmp_bans_params A
GROUP BY A.param2
ORDER BY 1
;

UPDATE ninjateam.hgu_tmp_bans_params A
   SET A.param9 = 'DUPLICATE'
 WHERE 0 != (SELECT count(1)
               FROM ninjateam.hgu_tmp_bans_params b
              WHERE b.ban = A.ban
                AND b.param1 = A.param1
                AND b.param2 = A.param2
                and b.rowid  < a.rowid)
;

DELETE
  FROM ninjateam.hgu_tmp_bans_params A
 WHERE A.param9 = 'DUPLICATE'
;


SELECT A.*
  FROM ninjateam.hgu_tmp_bans_params A
 where a.ban = 100002419
ORDER BY 1,2,3
;

UPDATE ninjateam.hgu_tmp_bans_params A
   SET A.param3 = (SELECT /*+ driving_site(anl)*/ listagg(anl.link_type, ',') WITHIN GROUP (ORDER BY anl.link_type)
                     FROM cdata.address_name_link@wh12p anl
                        , cdata.name_data@wh12p         nd
                    WHERE anl.ban            = A.ban
                      AND SYSDATE      BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
                      AND anl.name_id        = nd.name_id
                      AND nd.tpid            = A.param1)
;

UPDATE ninjateam.hgu_tmp_bans_params A
   SET A.param4 = (SELECT /*+ driving_site(ba)*/ ba.ban_status
                     FROM cdata.billing_account@wh12p ba
                    WHERE ba.customer_id = A.ban)
;

UPDATE ninjateam.hgu_tmp_bans_params A
   SET A.param5 = (SELECT /*+ driving_site(ba)*/ ba.account_type || '/' || ba.account_sub_type
                     FROM cdata.billing_account@wh12p ba
                    WHERE ba.customer_id = A.ban)
;

-- Split the account-types into two columns
UPDATE ninjateam.hgu_tmp_bans_params A
   SET A.param6 = substr(A.param5, 3)
     , A.param5 = substr(A.param5, 0, 1)
 WHERE A.param5 IS NOT NULL
;

-- Split the roles into three columns.
UPDATE ninjateam.hgu_tmp_bans_params A
   SET A.param7 = decode(instr(A.param3, 'L'), 0, NULL, 'LO')
     , A.param8 = decode(instr(A.param3, 'B'), 0, NULL, 'IR')
     , A.param9 = decode(instr(A.param3, 'U'), 0, NULL, 'PU')
 WHERE A.param3 IS NOT NULL
;

--==
--== Statistics
--==
--== Status in Fokus.

SELECT ban_status, ban_status_desc, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
          FROM ninjateam.hgu_tmp_bans_params A
--         WHERE ROWNUM < 101
)
GROUP BY ban_status, ban_status_desc
ORDER BY 1,2
;

SELECT ban_status, ban_status_desc, tpid_match, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
             , decode(A.param3, NULL, 'No', 'Yes') AS "TPID_MATCH"
          FROM ninjateam.hgu_tmp_bans_params A
--         WHERE ROWNUM < 101
)
GROUP BY ban_status, ban_status_desc, tpid_match
ORDER BY 1,2,3
;

SELECT ban_status, ban_status_desc, customer_type, tpid_match, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
             , decode(A.param5
                    , 'B', 'B2B'
                    , 'I', 'B2C'
                    , 'O', 'Organization'
                    , 'P', 'Prepaid'
                    , a.param5) AS "CUSTOMER_TYPE"
             , decode(A.param3, NULL, 'No', 'Yes') AS "TPID_MATCH"
          FROM ninjateam.hgu_tmp_bans_params A
--         WHERE ROWNUM < 101
)
GROUP BY ban_status, ban_status_desc, customer_type, tpid_match
ORDER BY 1,2,3
;


SELECT ban_status, ban_status_desc, account_type, account_sub_type, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
              , a.param5 AS "ACCOUNT_TYPE", a.param6 AS "ACCOUNT_SUB_TYPE"
          FROM ninjateam.hgu_tmp_bans_params A
--         WHERE ROWNUM < 101
)
GROUP BY ban_status, ban_status_desc, account_type, account_sub_type
ORDER BY 1,2,3,4
;

SELECT ban_status, ban_status_desc, account_type, account_sub_type, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
              , a.param5 AS "ACCOUNT_TYPE", a.param6 AS "ACCOUNT_SUB_TYPE"
          FROM ninjateam.hgu_tmp_bans_params A
         WHERE A.param3 IS NOT NULL
)
GROUP BY ban_status, ban_status_desc, account_type, account_sub_type
ORDER BY 1,2,3,4
;

SELECT ban_status, ban_status_desc, lo, ir, pu, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
              , A.param7 AS "LO", A.param8 AS "IR", A.param9 AS "PU"
          FROM ninjateam.hgu_tmp_bans_params A
--         WHERE ROWNUM < 101
)
GROUP BY ban_status, ban_status_desc, lo, ir, pu
ORDER BY 1,2,3
;

SELECT ban_status, ban_status_desc, lo, ir, pu, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
              , A.param7 AS "LO", A.param8 AS "IR", A.param9 AS "PU"
          FROM ninjateam.hgu_tmp_bans_params A
         WHERE A.param3 IS NOT NULL
)
GROUP BY ban_status, ban_status_desc, lo, ir, pu
ORDER BY 1,2,3
;

SELECT ban_status, ban_status_desc, customer_type, lo, ir, pu, count(1) AS "COUNT"
  from (SELECT A.param4 AS "BAN_STATUS"
             , decode(A.param4
                    , 'C', 'Closed'
                    , 'N', 'Cancelled'
                    , 'O', 'Open'
                    , 'S', 'Suspended'
                    , 'T', 'Tentative'
                    , A.param4) AS "BAN_STATUS_DESC"
              , decode(A.param5
                    , 'B', 'B2B'
                    , 'I', 'B2C'
                    , 'O', 'Organization'
                    , 'P', 'Prepaid'
                    , a.param5) AS "CUSTOMER_TYPE"
              , A.param7 AS "LO", A.param8 AS "IR", A.param9 AS "PU"
          FROM ninjateam.hgu_tmp_bans_params A
         WHERE A.param3 IS NOT NULL
)
GROUP BY ban_status, ban_status_desc, customer_type, lo, ir, pu
ORDER BY ban_status, ban_status_desc, customer_type, lo, ir, pu
;

-- ...

SELECT /*+ driving_site(s)*/
       anl.ban, anl.subscriber_no, anl.link_type, anl.birth_date,
       nd.tpid, nd.comp_reg_id, nd.first_name, nd.last_business_name, nd.additional_title,
       ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email --, nd.*
       , nd.role_ind
  FROM subscriber@fokus        s
     , address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
 WHERE s.subscriber_no    = 'GSM047'||'580004200234'
   AND s.ctn_seq_no       = (SELECT MAX(s2.ctn_seq_no)
                              FROM subscriber@fokus s2
                             WHERE s2.subscriber_no = s.subscriber_no)
   AND anl.ban            = s.customer_id 
   AND anl.subscriber_no IN ( '0000000000', s.subscriber_no )
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

-- List only subscriber...
SELECT * FROM (
SELECT a.subscriber_no, RTRIM(a.soc) AS "SOC", d.description
     , a.campaign
     , TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD HH24:MI:SS') AS "EFFECTIVE_DATE"
     , TO_CHAR(a.expiration_date,   'YYYY-MM-DD HH24:MI:SS') AS "EXPIRATION_DATE"
     , a.operator_id, u.user_full_name, '' AS "MEMO_SYSTEM", '' AS "MEMO_MANUAL"
  FROM service_agreement@fokus a, users@fokus u, socs_descriptions d
  WHERE a.subscriber_no IN  ('GSM047' || '92439776')
    AND a.operator_id    = u.user_id(+)
    AND RTRIM(a.soc)     = d.soc(+)
--    AND RTRIM(a.soc) LIKE 'MCTB%'
    AND d.language_code  = 'NO'
    AND a.effective_date > TO_DATE('2017-07-01', 'YYYY-MM-DD')
UNION
SELECT * FROM (
     SELECT m.memo_subscriber AS "SUBSCRIBER_NO", '' AS "SOC", '' AS DESCRIPTION
          , '' AS "CAMPAIGN"
          , TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "EFFECTIVE_DATE"
          , '' AS "EXPIRATION_DATE", m.operator_id, u.user_full_name
          , RTRIM(m.memo_system_txt) AS "MEMO_SYSTEM", RTRIM(m.memo_manual_txt) AS "MEMO_MANUAL"
       FROM memo@fokus m, users@fokus u
      WHERE m.memo_subscriber   IN ('GSM047' || '92439776', '047' || '92439776')
        AND m.operator_id        = u.user_id(+)
        AND m.memo_date          > TO_DATE('2017-07-01', 'YYYY-MM-DD')
--        AND m.memo_system_txt LIKE '%MCTB%'
      ORDER BY m.memo_id
)
)
ORDER BY effective_date, soc
;

-- List subscriber and BAN...
SELECT * FROM (
SELECT a.subscriber_no, RTRIM(a.soc) AS "SOC", d.description
     , a.campaign
     , TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD HH24:MI:SS') AS "EFFECTIVE_DATE"
     , TO_CHAR(a.expiration_date,   'YYYY-MM-DD HH24:MI:SS') AS "EXPIRATION_DATE"
     , a.operator_id, u.user_full_name, '' AS "MEMO_SYSTEM", '' AS "MEMO_MANUAL"
  FROM service_agreement@fokus a, users@fokus u, socs_descriptions d
  WHERE a.subscriber_no IN  ('GSM047'||'99205105', '0000000000')
    AND a.ban            = 491462412
    AND a.operator_id    = u.user_id(+)
    AND RTRIM(a.soc)     = d.soc(+)
    AND RTRIM(a.soc) LIKE 'LR%'
    AND d.language_code  = 'NO'
    AND a.effective_date > TO_DATE('2018-07-01', 'YYYY-MM-DD')
UNION
SELECT * FROM (
     SELECT m.memo_subscriber AS "SUBSCRIBER_NO", '' AS "SOC", '' AS DESCRIPTION
          , '' AS "CAMPAIGN"
          , TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "EFFECTIVE_DATE"
          , '' AS "EXPIRATION_DATE", m.operator_id, u.user_full_name
          , RTRIM(m.memo_system_txt) AS "MEMO_SYSTEM", RTRIM(m.memo_manual_txt) AS "MEMO_MANUAL"
       FROM memo@fokus m, users@fokus u
      WHERE (m.memo_subscriber  IN ('GSM047'||'99205105', '047' || '99205105')
          OR m.memo_ban          = 491462412)
        AND m.operator_id        = u.user_id(+)
        AND m.memo_date          > TO_DATE('2018-07-01', 'YYYY-MM-DD')
--        AND m.memo_system_txt LIKE '%MCTB%'
      ORDER BY m.memo_id
)
)
ORDER BY effective_date, soc
;



SELECT m.*
  FROM memo@fokus m
 WHERE m.memo_subscriber IN ('GSM047' || '92439776', '047' || '92439776')
ORDER BY m.memo_date
;

SELECT m.memo_ban, m.operator_id, u.user_full_name, m.memo_date
     , m.memo_subscriber, m.memo_system_txt, m.memo_manual_txt
  FROM memo@fokus m, users@fokus u
 WHERE m.memo_subscriber IN ('GSM047' || '92439776', '047' || '92439776')
   AND m.operator_id    = u.user_id(+)
   AND m.memo_date > SYSDATE - 30
ORDER BY m.memo_date
;

SELECT m.memo_ban, m.operator_id, u.user_full_name, m.memo_date
     , m.memo_subscriber, m.memo_system_txt, m.memo_manual_txt
  FROM memo@fokus m, users@fokus u
 WHERE m.memo_ban    = 997852215
   AND m.operator_id = u.user_id(+)
   AND m.memo_date   > SYSDATE - 90
ORDER BY m.memo_date
;

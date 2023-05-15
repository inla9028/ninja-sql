SELECT a.*
  FROM sms_messages a
 WHERE a.msg_text LIKE '%05050%'
    OR a.msg_text LIKE '%06060%'
    OR a.from_ctn IN ( '05050', '06060' )
ORDER BY 1,2
;

SELECT a.*
  FROM sms_messages_v2 a
 WHERE a.msg_text LIKE '%05050%'
    OR a.msg_text LIKE '%06060%'
    OR a.from_ctn IN ( '05050', '06060' )
ORDER BY 1,2
;

/*
** Message body...
*/
UPDATE sms_messages a
   SET a.msg_text = REPLACE(a.msg_text, '05050', '924 05050')
 WHERE a.msg_text LIKE '%05050%'
;

UPDATE sms_messages a
   SET a.msg_text = REPLACE(a.msg_text, '06060', '924 06060')
 WHERE a.msg_text LIKE '%06060%'
;

/*
** Message body...
*/
UPDATE sms_messages_v2 a
   SET a.msg_text = REPLACE(a.msg_text, '05050', '924 05050')
 WHERE a.msg_text LIKE '%05050%'
;

UPDATE sms_messages_v2 a
   SET a.msg_text = REPLACE(a.msg_text, '06060', '924 06060')
 WHERE a.msg_text LIKE '%06060%'
;

/*
** Sender number...
*/
/*UPDATE sms_messages a
   SET a.from_ctn = '92405050'
 WHERE a.from_ctn =    '05050'
;*/

/*UPDATE sms_messages a
   SET a.from_ctn = '92406060'
 WHERE a.from_ctn =    '06060'
;*/

/*UPDATE sms_messages_v2 a
   SET a.from_ctn = '92405050'
 WHERE a.from_ctn =    '05050'
;*/

/*UPDATE sms_messages_v2 a
   SET a.from_ctn = '92406060'
 WHERE a.from_ctn =    '06060'
;*/



UPDATE sms_messages_v2 a
   SET a.from_ctn      = '05051'
 WHERE a.from_ctn      = '05050'
   AND a.customer_type = 'B'
;


UPDATE sms_messages_v2 a
   SET a.from_ctn = '06060'
 WHERE a.from_ctn = '05050'
   AND UPPER(a.msg_text) LIKE '%CHESS%'
;

/*
**
*/
SELECT a.*
  FROM sms_messages a
 WHERE a.msg_text LIKE '%924 05050%'
    OR a.msg_text LIKE '%924 06060%'
    OR a.from_ctn IN ( '05050', '05051', '06060' )
ORDER BY 1,2
;

SELECT a.*
  FROM sms_messages_v2 a
 WHERE a.msg_text LIKE '%924 05050%'
    OR a.msg_text LIKE '%924 06060%'
    OR a.from_ctn IN ( '05050', '05051', '06060' )
ORDER BY 1,2
;



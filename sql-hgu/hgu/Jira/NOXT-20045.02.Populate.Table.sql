INSERT INTO sms_messages (msg_id, language_code, customer_type, from_ctn, from_ascii, effective_date, expiration_date, msg_text)
SELECT msg_id, language_code, customer_type, from_ctn
     , 'Telia' AS "FROM_ASCII"
     , effective_date, expiration_date, msg_text
  FROM sms_messages_v3
ORDER BY msg_id, customer_type, language_code, effective_date
;

--
-- Test Env...
--
INSERT INTO sms_messages (msg_id, language_code, customer_type, from_ctn, from_ascii, effective_date, expiration_date, msg_text)
SELECT unique msg_id, language_code, customer_type, from_ctn
     , 'Telia' AS "FROM_ASCII"
     , effective_date, expiration_date, msg_text
  FROM sms_messages_v3@prod
ORDER BY msg_id, customer_type, language_code, effective_date
;

SELECT *
  FROM sms_messages
ORDER BY msg_id, customer_type, language_code, effective_date
;
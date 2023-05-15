CREATE TABLE SMS_MESSAGES_V2(
	MSG_ID        NUMBER(6,0), 
	LANGUAGE_CODE VARCHAR2(3),
	CUSTOMER_TYPE VARCHAR2(1),
	FROM_CTN      VARCHAR2(10), 
	MSG_TEXT      VARCHAR2(200)
);


COMMENT ON COLUMN SMS_MESSAGES_V2.MSG_ID IS 'Message ID.';
COMMENT ON COLUMN SMS_MESSAGES_V2.LANGUAGE_CODE IS 'Language code. Foreign key fromm LANGUAGES table.';
COMMENT ON COLUMN SMS_MESSAGES_V2.CUSTOMER_TYPE IS 'Customer Type, B for Business, P for Private.';
COMMENT ON COLUMN SMS_MESSAGES_V2.FROM_CTN IS 'Originating CTN of this message.';
COMMENT ON COLUMN SMS_MESSAGES_V2.MSG_TEXT IS 'SMS text. Valid bind variables: :DESC and :SPECIAL_TELNO.';
COMMENT ON TABLE SMS_MESSAGES_V2  IS 'Holds SMS messages.';

CREATE UNIQUE INDEX SMS_MESSAGES_V2_IDX1 ON SMS_MESSAGES_V2 (MSG_ID, LANGUAGE_CODE, CUSTOMER_TYPE);

ALTER TABLE SMS_MESSAGES_V2 MODIFY (MSG_ID        NOT NULL ENABLE);
ALTER TABLE SMS_MESSAGES_V2 MODIFY (LANGUAGE_CODE NOT NULL ENABLE);
ALTER TABLE SMS_MESSAGES_V2 MODIFY (FROM_CTN      NOT NULL ENABLE);
ALTER TABLE SMS_MESSAGES_V2 MODIFY (MSG_TEXT      NOT NULL ENABLE);
ALTER TABLE SMS_MESSAGES_V2 ADD PRIMARY KEY (MSG_ID, LANGUAGE_CODE, CUSTOMER_TYPE);
ALTER TABLE SMS_MESSAGES_V2 ADD CONSTRAINT SMS_MESSAGES_V2_CON1 FOREIGN KEY (LANGUAGE_CODE) REFERENCES LANGUAGES(LANGUAGE_CODE) ENABLE;

GRANT ALTER ON sms_messages_v2 TO ninjamain;
GRANT DELETE ON sms_messages_v2 TO ninjamain;
GRANT INDEX ON sms_messages_v2 TO ninjamain;
GRANT INSERT ON sms_messages_v2 TO ninjamain;
GRANT SELECT ON sms_messages_v2 TO ninjamain;
GRANT UPDATE ON sms_messages_v2 TO ninjamain;
GRANT REFERENCES ON sms_messages_v2 TO ninjamain;
GRANT ON COMMIT REFRESH ON sms_messages_v2 TO ninjamain;
GRANT QUERY REWRITE ON sms_messages_v2 TO ninjamain;
GRANT DEBUG ON sms_messages_v2 TO ninjamain;
GRANT FLASHBACK ON sms_messages_v2 TO ninjamain;
GRANT ALTER ON sms_messages_v2 TO ninjadata;
GRANT DELETE ON sms_messages_v2 TO ninjadata;
GRANT INDEX ON sms_messages_v2 TO ninjadata;
GRANT INSERT ON sms_messages_v2 TO ninjadata;
GRANT SELECT ON sms_messages_v2 TO ninjadata;
GRANT UPDATE ON sms_messages_v2 TO ninjadata;
GRANT REFERENCES ON sms_messages_v2 TO ninjadata;
GRANT ALTER ON sms_messages_v2 TO ninjarules;
GRANT DELETE ON sms_messages_v2 TO ninjarules;
GRANT INDEX ON sms_messages_v2 TO ninjarules;
GRANT INSERT ON sms_messages_v2 TO ninjarules;
GRANT SELECT ON sms_messages_v2 TO ninjarules;
GRANT UPDATE ON sms_messages_v2 TO ninjarules;
GRANT REFERENCES ON sms_messages_v2 TO ninjarules;
GRANT SELECT ON sms_messages_v2 TO backupninjarules;
GRANT SELECT ON sms_messages_v2 TO readonly;
GRANT SELECT ON sms_messages_v2 TO ninjarstaging;
GRANT SELECT ON sms_messages_v2 TO ninjarstaging2;

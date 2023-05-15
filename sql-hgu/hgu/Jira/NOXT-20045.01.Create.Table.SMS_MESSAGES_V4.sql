DROP TABLE sms_messages purge
;

CREATE TABLE sms_messages(
	msg_id           NUMBER(6,0), 
	language_code    VARCHAR2(3),
	customer_type    VARCHAR2(1),
	from_ctn         VARCHAR2(20),
    from_ascii       VARCHAR2(11),
    effective_date   DATE,
    expiration_date  DATE,
	msg_text         VARCHAR2(1000)
);


COMMENT ON COLUMN sms_messages.msg_id IS 'Message ID.';
COMMENT ON COLUMN sms_messages.language_code IS 'Language code. Foreign key fromm LANGUAGES table.';
COMMENT ON COLUMN sms_messages.customer_type IS 'Customer Type, B for Business, P for Private.';
COMMENT ON COLUMN sms_messages.from_ctn IS 'Originating CTN of this message. Mandatory, but FROM_ASCII overrides this value.';
COMMENT ON COLUMN sms_messages.from_ascii IS 'Originating ASCII of this message.';
COMMENT ON COLUMN sms_messages.msg_text IS 'SMS text. Valid bind variables: :DESC and :SPECIAL_TELNO.';
COMMENT ON TABLE sms_messages  IS 'Holds SMS messages.';

CREATE UNIQUE INDEX sms_messages_idx1 ON sms_messages (msg_id, language_code, customer_type, effective_date, expiration_date);

ALTER TABLE sms_messages MODIFY (msg_id         NOT NULL ENABLE);
ALTER TABLE sms_messages MODIFY (language_code  NOT NULL ENABLE);
ALTER TABLE sms_messages MODIFY (from_ctn       NOT NULL ENABLE);
ALTER TABLE sms_messages MODIFY (msg_text       NOT NULL ENABLE);
ALTER TABLE sms_messages MODIFY (effective_date NOT NULL ENABLE);

ALTER TABLE sms_messages ADD PRIMARY KEY (msg_id, language_code, customer_type, effective_date);
ALTER TABLE sms_messages ADD CONSTRAINT sms_messages_con1 FOREIGN KEY (language_code) REFERENCES languages(language_code) ENABLE;

GRANT ALTER ON sms_messages TO ninjamain;
GRANT DELETE ON sms_messages TO ninjamain;
GRANT INDEX ON sms_messages TO ninjamain;
GRANT INSERT ON sms_messages TO ninjamain;
GRANT SELECT ON sms_messages TO ninjamain;
GRANT UPDATE ON sms_messages TO ninjamain;
GRANT REFERENCES ON sms_messages TO ninjamain;
GRANT ON COMMIT REFRESH ON sms_messages TO ninjamain;
GRANT QUERY REWRITE ON sms_messages TO ninjamain;
GRANT DEBUG ON sms_messages TO ninjamain;
GRANT FLASHBACK ON sms_messages TO ninjamain;
GRANT ALTER ON sms_messages TO ninjadata;
GRANT DELETE ON sms_messages TO ninjadata;
GRANT INDEX ON sms_messages TO ninjadata;
GRANT INSERT ON sms_messages TO ninjadata;
GRANT SELECT ON sms_messages TO ninjadata;
GRANT UPDATE ON sms_messages TO ninjadata;
GRANT REFERENCES ON sms_messages TO ninjadata;
GRANT ALTER ON sms_messages TO ninjarules;
GRANT DELETE ON sms_messages TO ninjarules;
GRANT INDEX ON sms_messages TO ninjarules;
GRANT INSERT ON sms_messages TO ninjarules;
GRANT SELECT ON sms_messages TO ninjarules;
GRANT UPDATE ON sms_messages TO ninjarules;
GRANT REFERENCES ON sms_messages TO ninjarules;
GRANT SELECT ON sms_messages TO backupninjarules;
GRANT SELECT ON sms_messages TO readonly;
GRANT SELECT ON sms_messages TO ninjarstaging;
GRANT SELECT ON sms_messages TO ninjarstaging2;

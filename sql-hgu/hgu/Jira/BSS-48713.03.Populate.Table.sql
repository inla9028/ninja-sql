
DELETE
  FROM soc_charges
;

INSERT INTO soc_charges (neo_code, feature_code, activity_reason_code, bill_text, memo_text, waive_memo_text, effective_date, expiration_date, description)
     VALUES ('NEW_MSISDN_FEE', 'CHRGMV', 'O', 'Pris for nytt nummer', 'Pris for nytt nummer', 'Waived ${amount} NOK for charge ${feature_code}: "${bill_text}"', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL)
;

INSERT INTO soc_charges (neo_code, feature_code, activity_reason_code, bill_text, memo_text, waive_memo_text, effective_date, expiration_date, description)
     VALUES ('RESCUE_BAG_FEE', 'RESCUE', 'O', 'Pris for Svitsj retureske', 'Pris for Svitsj retureske', 'Waived ${amount} NOK for charge ${feature_code}: "${bill_text}"', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL)
;


COMMIT WORK;

SELECT *
  FROM soc_charges
;

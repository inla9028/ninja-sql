DELETE
  FROM suspend_bar
;

INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOA', 'ODB1', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOA', 'ODB4', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOA', 'ODB8', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOA', 'ODBCPA', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);

INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOB', 'ODB1', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOB', 'ODB4', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOB', 'ODB8', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOB', 'ODBCPA', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);

INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOC', 'ODB1', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOC', 'ODB4', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOC', 'ODB8', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOC', 'ODBCPA', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);

INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOD', 'ODB1', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOD', 'ODB4', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOD', 'ODB8', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOD', 'ODBCPA', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);

INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOO', 'ODB1', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOO', 'ODB4', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOO', 'ODB8', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOO', 'ODBCPA', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);

INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOT', 'ODB1', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOT', 'ODB4', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOT', 'ODB8', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOT', 'ODBCPA', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);


INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOV', 'ODB1', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOV', 'ODB4', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOV', 'ODB8', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);
INSERT INTO suspend_bar (priceplan, soc, effective_date, expiration_date, description) VALUES ('PKOV', 'ODBCPA', TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'), NULL);

COMMIT WORK;
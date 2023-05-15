CREATE SYNONYM dealer_number_groups
  FOR ninjarules.dealer_number_groups
/

INSERT INTO dealer_number_groups VALUES
('*', 'DM', 12, TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'));

INSERT INTO dealer_number_groups VALUES
('SP01', 'DM', 8, TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'));

INSERT INTO dealer_number_groups VALUES
('SP02', 'DM', 8, TRUNC(SYSDATE), TO_DATE('4700-12-31', 'YYYY-MM-DD'));

SELECT a.*
  FROM dealer_number_groups a
ORDER BY 1,2,3
;


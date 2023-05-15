CREATE TABLE dealer_number_groups
    (dealer_code                   VARCHAR2(5 CHAR) NOT NULL,
     number_group                  VARCHAR2(9 CHAR) NOT NULL,
     number_length                 NUMBER NOT NULL,
     effective_date                DATE NOT NULL,
     expiration_date               DATE NOT NULL)
/

-- Grants for Table
GRANT ALTER ON dealer_number_groups TO ninjamain
/
GRANT DELETE ON dealer_number_groups TO ninjamain
/
GRANT INDEX ON dealer_number_groups TO ninjamain
/
GRANT INSERT ON dealer_number_groups TO ninjamain
/
GRANT SELECT ON dealer_number_groups TO ninjamain
/
GRANT UPDATE ON dealer_number_groups TO ninjamain
/
GRANT REFERENCES ON dealer_number_groups TO ninjamain
/
GRANT ON COMMIT REFRESH ON dealer_number_groups TO ninjamain
/
GRANT QUERY REWRITE ON dealer_number_groups TO ninjamain
/
GRANT DEBUG ON dealer_number_groups TO ninjamain
/
GRANT FLASHBACK ON dealer_number_groups TO ninjamain
/


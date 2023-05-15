/*
** Oracle (prior version 10G)
*/
ALTER TABLE feature_parameters
  MODIFY COLUMN parameter_type VARCHAR2(100 CHAR) NOT NULL
/


/*
** Oracle 10G and later
*/
ALTER TABLE feature_parameters
  MODIFY parameter_type VARCHAR2(100 CHAR) NOT NULL
/

/*
** Or...
*/
ALTER TABLE feature_parameters
  MODIFY (parameter_type VARCHAR2(100 CHAR))
/

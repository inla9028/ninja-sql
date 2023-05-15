-- Start of DDL Script for Constraint NINJADATA_PT.MASTER_TRANSACTIONS_CON1
-- Generated 2018-06-29 12:45:06 from NINJADATA_PT@NINJA_NO_PT_ST

ALTER TABLE master_transactions
DROP CONSTRAINT master_transactions_con1
/


ALTER TABLE master_transactions
ADD CONSTRAINT master_transactions_con1 CHECK ( action_code IN  (
'ADD', 'CLONE', 'MODIFY', 'DELETE', 'REPLACE', 'ADD_TYPE','DELETE_TYPE'
))
ENABLE NOVALIDATE
/


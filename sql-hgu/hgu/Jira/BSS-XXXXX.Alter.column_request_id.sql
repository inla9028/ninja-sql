--
-- 2021-08-02
--
ALTER TABLE batch_charge_addition
  MODIFY (request_id      VARCHAR2(60 CHAR),
          request_user_id VARCHAR2(60 CHAR))
/

ALTER TABLE arch_batch_charge_addition
  MODIFY (request_id      VARCHAR2(60 CHAR),
          request_user_id VARCHAR2(60 CHAR))
/

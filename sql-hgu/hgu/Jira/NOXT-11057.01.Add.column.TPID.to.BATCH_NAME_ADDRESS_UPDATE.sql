ALTER TABLE batch_name_address_update
  ADD tpid VARCHAR2(50 CHAR);

COMMENT ON COLUMN batch_name_address_update.tpid IS 'TPID aka Party ID';

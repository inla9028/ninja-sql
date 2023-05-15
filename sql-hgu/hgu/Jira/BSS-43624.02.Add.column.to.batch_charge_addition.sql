ALTER TABLE batch_charge_addition
  ADD operator_id  INTEGER;

COMMENT ON COLUMN batch_charge_addition.operator_id IS 'Fokus Operator ID (optional)';

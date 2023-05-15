ALTER TABLE batch_adjustment_addition
  ADD operator_id  INTEGER;

COMMENT ON COLUMN batch_adjustment_addition.operator_id IS 'Fokus Operator ID (optional)';

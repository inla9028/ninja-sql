SELECT a.*
  FROM dealer_number_groups a
;

ALTER TABLE dealer_number_groups
  ADD number_count NUMBER
;

UPDATE dealer_number_groups a
   SET a.number_count = 30
 WHERE a.dealer_code  = '*'
;

SELECT a.*
  FROM dealer_number_groups a
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Change the stream-value from x to y for 100 rows.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_charge_addition b
  SET b.stream = '6'
  WHERE b.transaction_number IN (
    SELECT *
    FROM (
      SELECT  a.transaction_number
        FROM  batch_charge_addition a
        WHERE a.stream         = '1'
		  AND a.process_status = 'WAITING'
        ORDER BY a.transaction_number desc
    )
    WHERE rownum < 201
);
COMMIT;

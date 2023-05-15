-- List all rows, ordered by porting time
SELECT a.*
  FROM int_porting a
ORDER BY a.port_time
;

-- List all rows for a certain number (no GSM047 nor 047, just the 8 digit number)
SELECT a.*
  FROM int_porting a
 WHERE a.ported_number = '40704070'
ORDER BY a.port_time
;

-- List all rows porting TO a certain operator
SELECT a.*
  FROM int_porting a
 WHERE a.receiving_operator = '725'
ORDER BY a.port_time
;

-- List all rows porting FROM a certain operator
SELECT a.*
  FROM int_porting a
 WHERE a.donor_operator = '898'
ORDER BY a.port_time
;

SELECT a.*
  FROM all_tables a
 WHERE a.table_name = 'SERVICE_AGREEMENT'
ORDER BY 1,2,3
;

SELECT a.*
  FROM CDATA.service_agreement a
 WHERE a.soc_seq_no IN (202292854, 202292880)
;

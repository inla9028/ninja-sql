
UPDATE batch_tpid_extract a
   SET a.status_desc = SUBSTR(a.status_desc, 0, INSTR(a.status_desc, chr(10)))
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.status_desc    LIKE '%at no.netcom.%'
   AND a.request_time   > TO_DATE('2022-06-08', 'YYYY-MM-DD')
;

COMMIT WORK
;


UPDATE batch_tpid_extract a
   SET a.status_desc = SUBSTR(a.status_desc, INSTR(a.status_desc, 'PartyManagerException'))
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.status_desc    LIKE '%.PartyManagerException%'
   AND a.request_time   > TO_DATE('2022-06-08', 'YYYY-MM-DD')
;

COMMIT WORK
;


UPDATE party_manager_events a
   SET a.status_desc = SUBSTR(a.status_desc, 0, INSTR(a.status_desc, chr(10)))
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.status_desc    LIKE '%at no.netcom.%'
   AND a.request_time   > TO_DATE('2022-06-08', 'YYYY-MM-DD')
;

COMMIT WORK
;

UPDATE party_manager_events a
   SET a.status_desc = SUBSTR(a.status_desc, INSTR(a.status_desc, 'PartyManagerException'))
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.status_desc    LIKE '%.PartyManagerException%'
   AND a.request_time   > TO_DATE('2022-06-08', 'YYYY-MM-DD')
;

COMMIT WORK
;

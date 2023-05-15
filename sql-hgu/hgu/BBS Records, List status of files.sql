SELECT f.file_id, f.status, f.status_date, f.status_desc, f.filename,
       f.response_filename
     , r.request_id, r.request_type, r.enrollment_status,
       r.biller_account_no, r.thor_user_id, r.process_status,
       r.process_status_desc, r.request_status, r.was_closed_by,
       r.has_closed, r.dup_request_id, r.thor_user_key
  FROM bbs_files f, bbs_records r
 WHERE f.filename IN (
        'NETCOM_PAAMELD_01141613759.xml', 'NETCOM_PAAMELD_01143977650.xml', 'NETCOM_PAAMELD_01146206464.xml', 'NETCOM_PAAMELD_01146961544.xml',
        'NETCOM_PAAMELD_01149226287.xml', 'NETCOM_PAAMELD_01150850749.xml', 'NETCOM_PAAMELD_01152204597.xml', 'NETCOM_PAAMELD_01153497733.xml',
        'NETCOM_PAAMELD_01153843250.xml', 'NETCOM_PAAMELD_01154995075.xml', 'NETCOM_PAAMELD_01156855954.xml', 'NETCOM_PAAMELD_01157394355.xml',
        'NETCOM_PAAMELD_01158388363.xml', 'NETCOM_PAAMELD_01159883597.xml', 'NETCOM_PAAMELD_01161140178.xml', 'NETCOM_PAAMELD_01161490729.xml',
        'NETCOM_PAAMELD_01162952473.xml', 'NETCOM_PAAMELD_01164085846.xml', 'NETCOM_PAAMELD_01164796324.xml', 'NETCOM_PAAMELD_01165744120.xml',
        'NETCOM_PAAMELD_01167064759.xml', 'NETCOM_PAAMELD_01167812177.xml', 'NETCOM_PAAMELD_01168173130.xml', 'NETCOM_PAAMELD_01169605735.xml',
        'NETCOM_PAAMELD_01171331646.xml', 'NETCOM_PAAMELD_01172095416.xml', 'NETCOM_PAAMELD_01173031929.xml', 'request000413.xml',
        'request000415.xml', 'request000417.xml', 'request000418.xml', 'request000421.xml',
        'request000423.xml', 'request000429.xml', 'request000430.xml', 'request000450.xml',
        'request000451.xml'
   )
   AND f.file_id = r.file_id
   AND f.status_date > to_date('2017-06-09', 'YYYY-MM-DD')
 ORDER BY f.file_id, r.request_id
;


SELECT a.*
  FROM bbs_records a
 WHERE a.biller_account_no = '60050672525'
ORDER BY 1
;

SELECT a.*
  FROM bbs_files a
 WHERE a.file_id IN (114228,115525,115607,115688,115807,115926,116025,116185,116326)
;

SELECT f.status_date, f.filename, r.process_status, r.process_status_desc
  FROM bbs_files f, bbs_records r
 WHERE f.status = 'ERROR'
   AND f.status_desc LIKE 'For input string%'
   AND f.status_date > trunc(SYSDATE - 40, 'MON')
    AND f.file_id = r.file_id
GROUP BY f.status_date, f.filename, r.process_status, r.process_status_desc
ORDER BY 1,2,3,4
;

SELECT f.filename, count(1) AS "COUNT"
  FROM bbs_files f, bbs_records r
 WHERE f.status = 'ERROR'
   AND f.status_desc LIKE 'For input string%'
   AND f.status_date > trunc(SYSDATE - 40, 'MON')
    AND f.file_id = r.file_id
GROUP BY f.filename
ORDER BY 1
;


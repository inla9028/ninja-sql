SELECT a.ban, a.blseqno, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.cr_status, a.frmtcd, a.fullbill, a.coverind,
       a.reqtype, a.prttype, a.pgfrom, a.pgfto, a.noofcpy,
       a.subscriber_no, a.document_id, a.fid_no, a.print_ctg
  FROM ntcappo.central_reprint_request a
  WHERE a.ban = 776947608;

--
SELECT TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD') AS "SYS_CREATION_DATE", COUNT(*) AS "COUNT"
  FROM ntcappo.central_reprint_request a
  WHERE a.sys_creation_date > TO_DATE('2008-06-24', 'YYYY-MM-DD')
  GROUP BY TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD')
  ORDER BY "SYS_CREATION_DATE";

SELECT COUNT (1)
  FROM central_reprint_request
 WHERE TO_CHAR (sys_creation_date, 'DD/MM/YYYY') = '13/04/2009'
   AND application_id = 'NCNO';

SELECT a.*
  FROM central_reprint_request a
 WHERE TO_CHAR(a.sys_creation_date, 'DD/MM/YYYY') = '13/04/2009'
   AND a.application_id = 'NCNO';

SELECT TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD') AS "SYS_CREATION_DATE", a.application_id, COUNT(*) AS "COUNT"
  FROM ntcappo.central_reprint_request a
  WHERE a.sys_creation_date > TO_DATE('2009-04-14', 'YYYY-MM-DD')
  GROUP BY TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD'), a.application_id
  ORDER BY "SYS_CREATION_DATE", a.application_id;


SELECT a.company_name, a.action_code, a.pni_type, a.pni_code, a.request_id, a.process_status,
        RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM batch_pni_creation a
  WHERE a.enter_time > TRUNC(SYSDATE)
ORDER BY a.enter_time;

UPDATE batch_pni_creation a
   SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL, a.pni_code = NULL
 WHERE a.enter_time      > TRUNC(SYSDATE)
   AND A.ACTION_CODE     = 'I'
   AND a.process_status != 'WAITING';

-- CUG: Insert --
INSERT INTO batch_pni_creation (COMPANY_NAME,ACTION_CODE,PNI_TYPE,MEMBER_COUNT,REQUEST_ID,PROCESS_STATUS,STATUS_DESC,PNI_CODE,ENTER_TIME,REQUEST_TIME,PROCESS_TIME)
VALUES ('Cyberdyne Systems Inc.','I','C',666,'HGU 2011-04-13','WAITING',NULL,NULL,NULL,NULL,NULL);
--

-- CUG: Delete --
INSERT INTO batch_pni_creation (COMPANY_NAME,ACTION_CODE,PNI_TYPE,MEMBER_COUNT,REQUEST_ID,PROCESS_STATUS,STATUS_DESC,PNI_CODE,ENTER_TIME,REQUEST_TIME,PROCESS_TIME)
VALUES ('Cyberdyne Systems Inc.','D','C',666,'HGU 2011-04-13','WAITING',NULL,'CUG2GO',NULL,NULL,NULL);
--

-- VPN: Insert --
INSERT INTO batch_pni_creation (COMPANY_NAME,ACTION_CODE,PNI_TYPE,MEMBER_COUNT,REQUEST_ID,PROCESS_STATUS,STATUS_DESC,PNI_CODE,ENTER_TIME,REQUEST_TIME,PROCESS_TIME)
VALUES ('Cyberdyne Systems Inc.','I','V',666,'HGU 2011-04-13','WAITING',NULL,NULL,NULL,NULL,NULL);
--



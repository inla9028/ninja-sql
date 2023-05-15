-- 703 = Novotel, 881 = Trigcom

--==
--== Create the main port-entry
--==
INSERT INTO ninja_time_port
VALUES
(NULL,'TEMP Unassigned','NinjaInternal','04745833388',499949808,'703','703','815',SYSDATE,SYSDATE,SYSDATE,'Håkan is testing NC import','MOVE',0,'WAITING','NETCOM_MOVE')
/

--== Read the inserted row back and use it further down...
SELECT a.ninja_ref_id, a.ctn
  FROM ninja_time_port a
 WHERE a.ctn = '04745833388'
   AND a.ban = 499949808;

--==
--== Create the price plan and additional services...
--==
INSERT INTO ninja_time_port_services
VALUES
(890088,'BASIS','NET','A','N')
/
INSERT INTO ninja_time_port_services
VALUES
(890088,'MMS02','NET','A','N')
/
INSERT INTO ninja_time_port_services
VALUES
(890088,'MPOD09','NET','A','N')
/
INSERT INTO ninja_time_port_services
VALUES
(890088,'PSFH','NET','A','Y')
/
INSERT INTO ninja_time_port_services
VALUES
(890088,'VMFREE','NET','A','N')
/
INSERT INTO ninja_time_port_services
VALUES
(890088,'WDFPSFE','NET','A','N')
/

--==
--== Create the subscriber information...
--==
INSERT INTO ninja_time_port_sub_info
VALUES
(890088,'NET','A','Test-Move for Number Porting from Ninja/Håkan','000000000',NULL,'Y','PETTER','TESTMANN',NULL,'N','N','R','NOR','OSLO','0403','SANDAKERVEIEN','140',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Z')
/


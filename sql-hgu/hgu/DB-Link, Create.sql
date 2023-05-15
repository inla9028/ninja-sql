--------------------------------------------------------
--  DDL for DB Link FOKUS
--------------------------------------------------------

  CREATE DATABASE LINK "FOKUS"
   CONNECT TO "NTCAPPC_LNG5" IDENTIFIED BY VALUES '05A6D37359038DC1FD8C3294F7E198DDC00EC2BBCC721A6D71'
   USING 'FokusAT';


--------------------------------------------------------
--  DDL for DB Link FOKUS
--------------------------------------------------------

  CREATE DATABASE LINK "FOKUS"
   CONNECT TO "NTCAPPC_LNG5" IDENTIFIED BY VALUES '05A6D37359038DC1FD8C3294F7E198DDC00EC2BBCC721A6D71'
   USING 'FokusAT';


--
create database link "FOKUS"
 CONNECT TO "NTCNAPP5" IDENTIFIED BY VALUES '05F4BFB5AB6D7EC1D764523D5003021DAC65CB953136557F76'
using 'FOKUS_ST2'
;

--------------------------------------------------------
--  DDL for DB Link FOKUS_ST2
--------------------------------------------------------

  CREATE DATABASE LINK "FOKUS_ST2"
   CONNECT TO "NTCNAPP5" IDENTIFIED BY VALUES '05F4BFB5AB6D7EC1D764523D5003021DAC65CB953136557F76'
   USING '(DESCRIPTION =
    (ADDRESS_LIST = 
      (ADDRESS = 
        (PROTOCOL = TCP)
        (HOST = ftst.netcom.no)
        (PORT = 1521)
      )
    )
    (CONNECT_DATA = 
      (SERVER = DEDICATED)
      (SERVICE_NAME = test7)
    ))';

--------------------------------------------------------
--  DDL for DB Link PROD
--------------------------------------------------------

CREATE DATABASE LINK "PROD"
CONNECT TO "NINJAMAIN" IDENTIFIED BY "ninja2004"
USING '(DESCRIPTION=
  (CONNECT_TIMEOUT=1)
  (ADDRESS_LIST=
    (ADDRESS=(PROTOCOL=TCP)(HOST=aa161.netcom.no)(PORT=1521))
    (ADDRESS=(PROTOCOL=TCP)(HOST=aa146.netcom.no)(PORT=1521)))
  (CONNECT_DATA=(SERVICE_NAME=NI01PNSRV))
)';

-- AT

create database link "FOKUS"
  connect to "ntcappc_lng5" identified by "ntcappc_lng51"
  using '(DESCRIPTION =
    (ADDRESS_LIST = 
      (ADDRESS = 
        (PROTOCOL = TCP)
        (HOST = ninjatst.netcom.no)
        (PORT = 1521)
      )
    )
    (CONNECT_DATA = 
      (SERVER = DEDICATED)
      (SERVICE_NAME = n03ol1)
    ))';

-- Test

create database link "FOKUS"
  connect to "NTCNAPP5" identified by "NTCNAPP5"
  using '(DESCRIPTION =
    (ADDRESS_LIST = 
      (ADDRESS = 
        (PROTOCOL = TCP)
        (HOST = ftst.netcom.no)
        (PORT = 1521)
      )
    )
    (CONNECT_DATA = 
      (SERVER = DEDICATED)
      (SERVICE_NAME = test7)
    ))';

select a.*
  from subscriber@fokus a
 where a.subscriber_no = 'GSM047580009909048' 
;

drop database link "NINJARSTAGING"
;

create database link "NINJARSTAGING"
    connect to "NINJARSTAGING" IDENTIFIED BY "NINJARSTAGING"
    using '(DESCRIPTION=
  (CONNECT_TIMEOUT=1)
  (ADDRESS_LIST=
    (ADDRESS=(PROTOCOL=TCP)(HOST=no001ninjapdb.ddc.teliasonera.net)(PORT=1521))
    (ADDRESS=(PROTOCOL=TCP)(HOST=no002ninjapdb.ddc.teliasonera.net)(PORT=1521)))
  (CONNECT_DATA=(SERVICE_NAME=NI01PSRV))
)'
;

select * from dual@NINJARSTAGING;



drop database link "NINJARSTAGING2"
;

create database link "NINJARSTAGING2"
    connect to "NINJARSTAGING2" IDENTIFIED BY "NINJARSTAGING2"
    using '(DESCRIPTION=
  (CONNECT_TIMEOUT=1)
  (ADDRESS_LIST=
    (ADDRESS=(PROTOCOL=TCP)(HOST=no001ninjapdb.ddc.teliasonera.net)(PORT=1521))
    (ADDRESS=(PROTOCOL=TCP)(HOST=no002ninjapdb.ddc.teliasonera.net)(PORT=1521)))
  (CONNECT_DATA=(SERVICE_NAME=NI01PSRV))
)'
;

select * from dual@NINJARSTAGING2;


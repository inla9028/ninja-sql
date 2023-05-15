    echo  "whenever sqlerror exit sql.sqlcode
               set serveroutput on
               set pagesize 0
               EXECUTE  KONTANT.P_STATROHDATEN_IN7.SP_TEST_SKRIPT ('$CDR_FILENAME');"  | $ORACLE_HOME/bin/sqlplus -s $PA1


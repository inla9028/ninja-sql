--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the log for the current day.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.enter_date, a.procedure_name, a.message
  FROM ninja.dlr_imei_dupl_reg_log a
  WHERE a.enter_date > TRUNC(SYSDATE)
  ORDER BY a.enter_date;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the log for the current day, using a db-link from the Ninja DB.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.enter_date, a.procedure_name, a.message
  FROM ninja.dlr_imei_dupl_reg_log@ninjaprod a
  WHERE a.enter_date > TRUNC(SYSDATE)
  ORDER BY a.enter_date;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the last 15 rows of the log.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT *
  FROM (SELECT   a.enter_date, a.procedure_name, a.message
            FROM ninja.dlr_imei_dupl_reg_log a
        ORDER BY a.enter_date DESC)
 WHERE ROWNUM < 16
 ORDER BY enter_date ASC;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the last 15 rows of the log, using a db-link from the Ninja DB.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT *
  FROM (SELECT   a.enter_date, a.procedure_name, a.message
            FROM ninja.dlr_imei_dupl_reg_log@ninjaprod a
        ORDER BY a.enter_date DESC)
 WHERE ROWNUM < 16
 ORDER BY enter_date ASC;


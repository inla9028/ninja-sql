SELECT a.subscriber_no, a.dealer_code, a.num_loc, a.num_group,
       a.num_length, a.physical_hlr, a.ctn, a.process_status,
       a.process_time, REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM hgu_change_msisdn a
-- WHERE a.process_status = 'PRSD_SUCCESS'
-- WHERE a.process_status = 'PRSD_ERROR'
ORDER BY a.process_status, a.subscriber_no
;

/*
** Overview...
*/
SELECT a.dealer_code, a.num_loc, a.num_group, a.num_length, a.physical_hlr, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.544) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*)   * 1.544) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM hgu_change_msisdn a
GROUP BY a.dealer_code, a.num_loc, a.num_group, a.num_length, a.physical_hlr, a.process_status
ORDER BY a.dealer_code, a.num_loc, a.num_group, a.num_length, a.physical_hlr, a.process_status
;

/*
** List the failed records.
*/
SELECT a.subscriber_no, a.dealer_code, a.num_loc, a.num_group, a.num_length, a.physical_hlr, a.ctn,
       REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM hgu_change_msisdn a
 WHERE a.process_status = 'PRSD_ERROR'
ORDER BY "STATUS_DESC", a.subscriber_no
;

/*
** List an overview of the errors...
*/
SELECT a.process_status,
       REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC",
       COUNT(*) AS "COUNT"
  FROM hgu_change_msisdn a
 WHERE a.process_status = 'PRSD_ERROR'
GROUP BY a.process_status, REPLACE(RTRIM(SUBSTR(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')), INSTR(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')), 'Exception: '))), 'Exception: ', '')
ORDER BY 3 DESC
;

/*
** Clear allocated numbers and reset failed MSISDN changes.
*/
UPDATE hgu_change_msisdn a
   SET a.ctn = NULL, a.process_status = 'WAITING', a.process_time = NULL
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.status_desc NOT LIKE '%not active%'
;


/*
** Calculate the average number of processed records per minute, for the last
** 15 minutes...
*/
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"),      '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM hgu_change_msisdn a
     WHERE a.process_status    IN ('PRSD_SUCCESS', 'PRSD_ERROR')
       AND a.process_time      IS NOT NULL
    GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
    ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);


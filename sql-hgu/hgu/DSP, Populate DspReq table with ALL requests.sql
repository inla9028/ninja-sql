/*
** Insert ALL records from the materialized view.
*/
INSERT INTO dsp_request
SELECT NULL               AS "REQUEST_ID"
     , ban                AS "CUSTOMER_ID"
     , first_name         AS "ADR_FIRST_NAME"
     , last_business_name AS "ADR_LAST_NAME"
     , birth_date         AS "ADR_BIRTH_DATE"
     , adr_zip
     , NULL               AS "RECORD_CREATION_DATE"
     , 'IN_PROGRESS'      AS "PROCESS_STATUS"
     , 'HGU '|| TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_USER_ID"
     , NULL               AS "PROCESS_TIME"
     , NULL               AS "STATUS_DESC"
     , subscriber_no
     , link_type
     , comp_reg_id
  FROM dsf_info@nrep11 di
;

/*
** Commit.
*/
COMMIT WORK
;

/*
** Clear the rowid's...
*/
DELETE
  FROM tmp_rowid_list
;

/*
** Remove any records that we've already tried today, it could be a few thousand.
*/
INSERT INTO tmp_rowid_list
SELECT rq.ROWID AS "ID"
  FROM dsp_request rq
 WHERE rq.request_user_id = 'HGU '|| TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND 0 < (SELECT COUNT(1)
              FROM dsp_request a
             WHERE a.ROWID          != rq.ROWID
               AND a.customer_id     = rq.customer_id
               AND a.link_type       = rq.link_type
               AND a.subscriber_no   = rq.subscriber_no)
;

/*
** Commit.
*/
COMMIT WORK
;

/*
** Remove any records with an empty first name (i.e. ".").
*/
INSERT INTO tmp_rowid_list
SELECT rq.ROWID AS "ID"
  FROM dsp_request rq
 WHERE rq.request_user_id = 'HGU '|| TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND rq.process_status  = 'IN_PROGRESS'
   AND rq.adr_first_name  = '.'
;

/*
** Commit.
*/
COMMIT WORK
;

/*
** List status...
*/
SELECT rq.request_user_id, rq.process_status, COUNT(1) AS "COUNT"
  FROM dsp_request rq
 WHERE rq.request_user_id = 'HGU '|| TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY rq.request_user_id, rq.process_status
ORDER BY 1, 2
;


/*
** Run the stored procedure to remove these lines...
*/
DECLARE
BEGIN
  ninjamain.hgu_utils.delete_old_data
    (l_delete_buffer_size=>5000);
END;

/*
** Clear the rowid's...
*/
DELETE
  FROM tmp_rowid_list
;

/*
** Commit.
*/
COMMIT WORK
;

/*
** List status...
*/
SELECT rq.request_user_id, rq.process_status, COUNT(1) AS "COUNT"
  FROM dsp_request rq
 WHERE rq.request_user_id = 'HGU '|| TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY rq.request_user_id, rq.process_status
ORDER BY 1, 2
;

/*
** On my command, unleash hell!
*/
UPDATE dsp_request rq
   SET rq.process_status  = 'WAITING'
 WHERE rq.request_user_id = 'HGU '|| TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND rq.process_status  = 'IN_PROGRESS'
;

/*
** Commit.
*/
COMMIT WORK
;

/*
** List status...
*/
SELECT rq.request_user_id, rq.process_status, COUNT(1) AS "COUNT"
  FROM dsp_request rq
 WHERE rq.request_user_id = 'HGU '|| TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY rq.request_user_id, rq.process_status
ORDER BY 1, 2
;


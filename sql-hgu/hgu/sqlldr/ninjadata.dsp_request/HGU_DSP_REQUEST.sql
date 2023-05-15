/*
** Populate response table.
*/
INSERT INTO hgu_dsp_response
SELECT rs.request_id, rq.request_user_id, rs.adr_last_name, rs.adr_first_name,
       rs.adr_birth_date, rs.adr_city, rs.adr_zip, rs.adr_house_no,
       rs.adr_street_name, rs.adr_pob, rs.adr_country, rs.adr_house_letter,
       rs.adr_storey, rs.adr_door_no, rs.adr_district, rs.adr_gender,
       rs.adr_stat, rs.dsp_id, rs.record_creation_date, rs.process_status,
       rs.process_time, rs.status_desc
  FROM ninjadata.dsp_response rs, ninjadata.dsp_request rq
 WHERE rq.customer_id = 0
   AND rq.request_id  = rs.request_id
;

/*
** Commit.
*/
COMMIT WORK
;

/*
** Display nr of lines...
*/
SELECT rs.process_status, COUNT(1) AS "COUNT"
  FROM hgu_dsp_response rs
GROUP BY rs.process_status
ORDER BY rs.process_status
;


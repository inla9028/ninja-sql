SELECT a.transaction_no, a.ban, a.subscriber_no, a.price_plan,
       a.tb_cug_code, a.vpn_code, a.cug_code, a.adt_soc_1, a.adt_soc_2,
       a.adt_soc_3, a.adt_soc_4, a.dealer_code, a.sales_agent,
       a.publish_level, a.user_first, a.surname, a.bill_info,
       a.role_ind, a.birth_date, a.adr_type, a.city, a.zip_code,
       a.country, a.street_name, a.house_no, a.house_letter, a.floor,
       a.door_no, a.p_o_box, a.area_pob_name, a.email, a.co_name,
       a.requestor_id, a.process_time, a.process_status, a.status_desc
  FROM ninjadata.cda_batch_activations a
  WHERE a.requestor_id = 'TFS 01.04.2011'
    AND a.process_status = 'PRSD_ERROR';


--== Display the status of these requests
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.cda_batch_activations a
  WHERE a.requestor_id = 'TFS 01.04.2011'
  GROUP BY a.process_status;


--== Display records that failed, with complete status description
SELECT a.subscriber_no, a.status_desc
  FROM ninjadata.cda_batch_activations a
  WHERE a.requestor_id   = 'TFS 01.04.2011'
    AND a.process_status = 'PRSD_ERROR';


--== Display records that failed, with trimmed status description
SELECT a.subscriber_no, substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID')) AS "STATUS_DESC"
  FROM ninjadata.cda_batch_activations a
  WHERE a.requestor_id   = 'TFS 01.04.2011'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no;


--== Pause all waiting requests...
UPDATE ninjadata.cda_batch_activations a
  SET a.process_status = 'IN_PROGRESS'
  WHERE a.requestor_id   = 'TFS 01.04.2011'
    AND a.process_status = 'WAITING';


--== Resume all paused records
UPDATE ninjadata.cda_batch_activations a
   SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
 WHERE a.requestor_id   = 'TFS 01.04.2011'
   AND a.process_status = 'IN_PROGRESS';


--== Display the waiting request id's.
SELECT a.requestor_id, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.cda_batch_activations a
 WHERE a.process_status IN ( 'WAITING', 'IN_PROGRESS' )
  GROUP BY a.requestor_id, a.process_status
  ORDER BY a.requestor_id, a.process_status;



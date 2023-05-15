--
SELECT a.trans_number, a.ban, a.enter_time, a.request_time,
       a.process_time, a.process_status, a.status_desc, a.priority,
       a.request_id
  FROM ninjadata.ban_tree_member_removal a
  WHERE a.request_id     = 'KJWI0767 2007-05-25'
    AND a.process_status = 'PRSD_ERROR'

--
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.ban_tree_member_removal a
  WHERE a.request_id = 'KJWI0767 2007-05-25'
  GROUP BY a.process_status

--
UPDATE ninjadata.ban_tree_member_removal a
  SET a.process_status = 'WAITING'
  WHERE a.request_id = 'KJWI0767 2007-05-25'


--
SELECT a.trans_number, a.ban, a.enter_time, a.request_time,
       a.process_time, a.process_status, a.status_desc, a.priority,
       a.request_id
  FROM ninjadata.ban_tree_member_removal a
  WHERE a.trans_number > (
    SELECT MAX(b.trans_number) - 10
      FROM ninjadata.ban_tree_member_removal b
  )

/*
SELECT COUNT(*) as "COUNT"
  FROM ninjadata.ban_tree_member_removal a
  WHERE a.request_id = 'KJWI0767 2007-05-25'
*/

--== Display errors only...
SELECT a.ban, a.process_time, a.process_status, a.status_desc
  FROM ninjadata.ban_tree_member_removal a
  WHERE a.request_id     = 'KJWI0767 2007-05-25'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.process_time, a.ban



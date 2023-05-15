SELECT a.subscriber_no, a.customer_id, a.listed_ind, a.next_ban,
       a.effective_date, a.publish_level, a.allow_advertising_ind,
       a.rms_ref_od, a.sys_creation_date, a.sys_update_date,
       a.sub_status, a.commit_start_date, a.commit_end_date,
       a.sub_status_rsn_code, a.ctn_seq_no, a.sys_changed_date
  FROM dd.subscriber a
  WHERE a.publish_level LIKE 'Ingen%'

SELECT RTRIM(NVL(a.publish_level, 'N/A')) AS "PUBLISH_LEVEL", COUNT(*) AS "COUNT"
  FROM subscriber a
  GROUP BY RTRIM(NVL(a.publish_level, 'N/A'))
  ORDER BY "PUBLISH_LEVEL"


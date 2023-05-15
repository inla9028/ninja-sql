SELECT a.subscriber_no, a.soc, a.action, a.feature, a.parameter,
       a.parm_value, a.request_id, a.memo_text, a.feature2,
       a.parameter2, a.parm_value2, a.feature3, a.parameter3,
       a.parm_value3, a.feature4, a.parameter4, a.parm_value4
  FROM ninjateam.mw_tmp_trans a

/*
INSERT INTO ninjateam.mw_tmp_trans
  SELECT a.subscriber_no, a.soc, a.action_code, NULL, NULL, NULL, 'TRANSFER 27.07.2006',
         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM ninjadata.service_transactions a
    WHERE a.process_status = 'TRANSFER'
      and a.status_desc    = 'TRANSFER 2006.07.27'
    order by a.trans_number
*/

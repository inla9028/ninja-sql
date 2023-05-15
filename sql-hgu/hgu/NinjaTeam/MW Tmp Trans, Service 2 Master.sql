SELECT a.subscriber_no, a.soc, a.action, a.feature, a.parameter,
       a.parm_value, a.request_id, a.memo_text, a.feature2,
       a.parameter2, a.parm_value2, a.feature3, a.parameter3,
       a.parm_value3, a.feature4, a.parameter4, a.parm_value4
  FROM ninjateam.mw_tmp_trans a

--== Copy all waiting entries from service_transactions...
INSERT INTO ninjateam.mw_tmp_trans (
       subscriber_no, soc, action, feature, parameter,
       parm_value, request_id, memo_text, feature2,
       parameter2, parm_value2, feature3, parameter3,
       parm_value3, feature4, parameter4, parm_value4
    )
    SELECT 
      b.subscriber_no, b.soc, b.action_code, NULL, NULL,
      NULL, 'TRANS 2007.01.15', NULL, NULL,
      NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL
      FROM ninjadata.service_transactions b
      WHERE b.process_status = 'TRANSFER'
        AND b.status_desc    = 'TRANSFER 2007.01.15'
      ORDER BY b.priority, b.trans_number



/*
** Insert rows to replace MCTB5 with MCTBFREE
*/
INSERT INTO mw_tmp_trans
(
    subscriber_no, soc, action,
    feature, parameter, parm_value,
    request_id,
    memo_text,
    feature2, parameter2, parm_value2,
    feature3, parameter3, parm_value3, feature4, parameter4, parm_value4,
    dealer_code, sales_agent
)
SELECT a.subscriber_no, 'MCTBFREE', 'ADD',
       a.ftr1, a.param1, a.value1,
       'TB ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD'),
       'Replacing MCTB5 with MCTBFREE due to TB conversion',
       a.ftr2, a.param2, a.value2,
       NULL, NULL, NULL, NULL, NULL, NULL,
       NULL, NULL
  FROM tmp_hgu_ftr_current a
 WHERE a.soc = 'MCTB5'
;


/*
** Insert rows to add MCTBCHG1 charge soc, for MCTB5 -> MCTBFREE converted.
*/
INSERT INTO mw_tmp_trans
(
    subscriber_no, soc, action,
    feature, parameter, parm_value,
    request_id,
    memo_text,
    feature2, parameter2, parm_value2,
    feature3, parameter3, parm_value3, feature4, parameter4, parm_value4,
    dealer_code, sales_agent
)
SELECT a.subscriber_no, 'MCTBCHG1', 'ADD',
       NULL, NULL, NULL,
       'TB ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD'),
       'Adding TB charge soc due to TB conversion',
       NULL, NULL, NULL,
       NULL, NULL, NULL, NULL, NULL, NULL,
       NULL, NULL
  FROM tmp_hgu_ftr_current a
 WHERE a.soc = 'MCTB5'
;


/*
** Insert rows to add MCTBCHG1 charge soc, for current MCTBFREE subscribers.
*/
INSERT INTO mw_tmp_trans
(
    subscriber_no, soc, action,
    feature, parameter, parm_value,
    request_id,
    memo_text,
    feature2, parameter2, parm_value2,
    feature3, parameter3, parm_value3, feature4, parameter4, parm_value4,
    dealer_code, sales_agent
)
SELECT a.subscriber_no, 'MCTBCHG1', 'ADD',
       NULL, NULL, NULL,
       'TB ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD'),
       'Adding TB charge soc due to TB conversion',
       NULL, NULL, NULL,
       NULL, NULL, NULL, NULL, NULL, NULL,
       NULL, NULL
  FROM tmp_hgu_ftr_current a
 WHERE a.soc = 'MCTBFREE'
;


/*
** Display a summary
*/
SELECT DECODE(a.soc,
              'MCTB5', 'Replace with MCTBFREE and add MCTBCHG1',
              'MCTBFREE', 'Add MCTBCHG1 on existing MCTBFREE subscriber',
              'ERROR (' || a.soc || ')'
       ) AS "OPERATION", COUNT(*) AS "COUNT"
  FROM tmp_hgu_ftr_current a
GROUP BY DECODE(a.soc,
              'MCTB5', 'Replace with MCTBFREE and add MCTBCHG1',
              'MCTBFREE', 'Add MCTBCHG1 on existing MCTBFREE subscriber',
              'ERROR (' || a.soc || ')'
       )
ORDER BY "OPERATION"
;


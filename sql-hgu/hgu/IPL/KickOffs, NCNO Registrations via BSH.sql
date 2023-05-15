SELECT a.attempt_id, a.attempt_date, a.attempt_type, a.telephonenumber,
       a.historical_invoices, a.all_result, a.all_result_date,
       a.soc_result, a.soc_result_date, a.crr_result, a.crr_result_date,
       a.soc_failure_cause, a.crr_failure_cause, a.all_failure_cause,
       a.crr_retried, a.soc_retried, a.retry_generation,
       a.retry_source_attempt_id, a.soc_failure_cause_complete,
       a.crr_failure_cause_complete, a.all_failure_cause_complete
  FROM kickoffs a
  WHERE a.attempt_date BETWEEN TO_DATE('2008-11-20', 'YYYY-MM-DD') AND TO_DATE('2008-11-30', 'YYYY-MM-DD');

--
SELECT a.attempt_id, a.attempt_date, a.attempt_type, a.telephonenumber,
       a.historical_invoices, a.all_result, a.all_result_date,
       a.soc_result, a.soc_result_date, a.crr_result, a.crr_result_date,
       a.soc_failure_cause, a.crr_failure_cause, a.all_failure_cause,
       a.crr_retried, a.soc_retried, a.retry_generation,
       a.retry_source_attempt_id, a.soc_failure_cause_complete,
       a.crr_failure_cause_complete, a.all_failure_cause_complete
  FROM kickoffs a
  WHERE TRUNC(a.attempt_date) = TO_DATE('2009-04-13', 'YYYY-MM-DD');

--
SELECT a.attempt_id, a.attempt_date, a.attempt_type, a.telephonenumber,
       a.historical_invoices, a.all_result, a.all_result_date,
       a.soc_result, a.soc_result_date, a.crr_result, a.crr_result_date,
       a.soc_failure_cause, a.crr_failure_cause, a.all_failure_cause,
       a.crr_retried, a.soc_retried, a.retry_generation,
       a.retry_source_attempt_id, a.soc_failure_cause_complete,
       a.crr_failure_cause_complete, a.all_failure_cause_complete
  FROM kickoffs a
  WHERE TRUNC(a.attempt_date) = TO_DATE('2009-04-13', 'YYYY-MM-DD')
    AND a.all_result = 1;

--
SELECT a.attempt_id, a.attempt_date, a.attempt_type, a.telephonenumber,
       a.historical_invoices, a.all_result, a.all_result_date,
       a.soc_result, a.soc_result_date, a.crr_result, a.crr_result_date,
       a.soc_failure_cause, a.crr_failure_cause, a.all_failure_cause,
       a.crr_retried, a.soc_retried, a.retry_generation,
       a.retry_source_attempt_id, a.soc_failure_cause_complete,
       a.crr_failure_cause_complete, a.all_failure_cause_complete
  FROM kickoffs a
  WHERE TRUNC(a.attempt_date) = TO_DATE('2009-04-13', 'YYYY-MM-DD')
    AND a.all_result != 1;

SELECT TO_CHAR(a.attempt_date, 'YYYY-MM-DD') AS "ATTEMPT_DATE", COUNT(*) AS "COUNT"
  FROM kickoffs a
  WHERE a.attempt_id > 350000
  GROUP BY TO_CHAR(a.attempt_date, 'YYYY-MM-DD')
  ORDER BY "ATTEMPT_DATE";



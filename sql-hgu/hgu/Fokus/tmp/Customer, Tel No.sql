/* Formatted on 2010/11/19 10:55 (Formatter Plus v4.8.7) */
SELECT a.*
  FROM billing_account a
 WHERE a.ban = 919054601;
 
SELECT a.customer_telno FROM customer a WHERE a.customer_id = 919054601;
SELECT a.* FROM customer a WHERE a.customer_id = 919054601;

SELECT LENGTH(TRIM(a.customer_telno)) AS "TF_ADM_TLF_LENGTH", COUNT(*) AS "COUNT"
  FROM customer a
-- WHERE a.customer_id = 919054601
 GROUP BY LENGTH(TRIM(a.customer_telno))
 ORDER BY "TF_ADM_TLF_LENGTH";


/* Formatted on 2010/11/19 11:25 (Formatter Plus v4.8.7) */
SELECT table_name, column_name
  FROM all_tab_columns
 WHERE column_name LIKE '%TEL%NO%';


--==
SELECT   a.*
    FROM subscriber a
   WHERE a.subscriber_no = 'GSM04745487344'
ORDER BY a.effective_date, a.init_activation_date;


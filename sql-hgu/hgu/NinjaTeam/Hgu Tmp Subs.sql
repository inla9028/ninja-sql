SELECT a.subscriber_no, a.soc
  FROM hgu_tmp_subs a
;

UPDATE hgu_tmp_subs a
   SET a.subscriber_no = 'GSM'||a.subscriber_no
 WHERE a.subscriber_no LIKE '047%'
;

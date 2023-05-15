/*
** OLD CALLS - OLD CALLS - OLD CALLS - OLD CALLS - OLD CALLS - OLD CALLS
*/
--== Display all _OLD_ calls & MMSes etc to a number.
SELECT a.*
  FROM mdusg.usg_hi a
 WHERE a.a_number = '4745679855'
ORDER BY a.call_date, a.call_time
 ;

--== Display all calls & MMSes etc to a number, grouped.
SELECT   a.subscriber_no, COUNT (*) AS "COUNT"
    FROM mdusg.usg_hi a
   WHERE a.a_number = '4745679855'
GROUP BY a.subscriber_no
ORDER BY "COUNT" DESC, a.subscriber_no
;

--== Display all calls & MMSes etc to a number, grouped.
SELECT   a.subscriber_no, a.at_feature_code, COUNT (*) AS "COUNT"
    FROM mdusg.usg_hi a
   WHERE a.a_number = '4745679855'
GROUP BY a.subscriber_no, a.at_feature_code
ORDER BY "COUNT" DESC, a.at_feature_code, a.subscriber_no
;

/*
** NEW CALLS - NEW CALLS - NEW CALLS - NEW CALLS - NEW CALLS - NEW CALLS
*/

--== Display all _NEW_ calls & MMSes etc to a number.
SELECT a.*
  FROM mdusg.usg_out a
 WHERE a.a_number = '4745679855'
ORDER BY a.call_date, a.call_time
;
 
 --== Display all calls & MMSes etc to a number, grouped.
SELECT   a.subscriber_no, COUNT (*) AS "COUNT"
    FROM mdusg.usg_out a
   WHERE a.a_number = '4745679855'
GROUP BY a.subscriber_no
ORDER BY "COUNT" DESC, a.subscriber_no
;

--== Display all calls & MMSes etc to a number, grouped.
SELECT   a.subscriber_no, a.at_feature_code, COUNT (*) AS "COUNT"
    FROM mdusg.usg_out a
   WHERE a.a_number = '4745679855'
GROUP BY a.subscriber_no, a.at_feature_code
;

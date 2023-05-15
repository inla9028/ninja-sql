--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all rows
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.server_name, a.process_time, a.process_name, a.duration
  FROM hgu_nsl_response_logger a

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display an overview of the number of different requests, for all servers.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.server_name, TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME",
       a.process_name, COUNT(*) AS "COUNT"
  FROM hgu_nsl_response_logger a
  GROUP BY a.server_name, TO_CHAR(a.process_time, 'YYYY-MM-DD'), a.process_name
  ORDER BY a.server_name, "PROCESS_TIME", a.process_name;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the number of unique processes/requests for all servers.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME", a.process_name,
       a.server_name, COUNT(*) AS "COUNT"
  FROM hgu_nsl_response_logger a
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD'), a.process_name, a.server_name
  ORDER BY "PROCESS_TIME", a.process_name, a.server_name;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the number of unique processes/requests for all servers, ignoring dates.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_name, a.server_name, COUNT(*) AS "COUNT"
  FROM hgu_nsl_response_logger a
  GROUP BY a.process_name, a.server_name
  ORDER BY a.process_name, a.server_name;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display an overview of the number of specific requests, for all servers.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.server_name, TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME",
       a.process_name, COUNT(*) AS "COUNT"
  FROM hgu_nsl_response_logger a
  WHERE a.process_name IN ('v1_2_getSubscriptionDataExecutor', 'v1_2_getSubscriptionDetailsExecutor', 'v1_3_getSubscriptionDataExecutor')
  GROUP BY a.server_name, TO_CHAR(a.process_time, 'YYYY-MM-DD'), a.process_name
  ORDER BY a.server_name, "PROCESS_TIME", a.process_name;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all rows
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.server_name, a.process_time, a.process_name, a.duration,
       (CEIL(a.duration/1000) * 1000) AS "DUR_CEIL",
       (FLOOR(a.duration/1000) * 1000) AS "DUR_FLOOR",
       (TO_CHAR(FLOOR(a.duration/1000) * 1000) || '-' || TO_CHAR(CEIL(a.duration/1000) * 1000)) AS "INTERVAL"
  FROM hgu_nsl_response_logger a
  WHERE a.process_name IN ('v1_2_getSubscriptionDataExecutor')
    AND a.server_name = 'ninjaprod01z'
    AND ROWNUM < 51

;
--== Display the number of calls within a specific interval, for a specific
--== method/process.
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME", a.server_name, a.process_name, 
       LTRIM((TO_CHAR(FLOOR(a.duration/1000) * 1000, '00999') || '-' || LTRIM(TO_CHAR(CEIL(a.duration/1000) * 1000, '00999')))) AS "INTERVAL",
       COUNT(*) AS "COUNT"
  FROM hgu_nsl_response_logger a
  WHERE a.process_name IN ('v1_2_getSubscriptionDataExecutor', 'v1_2_getSubscriptionDetailsExecutor', 'v1_3_getSubscriptionDataExecutor')
--    AND a.server_name = 'ninjaprod01z'
--    AND ROWNUM < 501
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD'), a.server_name, a.process_name
           ,LTRIM((TO_CHAR(FLOOR(a.duration/1000) * 1000, '00999') || '-' || LTRIM(TO_CHAR(CEIL(a.duration/1000) * 1000, '00999'))))
  ORDER BY "PROCESS_TIME", a.server_name, a.process_name, "INTERVAL";

--== Display the number of calls within a specific interval, for a specific
--== method/process, but not printing the actual method/process.
SELECT "PROCESS_TIME", "SERVER_NAME", "INTERVAL", "COUNT" FROM (
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME", a.server_name, FLOOR(a.duration/1000) * 1000 AS "DURATION",
       (TO_CHAR(FLOOR(a.duration/1000) * 1000) || '-' || TO_CHAR(CEIL(a.duration/1000) * 1000)) AS "INTERVAL",
       COUNT(*) AS "COUNT"
  FROM hgu_nsl_response_logger a
  WHERE a.process_name IN ('v1_2_getSubscriptionDataExecutor', 'v1_2_getSubscriptionDetailsExecutor', 'v1_3_getSubscriptionDataExecutor')
--    AND a.server_name = 'ninjaprod01z'
--    AND ROWNUM < 501
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD'), a.server_name, FLOOR(a.duration/1000) * 1000
           ,(TO_CHAR(FLOOR(a.duration/1000) * 1000) || '-' || TO_CHAR(CEIL(a.duration/1000) * 1000))
  ORDER BY "PROCESS_TIME", a.server_name, "DURATION"
  );

--== Display the number of calls within a specific interval, for a specific
--== method/process, but not printing the actual method/process or server.
SELECT "PROCESS_TIME", "INTERVAL", "COUNT" FROM (
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME", LEAST(30000, FLOOR(a.duration/1000) * 1000) AS "DURATION",
       (TO_CHAR(LEAST(30000, FLOOR(a.duration/1000) * 1000)) || '-' || TO_CHAR(LEAST(30000, CEIL(a.duration/1000) * 1000))) AS "INTERVAL",
       COUNT(*) AS "COUNT"
  FROM hgu_nsl_response_logger a
  WHERE a.process_name IN ('v1_2_getSubscriptionDataExecutor', 'v1_2_getSubscriptionDetailsExecutor', 'v1_3_getSubscriptionDataExecutor')
--    AND a.server_name = 'ninjaprod01z'
--    AND ROWNUM < 5001
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD'), LEAST(30000, FLOOR(a.duration/1000) * 1000)
           ,(TO_CHAR(LEAST(30000, FLOOR(a.duration/1000) * 1000)) || '-' || TO_CHAR(LEAST(30000, CEIL(a.duration/1000) * 1000)))
  ORDER BY "PROCESS_TIME", "DURATION"
  );



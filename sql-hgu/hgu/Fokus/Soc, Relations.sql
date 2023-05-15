--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (?) relations for a specific soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.*
    FROM soc_relation a
   WHERE 'NTSLPPFF' IN (RTRIM (a.soc_src), RTRIM (a.soc_dest))
     AND SYSDATE BETWEEN a.src_effective_date AND NVL (a.expiration_date, SYSDATE + 1)
ORDER BY a.soc_src, a.soc_dest;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all illegal combinations for a specific soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.*
    FROM soc_relation@fokus a
   WHERE 'NTSLPPFF' IN (RTRIM (a.soc_src), RTRIM (a.soc_dest))
     AND SYSDATE BETWEEN a.src_effective_date AND NVL (a.expiration_date, SYSDATE + 1)
ORDER BY a.soc_src, a.soc_dest;


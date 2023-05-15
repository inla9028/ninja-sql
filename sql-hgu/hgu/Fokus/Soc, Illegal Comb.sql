--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (illegal?) combinations for a specific soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.*
    FROM soc_illegal_comb a
   WHERE 'TBSTATSUB'      IN (RTRIM (a.soc_first), RTRIM (a.soc_second))
     AND SYSDATE     BETWEEN a.effective_date AND NVL (a.expiration_date, SYSDATE + 1)
ORDER BY a.soc_first, a.soc_second;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all _mandatory_ combinations for a specific soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.*
    FROM soc_illegal_comb@fokus a
   WHERE 'MCTBFREE'         IN (RTRIM (a.soc_first), RTRIM (a.soc_second))
     AND SYSDATE       BETWEEN a.effective_date AND NVL (a.expiration_date, SYSDATE + 1)
     AND a.illegal_ind       = 'T'
ORDER BY a.soc_first, a.soc_second;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all _illegal_ combinations for a specific soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.*
    FROM soc_illegal_comb@fokus a
   WHERE 'BARORXD'          IN (RTRIM (a.soc_first), RTRIM (a.soc_second))
     AND SYSDATE       BETWEEN a.effective_date AND NVL (a.expiration_date, SYSDATE + 1)
     AND a.illegal_ind       = 'Y'
ORDER BY a.soc_first, a.soc_second;


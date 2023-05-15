/*
**
** This is the same query as is used by Ninja Core (CTNHelper.getAvailableCtnsInformation)
** to look up available numbers when no SIM number is used (thus no HLR).
**
** +--------+---------------------------+------------------------+-----------------+--------------+---------------+---------------------------+
** | BRAND  | TELEPHONE_NUMBER_CATEGORY | TELEPHONE_NUMBER_CLASS | NUMBER_LOCATION | NUMBER_GROUP | NUMBER_LENGTH | COMMENTS                  |
** +--------+---------------------------+------------------------+-----------------+--------------+---------------+---------------------------+
** | NETCOM | M2M                       | REGULAR                | MTM             | M2M          | 12            | NetCom machine to machine |
** | NETCOM | MBB                       | REGULAR                | NET             | MBB          | 12            | NetCom mobile broadband   |
** | CHESS  | MBB                       | REGULAR                | CHE             | CBB          | 12            | Chess mobile broadband    |
** | CHESS  | MOBILE                    | GOLD                   | CGN             | CN           | 8             | Chess mobile gold         |
** | NETCOM | MOBILE                    | REGULAR                | NET             | A            | 8             | NetCom mobile             |
** | CHESS  | MOBILE                    | REGULAR                | CHE             | CN           | 8             | Chess mobile              |
** | CHESS  | MOBILE                    | SILVER                 | CSN             | CN           | 8             | Chess mobile silver       |
** +--------+---------------------------+------------------------+-----------------+--------------+---------------+---------------------------+
**
*/
SELECT t2.ctn, t2.ctn_status, t2.nl, t2.ngp
  FROM nl_dealer_link t1, tn_inv t2
 WHERE 1 = 1
   AND t1.dealer_code                               = 'NWCO'
   AND t1.effective_date                           <= TRUNC(SYSDATE)
   AND nvl(t1.expiration_date, trunc(SYSDATE) + 1) >= TRUNC(SYSDATE)
   AND t2.ngp                                       = 'MBB'        -- NUMBER_GROUP
   AND t2.ctn_status                                = 'AA'
   AND t1.nl_id                                  LIKE 'FWA'      -- NUMBER_LOCATION
   AND t2.nl                                        = t1.nl_id
   AND LENGTH(t2.ctn)                               = 12 + 3      -- TELEPHONE_NUMBER_CATEGORY
   AND ROWNUM                                      <= 1500
;

SELECT /*+ driving_site(t1)*/ t2.ctn, t2.ctn_status, t2.nl, t2.ngp
  FROM nl_dealer_link@fokus t1, tn_inv@fokus t2
 WHERE 1 = 1
   AND t1.dealer_code                               = 'NWCO'
   AND t1.effective_date                           <= TRUNC(SYSDATE)
   AND nvl(t1.expiration_date, trunc(SYSDATE) + 1) >= TRUNC(SYSDATE)
   AND t2.ngp                                       = 'MBB'        -- NUMBER_GROUP
   AND t2.ctn_status                                = 'AA'
   AND t1.nl_id                                  LIKE 'FWA'      -- NUMBER_LOCATION
   AND t2.nl                                        = t1.nl_id
   AND LENGTH(t2.ctn)                               = 12 + 3      -- TELEPHONE_NUMBER_CATEGORY
   AND ROWNUM                                      <= 1500
;

/*
**
** List the available number locations.
**
*/
SELECT t2.nl, t2.ngp, LENGTH(t2.ctn) as "CTN_LENGTH", COUNT(1) as "COUNT"
  FROM tn_inv t2
 WHERE t2.ctn_status = 'AA'
GROUP BY t2.nl, t2.ngp, LENGTH(t2.ctn)
ORDER BY t2.nl, t2.ngp, LENGTH(t2.ctn)
;

SELECT /*+ driving_site(t2)*/ t2.nl, t2.ngp, LENGTH(t2.ctn) AS "CTN_LENGTH", count(1) AS "COUNT"
  FROM tn_inv@fokus t2
 WHERE t2.ctn_status = 'AA'
   AND t2.ngp        = 'MBB'
GROUP BY t2.nl, t2.ngp, LENGTH(t2.ctn)
ORDER BY t2.nl, t2.ngp, LENGTH(t2.ctn)
;

/*
** The actual query by Ninja Core in DK AT 2012-08-24.
*/
SELECT t2.ctn, t2.ctn_status, t2.nl, t2.ngp
  FROM nl_dealer_link t1, tn_inv t2
 WHERE t1.dealer_code                                                = '80029'
   AND t1.effective_date                                          <= TO_DATE('20120824', 'YYYYMMDD')
   AND NVL(t1.expiration_date, TO_DATE('20120824', 'YYYYMMDD')+1) >= TO_DATE('20120824', 'YYYYMMDD')
   AND t2.ngp        = 'P'
   AND t2.ctn_status = 'AA'
   AND t1.nl_id LIKE 'NEO'
   AND t2.nl          = t1.nl_id
   AND LENGTH(t2.ctn) = 11
   AND rownum        <= 1500
;

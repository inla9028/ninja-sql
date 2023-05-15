--== List the 10 last failed updates
SELECT * FROM (
    SELECT * FROM (
        SELECT rs.*
          FROM dsp_response rs
         WHERE rs.request_id > (SELECT MAX(res.request_id) - 1000
                                  FROM dsp_response res)
           AND rs.process_status = 'PRSD_ERROR'
    )
    ORDER BY 1 DESC
)
 WHERE ROWNUM < 11
ORDER BY 1 ASC
;

SELECT rs.process_status, rs.adr_gender, count(1) AS "COUNT"
  FROM dsp_response rs
 WHERE rs.status_desc != 'IPL_NATIONALREGISTRY_PERSON_NOT_FOUND'
GROUP BY rs.process_status, rs.adr_gender
ORDER BY rs.process_status, rs.adr_gender;

UPDATE dsp_response rs
  SET rs.process_status = 'WAITING', rs.process_time = NULL, rs.status_desc = NULL
  WHERE rs.process_status = 'PRSD_ERROR'
    AND (rs.status_desc    LIKE '%No Jolt connections available%'
      OR rs.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR rs.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR rs.status_desc    LIKE '%Please try accessing account again later%'
      OR rs.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR rs.status_desc    LIKE '%not connected to ORACLE%'
      OR rs.status_desc    LIKE '%Tuxedo server%service is down%'
      OR rs.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
      OR rs.status_desc    LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
      OR rs.status_desc    LIKE '%java.util.ConcurrentModificationException%'
    )
;

SELECT rs.*
  FROM dsp_response rs
 WHERE rs.process_status = 'PRSD_ERROR'
    AND (rs.status_desc    LIKE '%No Jolt connections available%'
      OR rs.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR rs.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR rs.status_desc    LIKE '%Please try accessing account again later%'
      OR rs.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR rs.status_desc    LIKE '%not connected to ORACLE%'
      OR rs.status_desc    LIKE '%Tuxedo server%service is down%'
      OR rs.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
      OR rs.status_desc    LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
      OR rs.status_desc    LIKE '%java.util.ConcurrentModificationException%'
    )
;

--
SELECT COUNT(1) AS "COUNT"
  FROM dsp_response rs
 WHERE rs.process_status       = 'PRSD_ERROR'
   AND rs.status_desc       LIKE '%IllegalCityException: City % doesn''t match zip code%'
   AND NVL(rs.adr_zip, 'N/A') != 'N/A'
 ;
 
UPDATE dsp_response rs
   SET rs.process_status       = 'WAITING'
     , rs.status_desc          = NULL
     , rs.process_time         = NULL
 , rs.record_creation_date = TO_DATE('2015-12-01 06:06:06', 'YYYY-MM-DD HH24:MI:SS')
 WHERE rs.process_status = 'PRSD_ERROR'
   AND (
       rs.status_desc LIKE '%IllegalCityException%'
    OR rs.status_desc LIKE '%NinjaDTOInvalidGenderException%'
    OR rs.status_desc LIKE '%IllegalIdTypeException%'
    OR rs.status_desc LIKE '%IllegalNationalityException%'
    OR rs.status_desc LIKE '%IllegalZipException%'
   )
;



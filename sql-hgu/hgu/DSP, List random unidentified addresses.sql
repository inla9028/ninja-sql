SELECT count(1) AS "COUNT"
  FROM dsf_info@nrep11
;

SELECT *
  FROM (
    SELECT *
      FROM (
        SELECT a.*
          FROM dsf_info@nrep11 a
         WHERE ROWNUM < 10000
    )
    ORDER BY dbms_random.value
)
WHERE ROWNUM < 11
;


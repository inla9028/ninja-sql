SELECT ai.index_name, ai.index_type, ai.uniqueness, aic.column_name
  FROM all_indexes ai
INNER JOIN all_ind_columns aic
        ON ai.owner      = aic.index_owner
       AND ai.index_name = aic.index_name
 WHERE ai.owner      = upper('data_no')
   AND ai.table_name = upper('subscriber')
ORDER BY ai.index_name, aic.column_position;


SELECT A.*
  FROM hgu_dsf_wash A, billing_account ba
 WHERE A.ban           = ba.ban
   and ba.account_type = 'P'
   and ROWNUM < 201
;

DELETE
  FROM hgu_dsf_wash A
 WHERE A.navn    = '.'
   AND A.fornavn = 'BRUKER'
   AND a.adresse = 'SANDAKERVEIEN'
;

SELECT A.*
  FROM hgu_dsf_wash A
 WHERE A.adresse = 'SANDAKERVEIEN'
   and a.husnr   = '140'
   AND ROWNUM < 201
;

SELECT b.birth_date, count(1) AS "COUNT"
  FROM (SELECT decode(A.fodselsdato, NULL, 'Without', 'With') AS "BIRTH_DATE"
          FROM hgu_dsf_wash A
         WHERE A.adresse = 'SANDAKERVEIEN'
           AND A.husnr   = '140'
--           AND ROWNUM < 201
           ) b
GROUP BY b.birth_date
ORDER BY b.birth_date
;

SELECT A.*
  FROM hgu_dsf_wash A
 WHERE 1 = 1
--   and A.adresse = 'SANDAKERVEIEN'
--   and a.husnr   = '140'
   and A.egen_id IN ( 35693435, 35566297, 35948906, 36058879, 35605555, 36210539, 36227816 )
--   and egen_id = 25432246
   AND ROWNUM < 201
;

UPDATE hgu_dsf_wash A
   SET A.adresse = 'FØLLINGSTADS VEG'
 WHERE A.egen_id = 35605555
;

SELECT ba.account_type, ba.account_sub_type, A.*
  FROM hgu_dsf_wash A, billing_account ba
 WHERE A.ban = ba.customer_id
   AND ba.account_type = 'O'
ORDER BY 1,2,A.ban, A.link_type
;



SELECT A.oppdragsid, count(1) AS "COUNT"
  FROM hgu_dsf_wash A
GROUP BY A.oppdragsid
ORDER BY A.oppdragsid
;

SELECT A.*
  FROM hgu_dsf_wash A
 WHERE 1 = 1
--   AND A.adresse  = 'SANDAKERVEIEN'
   AND (A.navn    IN ( '.', ',', ';', 'TEST', 'TEST 5G', 'TELIA NORGE AS AVD 0163', 'TELIA AS AVD 3040', 'TELIA AS AVD 440', 'TELIA NORGE AS AVD 5000' )
     OR A.fornavn IN ( '.', ',', ';', 'BRUKER', 'NETCOM', 'TEST', 'TEST ABO', 'TESTABO', 'TELIA', 'Telia' )
     OR (A.navn    IN ( 'MBB',    'SHOPS',   'MIN BEDRIFT PROSJEKT', 'LAB' )
     AND A.fornavn IN ( 'BUTIKK', 'NETGEAR', 'TESBRUKERER',          '5G' ) ) )
;

/*
** List all individual/private NetCom/Telia customers.
*/
SELECT "PERSON_ID", COUNT(1) AS "COUNT"
  FROM (
    SELECT DECODE(nd.comp_reg_id, NULL, 'NO_DSF_ID', 'DSF_ID') AS "PERSON_ID"
      FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
     WHERE ba.ban_status       = 'O'
       AND ba.account_type     = 'I'
       AND ba.ban              = anl.ban
       AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
       AND anl.link_type       = 'L'
       AND anl.name_id         = nd.name_id
       AND anl.address_id      = ad.address_id
)
GROUP BY "PERSON_ID"
ORDER BY "PERSON_ID"
;
/*******************************************************************************
+-----------+--------+
|  2016-02-02 10:53  |
+-----------+--------+
| PERSON_ID | COUNT  |
+-----------+--------+
| DSF_ID    | 646131 |
| NO_DSF_ID |  47836 |
+-----------+--------+

+-----------+--------+
|  2016-04-13 09:13  |
+-----------+--------+
| PERSON_ID | COUNT  |
+-----------+--------+
| DSF_ID    | 648860 |
| NO_DSF_ID |  46122 |
+-----------+--------+
*******************************************************************************/

/*
** List all individual/private Chess customers.
*/
SELECT "PERSON_ID", COUNT(1) AS "COUNT"
  FROM (
    SELECT DECODE(nd.comp_reg_id, NULL, 'NO_DSF_ID', 'DSF_ID') AS "PERSON_ID"
      FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
     WHERE ba.ban_status       = 'O'
       AND ba.account_type     = 'H'
       AND ba.account_sub_type = 'PC'
       AND ba.ban              = anl.ban
       AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
       AND anl.link_type       = 'L'
       AND anl.name_id         = nd.name_id
       AND anl.address_id      = ad.address_id
)
GROUP BY "PERSON_ID"
ORDER BY "PERSON_ID"
;
/*******************************************************************************
+-----------+--------+
|  2016-04-13 09:13  |
+-----------+--------+
| PERSON_ID | COUNT  |
+-----------+--------+
| DSF_ID    |     58 |
| NO_DSF_ID | 230030 |
+-----------+--------+
*******************************************************************************/

/*
** Find a registered Chess customer (for testing)...
** List the columns in the NINJADATA.DSP_REQUEST table.
*/
SELECT NULL AS "REQUEST_ID", ba.ban AS "CUSTOMER_ID", nd.first_name AS "ADR_FIRST_NAME"
     , nd.last_business_name AS "ADR_LAST_NAME", TO_CHAR(anl.birth_date,  'YYYYMMDD') AS "ADR_BIRTH_DATE"
     , ad.adr_zip, SYSDATE AS "RECORD_CREATION_DATE", 'WAITING' AS "PROCESS_STATUS"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_USER_ID", NULL AS "PROCESS_TIME", NULL AS "STATUS_DESC"
  FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
 WHERE ba.ban_status       = 'O'
   AND ba.account_type     = 'H'
   AND ba.account_sub_type = 'PC'
   AND ba.ban              = anl.ban
   AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
   AND nd.comp_reg_id     IS NULL
   AND ROWNUM              < 11
;



--
-- Display the source of the view
--
SELECT /*+ driving_site(a)*/ A.text
  FROM dba_views@wh12p A
 WHERE A.owner     = 'CDATA'
   AND A.view_name = 'GET_TPID_NULL'
;

/*
SQL> describe get_tpid_null
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SYS_CREATION_DATE                                  DATE
 SYS_UPDATE_DATE                                    DATE
 LINK_TYPE                                          CHAR(1)
 TPID                                               VARCHAR2(36)
 COMP_REG_ID                                        VARCHAR2(50)
 BAN                                                NUMBER(9)
 SUBSCRIBER_NO                                      VARCHAR2(20)
 ACCOUNT_TYPE                                       CHAR(1)
*/

--
-- The result, from Tore Eide
--
select nd.sys_creation_date,nd.sys_update_date,adl.link_type,nd.tpid,nd.comp_reg_id,ba.ban,su.subscriber_no,ba.account_type from cdata.billing_account ba
join cdata.subscriber su on ba.ban=su.customer_id and su.sub_status in ('S','A') --and su.subscriber_no='GSM04792202033'
join cdata.address_name_link adl on ba.ban=adl.customer_id and su.subscriber_no=adl.subscriber_no and expiration_date is null
join cdata.name_data nd on adl.name_id=nd.name_id and nd.tpid is null
where ba.account_type not in ('S') /*and ba.ban=325302115 and rownum < 10 */ and adl.link_type in ('U')
union all
select nd.sys_creation_date,nd.sys_update_date,adl.link_type,nd.tpid,nd.comp_reg_id,ba.ban,'0000000000',ba.account_type from cdata.billing_account ba
--join cdata.subscriber su on ba.ban=su.customer_id and su.sub_status in ('S','A') --and su.subscriber_no='GSM04792202033'
join cdata.address_name_link adl on ba.ban=adl.customer_id and '0000000000'=adl.subscriber_no and expiration_date is null
join cdata.name_data nd on adl.name_id=nd.name_id and nd.tpid is null
where ba.account_type not in ('S') /*and ba.ban=325302115 and rownum < 10 */ and adl.link_type in ('B','L')
and exists (select ' ' from cdata.subscriber s where ba.ban=s.customer_id and s.sub_status in ('A','S')) --and   rownum < 10

--
-- The result (run via SQL Developer's format)
--
SELECT
  nd.sys_creation_date,
  nd.sys_update_date,
  adl.link_type,
  nd.tpid,
  nd.comp_reg_id,
  ba.ban,
  su.subscriber_no,
  ba.account_type
FROM
  cdata.billing_account ba
JOIN cdata.subscriber su
ON
  ba.ban           =su.customer_id
AND su.sub_status IN ('S','A') --and su.subscriber_no='GSM04792202033'
JOIN cdata.address_name_link adl
ON
  ba.ban             =adl.customer_id
AND su.subscriber_no =adl.subscriber_no
AND expiration_date IS NULL
JOIN cdata.name_data nd
ON
  adl.name_id=nd.name_id
AND nd.tpid IS NULL
WHERE
  ba.account_type NOT IN ('S')
  /*and ba.ban=325302115 and rownum < 10 */
AND adl.link_type IN ('U')
UNION ALL
SELECT
  nd.sys_creation_date,
  nd.sys_update_date,
  adl.link_type,
  nd.tpid,
  nd.comp_reg_id,
  ba.ban,
  '0000000000',
  ba.account_type
FROM
  cdata.billing_account ba
  --join cdata.subscriber su on ba.ban=su.customer_id and su.sub_status in ('S'
  -- ,'A') --and su.subscriber_no='GSM04792202033'
JOIN cdata.address_name_link adl
ON
  ba.ban             =adl.customer_id
AND '0000000000'     =adl.subscriber_no
AND expiration_date IS NULL
JOIN cdata.name_data nd
ON
  adl.name_id=nd.name_id --and nd.tpid is null
WHERE
  ba.account_type NOT IN ('S')
  /*and ba.ban=325302115 and rownum < 10 */
AND adl.link_type IN ('B','L')
AND EXISTS
  (
    SELECT
      ' '
    FROM
      cdata.subscriber s
    WHERE
      ba.ban          =s.customer_id
    AND s.sub_status IN ('A','S')
  ) --and   rownum < 10
  ;

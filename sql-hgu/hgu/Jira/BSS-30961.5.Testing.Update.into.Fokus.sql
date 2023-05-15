SELECT COUNT(1) as "ROW_COUNT"
  FROM dsp_response
 WHERE process_status       = 'WAITING'
   --AND record_creation_date > SYSDATE
;

select a.*
  from dsp_response a
order by a.request_id
;

select a.*
  from dsp_response a
 WHERE process_status       = 'WAITING'
;

update dsp_response a
   set a.process_status = 'ON_HOLD'
 where process_status   = 'WAITING'
;

update dsp_response a
   set a.process_status = 'WAITING'
 where process_status   = 'ON_HOLD'
;

update dsp_response a
   set a.process_status = 'WAITING', a.status_desc = NULL
 where process_status   = 'PRSD_ERROR'
;

update dsp_response a
   set a.process_status = 'PRSD_ERROR'
 where process_status   = 'WAITING'
   and a.status_desc is not NULL
;

insert into dsp_response (
  REQUEST_ID,ADR_LAST_NAME,ADR_FIRST_NAME,ADR_BIRTH_DATE,ADR_CITY,ADR_ZIP,ADR_HOUSE_NO,ADR_STREET_NAME,ADR_POB,ADR_COUNTRY,ADR_HOUSE_LETTER,ADR_STOREY,ADR_DOOR_NO,ADR_DISTRICT,ADR_GENDER,ADR_STAT,DSP_ID,RECORD_CREATION_DATE,PROCESS_STATUS,PROCESS_TIME,STATUS_DESC
)
values (
  4, 'PETTER','TESTMANN','20040506','OSLO','0403','140','SANDAKERVEIEN',NULL,'NO',NULL,NULL,NULL,NULL,'M',NULL,'MY_DSP_ID',NULL,NULL,NULL
  --,NULL
  , 'Testing to see if email works'
)
;

insert into dsp_response (
  REQUEST_ID,ADR_LAST_NAME,ADR_FIRST_NAME,ADR_BIRTH_DATE,ADR_CITY,ADR_ZIP,ADR_HOUSE_NO,ADR_STREET_NAME,ADR_POB,ADR_COUNTRY,ADR_HOUSE_LETTER,ADR_STOREY,ADR_DOOR_NO,ADR_DISTRICT,ADR_GENDER,ADR_STAT,DSP_ID,RECORD_CREATION_DATE,PROCESS_STATUS,PROCESS_TIME,STATUS_DESC
)
select REQ.REQUEST_ID, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,'DSP_NO_' || REQ.REQUEST_ID, NULL, NULL, NULL, NULL
  from dsp_request req
 where req.process_status = 'WAITING'
;


update dsp_response
  set adr_country = 'NOR'
where adr_country = 'NO';

SELECT ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
     , nd.comp_reg_id
  FROM billing_account@fokus ba, address_name_link@fokus anl, name_data@fokus nd, address_data@fokus ad
 WHERE ba.ban             IN (select rq.customer_id
                                from dsp_request rq, dsp_response rs
                               where rq.request_id     = rs.request_id
                                 and rs.process_status = 'PRSD_SUCCESS')
   AND ba.ban              = anl.ban
   AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
;

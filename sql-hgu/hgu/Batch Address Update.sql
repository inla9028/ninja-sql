
select a.*
  from batch_address_update a
 where a.requestor_id = 'HGU 2020-08-21'
--   and a.process_status = 'PRSD_ERROR'
order by a.enter_time
;

select a.ban, a.subscriber_no, a.process_status, a.status_desc
  from batch_address_update a
 where a.requestor_id   = 'HGU 2020-08-21'
   and a.process_status = 'PRSD_ERROR'
order by 1, 2
;

select a.requestor_id, a.process_status, COUNT(1) AS "COUNT"
  from batch_address_update a
 where a.requestor_id = 'HGU 2020-08-21'
group by a.requestor_id, a.process_status
order by 1, 2
;

update batch_address_update a
   set a.process_status = 'WAITING'
 where a.requestor_id = 'HGU 2020-08-21'
   and a.process_status = 'ON_HOLD'
;

update batch_address_update a
   set a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
     , a.subscriber_no  = NULL
 where a.requestor_id   = 'HGU 2020-08-21'
   and a.process_status = 'PRSD_ERROR'
   and a.subscriber_no  = '0000000000'
;


select a.*
  from batch_address_update a
 where a.subscriber_no = 'GSM04798465532'
;

/*
"no.netcom.ninja.core.nameaddress.exception.IllegalCityException: City [FEVIK] doesn't match zip code [   4870]. [ID=ptl5m59ud3o12i4fgaeqea4jdvqcpbg] [ID=ptl5m59ud3o12i4fgaeqea4jdvqcpbg]
	at no.netcom.ninja.core.nameaddress.Address.setCity(Address.java:1342)
	at no.netcom.ninja.core.nameaddress.Address.updateFromDTO(Address.java:2042)
	at no.netcom.demon.batchjobs.BatchAddressUpdate.doProcessSubscription(BatchAddressUpdate.java:302)
	at no.netcom.demon.batchjobs.BatchAddressUpdate.doProcessRequest(BatchAddressUpdate.java:265)
	at no.netcom.demon.batchjobs.BatchAddressUpdate.doProcessTransaction(BatchAddressUpdate.java:270)
	at no.netcom.demon.batchjobs.BatchAddressUpdate.processTransaction(BatchAddressUpdate.java:90)
	at no.netcom.demon.batchjobs.AncestorBatchJobManagerDB.processRequestsImpl(AncestorBatchJobManagerDB.java:498)
	at no.netcom.demon.batchjobs.AncestorBatchJobManagerDB.processRequests(AncestorBatchJobManagerDB.java:373)
	at no.netcom.demon.batchjobs.BatchJobFacade.batchAddressUpdate(BatchJobFacade.java:2178)
	at no.netcom.ninjatest.TestNinjaBatchJobs.testBatchAddressUpdate(TestNinjaBatchJobs.java:1126)
	at no.netcom.ninjatest.TestNinjaBatchJobs.test(TestNinjaBatchJobs.java:72)
	at no.netcom.ninjatest.TestNinjaBatchJobs.main(TestNinjaBatchJobs.java:130)
"
*/

select a.*, ad.adr_type
  from tmp_addresses_invalid@nrep11 a, address_data@nrep11 ad
 where a.adr_city LIKE '%STAVANGER%'
   and a.address_id            = ad.address_id 
;

select a.adr_zip, a.adr_city, COUNT(1) AS "COUNT"
  from tmp_addresses_invalid@nrep11 a
 where a.adr_city LIKE '%STAVANGER%'
group by a.adr_zip, a.adr_city
order by a.adr_zip, a.adr_city
;

INSERT INTO batch_address_update (ban, subscriber_no, link_type, address_type, city, zip_code, requestor_id, process_status)
SELECT a.ban
     , DECODE(a.subscriber_no, '0000000000', NULL, a.subscriber_no) AS "SUBSCRIBER_NO"
     , a.link_type
     , ad.adr_type                                                  AS "ADDRESS_TYPE"
     , zd.city                                                      AS "CITY"
     , zd.zip_code                                                  AS "ZIP_CODE"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')                     AS "REQUESTOR_ID"
     , 'ON_HOLD'                                                    AS "PROCESS_STATUS"
  FROM tmp_addresses_invalid@nrep11 a, address_data@nrep11 ad, zip_decode@nrep11 zd
 WHERE TRIM(a.adr_zip) = zd.zip_code(+)
   AND zd.zip_code     IS NOT NULL
   AND a.address_id    = ad.address_id 
;

INSERT INTO batch_address_update (ban, subscriber_no, link_type, address_type, city, zip_code, requestor_id, process_status)
SELECT a.ban
     , DECODE(a.subscriber_no, '0000000000', NULL, a.subscriber_no) AS "SUBSCRIBER_NO"
     , a.link_type
     , ad.adr_type                                                  AS "ADDRESS_TYPE"
     , zr.new_city                                                  AS "CITY"
     , zr.new_zip                                                   AS "ZIP_CODE"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')                     AS "REQUESTOR_ID"
     , 'ON_HOLD'                                                    AS "PROCESS_STATUS"
  FROM tmp_addresses_invalid@nrep11 a, address_data@nrep11 ad, zip_replace@nrep11 zr, zip_decode@nrep11 zd
 WHERE TRIM(a.adr_zip) = zr.old_zip
   AND zr.new_zip      = zd.zip_code
   AND a.address_id    = ad.address_id 
;


INSERT INTO batch_address_update (ban, subscriber_no, link_type, address_type, city, zip_code, requestor_id, process_status)
SELECT a.ban
     , a.subscriber_no
     , a.link_type
     , ad.adr_type      AS "ADDRESS_TYPE"
     , TRIM(a.adr_city) AS "CITY"
     , DECODE(TRIM(a.adr_zip)
            , '4064', '4068'
            , '4065', '4068'
            , '4066', '4068'
            , '4067', '4068'
            , '4069', '4068'
            , TRIM(a.adr_zip)) AS "ZIP_CODE"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUESTOR_ID"
     , 'ON_HOLD' AS "PROCESS_STATUS"
  FROM tmp_addresses_invalid@nrep11 a, address_data@nrep11 ad
 where a.adr_city LIKE '%STAVANGER%'
   and a.address_id  = ad.address_id 
;
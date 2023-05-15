select a.*
  from all_tables a
 where a.table_name in ('PREPAY_DSP_REQUEST', 'PREPAY_DSP_RESPONSE')
;

select req.*
  from kontantmv.prepay_dsp_request req
 where rownum < 11
;

select req.*
  from kontantmv.prepay_dsp_request req
 where req.request_id > (select max(request_id) - 10 from  kontantmv.prepay_dsp_request)
;


select res.*
  from kontantmv.prepay_dsp_response res
 where rownum < 11
;

/*
105564																2	2005-02-02 15:14	2005-02-02 15:14	Search returned no hits.	
105565																2	2005-02-02 15:14	2005-02-02 15:14	Search returned no hits.	
103441																2	2005-01-12 11:00	2005-01-12 11:00	Search returned no hits.	
103442																2	2005-01-12 11:00	2005-01-12 11:00	Search returned no hits.	
103443																2	2005-01-12 11:00	2005-01-12 11:00	Search returned no hits.	
103444																2	2005-01-12 11:17	2005-01-12 11:17	Search returned no hits.	
103459																2	2005-01-12 15:37	2005-01-12 15:37	Search returned no hits.	
103466																2	2005-01-13 08:38	2005-01-13 08:38	Search returned no hits.	
103498	KRISTIANSEN	MARITA	19780405	LIER	3400	4	TORSKROKEN 		NOR	B				K	1	1	2005-01-14 11:39	2005-01-14 11:39		
103529	PIRO	KARI ANNE	19440930	HOSLE	1362	22	PROST CHRISTIES VEI 		NOR	C				K	1	1	2005-01-17 08:50	2005-01-17 08:50		
*/
select res.*
  from kontantmv.prepay_dsp_response res
 where res.request_id > (select max(request_id) - 10 from  kontantmv.prepay_dsp_response)
;

select res.adr_stat, count(1) as "COUNT"
  from kontantmv.prepay_dsp_response res
 where res.request_id > (select max(request_id) - 1000 from  kontantmv.prepay_dsp_response)
group by res.adr_stat
order by res.adr_stat
;
/*
ADR_STAT	COUNT
       0	649
       5	21
  (NULL)	268
*/

select res.status, count(1) as "COUNT"
  from kontantmv.prepay_dsp_response res
 where res.request_id > (select max(request_id) - 10000 from  kontantmv.prepay_dsp_response)
group by res.status
order by res.status
;
/*
STATUS	COUNT
     1	6048
     2	2161
     3	214
     4	18
     9	9
*/

select res.adr_district, count(1) as "COUNT"
  from kontantmv.prepay_dsp_response res
 where res.request_id > (select max(request_id) - 10000 from  kontantmv.prepay_dsp_response)
group by res.adr_district
order by res.adr_district
;
/*
DISTRICT	COUNT
  (NULL)	8432 
*/

select res.adr_gender, count(1) as "COUNT"
  from kontantmv.prepay_dsp_response res
 where res.request_id > (select max(request_id) - 10000 from  kontantmv.prepay_dsp_response)
group by res.adr_gender
order by res.adr_gender
;
/*
ADR_GENDER	COUNT
         F	2208
         M	4154
    (NULL)	2222
*/
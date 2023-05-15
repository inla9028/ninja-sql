select a.*
  from tmp_msisdns_w_status_pp_soc_fp a
 where a.FEATURE_CODE is null
;

select b.price_plan, count(1) as "COUNT"
from (
select a.price_plan, a.subscriber_no
  from tmp_msisdns_w_status_pp_soc_fp a
 group by a.price_plan, a.subscriber_no
) b
group by b.price_plan
order by 1
;


select a.*
  from tmp_msisdns_w_status_pp_soc_fp a
 where a.subscriber_no = 'GSM047580004291205'
;



select a.soc, a.feature_code
     , substr(a.ftr_add_sw_prm, instr(a.ftr_add_sw_prm, 'NAME='), (instr(a.ftr_add_sw_prm, '@', instr(a.ftr_add_sw_prm, 'NAME=')) - instr(a.ftr_add_sw_prm, 'NAME='))) AS "APN_NAME"
     , substr(a.ftr_add_sw_prm, instr(a.ftr_add_sw_prm, 'BANDWIDTHDOWN='), (instr(a.ftr_add_sw_prm, '@', instr(a.ftr_add_sw_prm, 'BANDWIDTHDOWN=')) - instr(a.ftr_add_sw_prm, 'BANDWIDTHDOWN='))) AS "BANDWIDTHDOWN"
     , substr(a.ftr_add_sw_prm, instr(a.ftr_add_sw_prm, 'BANDWIDTHUP='), (instr(a.ftr_add_sw_prm, '@', instr(a.ftr_add_sw_prm, 'BANDWIDTHUP=')) - instr(a.ftr_add_sw_prm, 'BANDWIDTHUP='))) AS "BANDWIDTHUP"
  from tmp_msisdns_w_status_pp_soc_fp a
 where a.subscriber_no = 'GSM047580004291205'
   and a.soc like 'SPAPN%'
;

select b.soc, b.feature_code, b.apn_name, b.bandwidthdown, b.bandwidthup, count(1) AS "COUNT"
  from (
select a.soc, a.feature_code
     , substr(a.ftr_add_sw_prm, instr(a.ftr_add_sw_prm, 'NAME='), (instr(a.ftr_add_sw_prm, '@', instr(a.ftr_add_sw_prm, 'NAME=')) - instr(a.ftr_add_sw_prm, 'NAME='))) AS "APN_NAME"
     , substr(a.ftr_add_sw_prm, instr(a.ftr_add_sw_prm, 'BANDWIDTHDOWN='), (instr(a.ftr_add_sw_prm, '@', instr(a.ftr_add_sw_prm, 'BANDWIDTHDOWN=')) - instr(a.ftr_add_sw_prm, 'BANDWIDTHDOWN='))) AS "BANDWIDTHDOWN"
     , substr(a.ftr_add_sw_prm, instr(a.ftr_add_sw_prm, 'BANDWIDTHUP='), (instr(a.ftr_add_sw_prm, '@', instr(a.ftr_add_sw_prm, 'BANDWIDTHUP=')) - instr(a.ftr_add_sw_prm, 'BANDWIDTHUP='))) AS "BANDWIDTHUP"
  from tmp_msisdns_w_status_pp_soc_fp a
 where a.soc like 'SPAPN%') b
group by b.soc, b.feature_code, b.apn_name, b.bandwidthdown, b.bandwidthup
order by 1,2,3,4  
;

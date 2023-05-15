-- Create temp table for priceplans

create table tmp_hgu_pp_combo nologging as
(
select  /*+ parallel(sa3 , 6 )*/
        /*+ parallel(s , 6 )*/
        sa3.ban, sa3.subscriber_no, rtrim(sa3.soc) soc, sa3.effective_date, sa3.SERVICE_TYPE, sa3.expiration_date, s.ORIGINAL_INIT_DATE
from    
        mdcust_ny.service_agreement@wh10p sa3
        ,mdcust_ny.subscriber@wh10p s
where   1=1
and     s.SUB_STATUS = 'A'
and     s.CUSTOMER_ID = sa3.BAN
and     s.SUBSCRIBER_NO = sa3.SUBSCRIBER_NO
and     sa3.expiration_date > sysdate + 1000
and     rtrim(sa3.soc) IN ('PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE')
);
commit;
create index tmp_hgu_pp_combo_index on tmp_hgu_pp_combo(ban, subscriber_no);
commit;



-- create temp tables for SOC

create table tmp_hgu_soc_combo as
(
select  /*+ parallel(sa3 , 6 )*/
        /*+ parallel(s , 6 )*/
        sa3.ban, sa3.subscriber_no, rtrim(sa3.soc) soc, sa3.effective_date, sa3.SERVICE_TYPE, sa3.expiration_date, s.ORIGINAL_INIT_DATE
from    service_agreement@wh10p sa3, mdcust_ny.subscriber@wh10p s
where   1=1
and     s.SUB_STATUS = 'A'
and     sa3.expiration_date > sysdate + 1000
and     rtrim(sa3.soc) IN ('MCTB5', 'MCTBFREE')
and     s.SUBSCRIBER_NO = sa3.SUBSCRIBER_NO
and     s.CUSTOMER_ID = sa3.BAN
and     (sa3.ban, sa3.subscriber_no) in
                                    (
                                    select  ban, subscriber_no
                                    from    tmp_hgu_pp_combo
                                    )
);
commit;
create index tmp_hgu_soc_combo_index on tmp_hgu_soc_combo (ban, subscriber_no);
commit;

-- Combining the two tables.

drop table tmp_hgu_pp_soc_combo;
commit;

create table tmp_hgu_pp_soc_combo as
(
--SOC-combinasion
-- By Grouping
-- See below for single subscribers
select  /*+ parallel(sa1 , 6 )*/ 
        /*+ parallel(sa2, 6 )*/  
sa2.ban, sa2.subscriber_no
,sa2.soc prisplan
,s2.soc_description beskrivelse_pp, /*  sa2.campaign,   */
rtrim(sa1.soc) soc , s1.soc_description beskrivelse_soc
from    tmp_hgu_soc_combo sa1
        ,tmp_hgu_pp_combo sa2
        ,refwh02.soc@wh10p s1
        ,refwh02.soc@wh10p s2
where 1=1
and rtrim(sa1.soc) = rtrim(s1.soc)
and rtrim(sa2.soc) = rtrim(s2.soc)
and s1.expiration_date is null
and s2.expiration_date is null
and sa1.expiration_date >  sysdate + 1000 
and sa2.expiration_date >  sysdate + 1000
and sa2.ban = sa1.ban
and sa2.subscriber_no = sa1.subscriber_no

);
commit;

-- select  count(*) from tmp_hgu_soc_combo

-- Deleting large temporary work tables

drop table tmp_hgu_pp_combo;
commit;

drop table tmp_hgu_soc_combo;
commit;

/*
** HGU - Create temporary table with the raw features parameters
*/
create table tmp_hgu_ftr_raw nologging as
(
select  /*+ parallel(sf1 , 6 )*/
        /*+ parallel(t1 , 6 )*/
        t1.ban, t1.subscriber_no, t1.soc, sf1.feature_code, sf1.ftr_add_sw_prm
from    
        mdcust_ny.service_feature@wh10p sf1
        ,tmp_hgu_pp_soc_combo t1
where   1=1
  AND   t1.ban = sf1.ban
  AND   t1.subscriber_no = sf1.subscriber_no
  AND   t1.soc = rtrim(sf1.soc)
  AND   SYSDATE BETWEEN sf1.ftr_effective_date AND sf1.ftr_expiration_date
  AND   sf1.feature_code IN ('CUG', 'M-VPT2')
);
commit;

create index tmp_hgu_ftr_raw_index on tmp_hgu_ftr_raw (ban, subscriber_no, feature_code);

/*
** Create the table to host the plain feature parameters.
*/

drop table tmp_hgu_ftr_current;
commit;

create table tmp_hgu_ftr_current nologging as
(
SELECT a1.ban, a1.subscriber_no, rtrim(a1.soc) soc
       , a1.feature_code AS "FTR1"
       , SUBSTR(a1.ftr_add_sw_prm, INSTR(a1.ftr_add_sw_prm, 'CUG='),     3) AS "PARAM1"
       , SUBSTR(a1.ftr_add_sw_prm, INSTR(a1.ftr_add_sw_prm, 'CUG=') + 4, 5) AS "VALUE1"
       , a2.feature_code AS "FTR2"
       , SUBSTR(a2.ftr_add_sw_prm, INSTR(a2.ftr_add_sw_prm, 'VPN='),     3) AS "PARAM2"
       , SUBSTR(a2.ftr_add_sw_prm, INSTR(a2.ftr_add_sw_prm, 'VPN=') + 4, 5) AS "VALUE2"
  FROM tmp_hgu_ftr_raw a1, tmp_hgu_ftr_raw a2
 WHERE 1 = 1
--   AND a1.subscriber_no = 'GSM04796901448'
   AND a1.feature_code  = 'CUG'
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND a2.feature_code  = 'M-VPT2'
);
commit;

create index tmp_hgu_ftr_current_index on tmp_hgu_ftr_current (ban, subscriber_no, ftr1, ftr2);

/*
** Drop the tmp worker table
*/
drop table tmp_hgu_ftr_raw;
commit;


select * from tmp_hgu_pp_soc_combo sc
where     1=1
and     rownum < 26
order by prisplan, soc;


select  slg33.prisplan, slg33.beskrivelse_pp, slg33.soc, slg33.beskrivelse_soc,  count(*) 
from    tmp_hgu_pp_soc_combo slg33
where   1=1
group by    slg33.prisplan, slg33.beskrivelse_pp, slg33.soc, slg33.beskrivelse_soc
order by    slg33.prisplan, slg33.beskrivelse_pp, slg33.soc, slg33.beskrivelse_soc;


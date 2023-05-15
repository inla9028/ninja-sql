/*
Här räknar du antal subs, Aktiva och Suspended. Bra att ha som bakgrundsinfo. Mer kod kommer i nästa mail, för grupperingar.
Men ha alltid med dig totala antalet per prisplan när du ser om kombinationerna verkar rimliga.

Massa onödig och bortkommenterad kod, men du ser att jag använder det för alltmöjligt. Du kan också ha nytta av det?
I början en rad för att få fram antal registreringar efter ett visst datum. Nu satt till 1999, dvs alla.
Det finns rader för att bara få med vissa operatörs id etc etc.

Men, du kan bara pasta in denna i WH10P, bakom AVD2010 och köra. Kör du i egen miljö kan du få problem med några drop table etc,
men det är ju bara att köra på (skip), så funkar det nästa gång i alla fall.

*/
--------------------------------
-- SQL made by Staffan Lindberg
--------------------------------
drop table tmp_hgu_soc_count;
commit;

drop table tmp_hgu_soc_count_result;
commit;

create table tmp_hgu_soc_count as
(
select  /*+ parallel(sa , 6 )*/ 
        ban, subscriber_no, soc, service_type, operator_id, SYS_CREATION_DATE, effective_date, expiration_date
from    mdcust_ny.service_agreement@wh10p sa
where   1=1
--and     operator_id in ( 400586, 1,99, 9999, 999, 200900)
and     to_char(sa.SYS_CREATION_DATE , 'yyyy-mm-dd hh24-mi-ss') > '1999-05-20 00-00-00' --'2013-03-27 21-00-00'
--and     to_char(sa.SYS_CREATION_DATE , 'yyyy-mm-dd hh24-mi-ss') between '2011-03-09 00-00-00' and '2011-03-11 23-59-00' --'2013-03-27 21-00-00'
and     sa.EXPIRATION_DATE > sysdate + 100
--and     (sa.soc in ('MCTBFREE') or sa.soc like 'CLI%') 
and     sa.soc like 'PSS%'
--and     rownum < 6
);
commit;

--create index ind_soc_count on tmp_hgu_soc_count(ban,subscriber_no);
--commit;
create index ind_soc_count2 on tmp_hgu_soc_count(ban,subscriber_no, soc);
commit;
--create index ind_soc_count3 on tmp_hgu_soc_count(soc);
--commit;

select  * from tmp_hgu_soc_count where rownum < 5;

create table tmp_hgu_soc_count_result as
(
select  /*+ parallel(sa, 4 )*/ 
         /* sa.ban,   */
        sa.soc /* , substr(sa.subscriber_no,1,6),*/ 
        ,so.soc_description
        ,s.sub_status
        ,so.sale_exp_date
        ,sa.operator_id
        ,to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd') effective_date
--        ,min(to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd hh24-mi-ss')) min_effective_date
--        ,max(to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd hh24-mi-ss')) max_effective_date        
        ,min(to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd hh24-mi-ss')) min_effective_date
        ,max(to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd hh24-mi-ss')) max_effective_date
      --  ,( count(*) / ( max(to_number(sa.SYS_CREATION_DATE) / min(to_number(sa.SYS_CREATION_DATE))))) 
--        sa.soc,  sa.subscriber_no, substr(sa.subscriber_no,4,12) sub_short,  pd.imsi, sa.EFFECTIVE_DATE, sa.EXPIRATION_DATE,  so.soc_description, so.sale_exp_date--, count(*) Antall
        ,count(*) Antall
from    tmp_hgu_soc_count sa
        , mdcust_ny.subscriber@wh10p s
        --, mdcust_ny.physical_device pd,
        ,(
            select  s.soc, s.soc_description, s.sale_exp_date, s.product_type, s.service_type 
            from    refwh02.soc@wh10p s
            where   1=1
--            and     subscriber_no = 'GSM04792222014'
            --and     upper(soc_description) like '%500%'
            --and     (s.soc like 'PU%' or  s.soc like 'EPOS%' or  s.soc like 'NCEPOS%' or  s.soc like 'EPUS%' or  s.soc like 'BLACK%' or  s.soc like 'M2MVPN%' or  s.soc like 'MVR%' or  s.soc like 'TPAK%')                     
          and       s.soc in (select distinct soc from tmp_hgu_soc_count)
          --and     s.soc in   ('VMEPOST') 
--          and       (s.soc like 'PK%' or s.soc = 'MMS04')
--            and     s.product_type = 'GSM'
            --and     s.service_type = 'R'
            and     s.expiration_date is null
            and     (s.sale_exp_date is null or s.sale_exp_date > sysdate + 1000)
        ) so
where   1=1
--and     sa.operator_id = 400586
--and     to_char(sa.SYS_CREATION_DATE , 'yyyy-mm-dd hh24-mi-ss') > '2013-04-07 00-00-00' --'2013-03-27 21-00-00'
--and     pd.EQUIPMENT_LEVEL = 1
--and     pd.expiration_date is null
--and     pd.customer_id = sa.ban
--and     pd.subscriber_no = sa.subscriber_no
and     s.sub_status in ('A','S')
and     sa.expiration_date > sysdate + 100
--and     sa.expiration_date > sysdate - 30
--and     sa.EFFECTIVE_DATE > sysdate - 90 --between to_date ('20121016','yyyymmdd') and to_date ('20121017','yyyymmdd')
--and     sa.EFFECTIVE_DATE > sysdate - 5
and     sa.ban = s.customer_id  
and     sa.subscriber_no = s.subscriber_no  
and     sa.soc = so.soc
--and     substr(sa.subscriber_no,1,6) = 'GSM047'
--and     sa.subscriber_no not like '0000%'
--and     sa.subscriber_no <> 'GSM047580009900737'
--and     sa.ban = 820188803
group by    /*  sa.ban,   */sa.soc, /*  substr(sa.subscriber_no,1,6),*/  
        sa.operator_id, s.sub_status, so.soc_description, so.sale_exp_date
        , to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd')
);
commit;

--drop table tmp_hgu_soc_count;
--commit;
--select  * from tmp_hgu_soc_count where 1=1; --and soc = 'MPODVC1' and  rownum < 10;

--select  * from tmp_hgu_soc_count_result;


select  soc
        ,soc_description
        ,sub_status
        ,operator_id
        ,effective_date effective_date
        ,sum(antall) sum_antall
        ,min(min_effective_date)
        ,max(max_effective_date)
from
(
select  * 
from    tmp_hgu_soc_count_result --order by antall desc;
--where   (operator_id = 400586 or operator_id = 1 or operator_id = 999 or operator_id = 9999 or operator_id = 99)
--and     to_date(min_effective_date,'yyyy-mm-dd hh24-mi-ss') > sysdate - 3
)
group by    effective_date
            ,operator_id 
            ,soc
            ,soc_description
            ,sub_status
order by    effective_date desc
            ,sum_antall desc
            ,sub_status
            ,effective_date
            ,operator_id
            ,soc
            ,soc_description;



select  soc
        ,soc_description
        ,sub_status
--        ,operator_id
--        ,effective_date effective_date
        ,sum(antall) sum_antall
        ,min(min_effective_date)
        ,max(max_effective_date)
from
(
select  * 
from    tmp_hgu_soc_count_result --order by antall desc;
--where   (operator_id = 400586 or operator_id = 1 or operator_id = 999 or operator_id = 9999 or operator_id = 99)
--and     to_date(min_effective_date,'yyyy-mm-dd hh24-mi-ss') > sysdate - 3
)
group by    --effective_date
--            ,operator_id 
            soc
            ,soc_description
            ,sub_status
order by    --effective_date desc
            soc
            ,sum_antall desc
            ,sub_status
            --,effective_date
--            ,operator_id
            ,soc
            ,soc_description;

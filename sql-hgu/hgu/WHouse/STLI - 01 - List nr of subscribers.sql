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
and     to_char(sa.SYS_CREATION_DATE , 'yyyy-mm-dd hh24-mi-ss') > '1999-05-20 00-00-00' --'2013-03-27 21-00-00'
and     sa.EXPIRATION_DATE > sysdate + 100
and     sa.soc IN ('PSSA', 'PSSB', 'PSSC', 'PSSD', 'PSSE')
);
commit;

create index ind_soc_count2 on tmp_hgu_soc_count(ban,subscriber_no, soc);
commit;

select  * from tmp_hgu_soc_count where rownum < 5;

create table tmp_hgu_soc_count_result as
(
select  /*+ parallel(sa, 4 )*/ 
         /* sa.ban,   */
        sa.soc
        ,so.soc_description
        ,s.sub_status
        ,so.sale_exp_date
        ,sa.operator_id
        ,to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd') effective_date
        ,min(to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd hh24-mi-ss')) min_effective_date
        ,max(to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd hh24-mi-ss')) max_effective_date
        ,count(*) Antall
from    tmp_hgu_soc_count sa
        , mdcust_ny.subscriber@wh10p s
        ,(
            select  s.soc, s.soc_description, s.sale_exp_date, s.product_type, s.service_type 
            from    refwh02.soc@wh10p s
            where   1=1
          and       s.soc in (select distinct soc from tmp_hgu_soc_count)
            and     s.expiration_date is null
            and     (s.sale_exp_date is null or s.sale_exp_date > sysdate + 1000)
        ) so
where   1=1
and     s.sub_status in ('A','S')
and     sa.expiration_date > sysdate + 100
and     sa.ban = s.customer_id  
and     sa.subscriber_no = s.subscriber_no  
and     sa.soc = so.soc
group by 
        sa.soc,
        sa.operator_id, s.sub_status, so.soc_description, so.sale_exp_date
        , to_char(sa.SYS_CREATION_DATE ,'yyyy-mm-dd')
);
commit;


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
        ,sum(antall) sum_antall
        ,min(min_effective_date)
        ,max(max_effective_date)
from
(
select  * 
from    tmp_hgu_soc_count_result --order by antall desc;
)
group by
            soc
            ,soc_description
            ,sub_status
order by
            soc
            ,sum_antall desc
            ,sub_status
            ,soc
            ,soc_description;

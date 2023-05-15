/*
Igen, en massa on�dig kod och flera tabeller �n du beh�ver, men ger dig det du vill ha och lite till.

I detta tilf�lle tar jag bara ut aktiva kunder (SUBSCRIBER.SUB_STATUS = �A�), f�r det �r det som, normalt sett, Ninja kan k�ra. Hur du ska hantera Suspended, det vet jag inte.

Notera att du redan i dag har kunder med b�de MCTBFREE och MCTB5 p� alla dina prisplaner.

Igen, du kan k�ra i AVD2010, eller i egen milj�. Tror inte du f�r samma problem med drop table h�r iom att jag droppar alla temps p� slutet.

Du v�ljer vilka prisplaner du ska ha med p� rad 33.
Du v�ljer vilka SOC du ska ha med p� rad 62

Svaret, listan med dina kunder, f�r du i:
*/
select * from tmp_hgu_pp_soc_combo sc
where     1=1
--and     sc.SOC in ('ODB12')
--and     rownum < 26
order by prisplan, soc;.

/*
Obs, inte s�kert Fokus g�r med p� att du deletera en TB-SOC. Kan ha krav om att du m�ste ha en annan TB-SOC (Replace).
Observera att en delete f�ljt av en add tar bort kunden fr�n IN noden under n�gra f� sekunder och att kunden d� mister sin k� tillh�righet osv. En Replace f�r inte samma issue.

H�r g�rna av dig om du undrar �ver n�got. Detta �r en av f� saker jag faktiskt kan. Allt annat �r bara l�gner och p�hitt fr�n mig�.

/Staffan

*/
-- Create temp table for priceplans

create table tmp_hgu_pp_combo nologging as
(
select  /*+ parallel(sa3 , 6 )*/
        /*+ parallel(s , 6 )*/
        sa3.ban, sa3.subscriber_no, sa3.soc, sa3.effective_date, sa3.SERVICE_TYPE, sa3.expiration_date, s.ORIGINAL_INIT_DATE
from    
        mdcust_ny.service_agreement@wh10p sa3
        ,mdcust_ny.subscriber@wh10p s
where   1=1
--and     s.INIT_ACTIVATION_DATE > sysdate - 360
--and     s.ORIGINAL_INIT_DATE > sysdate - 360
and     s.SUB_STATUS = 'A'
--        ,mdcust_ny.subscriber s
--and     s.SUB_STATUS = 'A'
--and     s.SUBSCRIBER_NO = sa3.SUBSCRIBER_NO
--and     s.CUSTOMER_ID = sa3.BAN
--and     sa3.SERVICE_TYPE = 'P'
--and     sa3.effective_date > sysdate - 10
--and     sa3.soc = 'PKOO' --,'PKOV','PKOD','PKOU')
--and     sa3.soc = 'PKOO'
--and     (sa3.soc like 'PTM%' or sa3.soc like 'PSD%')
--and     rownum < 10
--and     sa3.SUBSCRIBER_NO in ('GSM04745249744')
and     s.CUSTOMER_ID = sa3.BAN
and     s.SUBSCRIBER_NO = sa3.SUBSCRIBER_NO
and     sa3.expiration_date > sysdate + 1000
--and     substr(sa3.soc,1,2) = 'PK'
and     sa3.soc like 'PSS%'
--and     rownum < 10
);
commit;
create index tmp_hgu_pp_combo_index on tmp_hgu_pp_combo(ban, subscriber_no);
commit;



-- create temp tables for SOC

create table tmp_hgu_soc_combo as
(
select  /*+ parallel(sa3 , 6 )*/
        /*+ parallel(s , 6 )*/
        sa3.ban, sa3.subscriber_no, soc, sa3.effective_date, sa3.SERVICE_TYPE, sa3.expiration_date, s.ORIGINAL_INIT_DATE
from    service_agreement@wh10p sa3, mdcust_ny.subscriber@wh10p s
where   1=1
--and     s.INIT_ACTIVATION_DATE > sysdate - 360
--and     s.ORIGINAL_INIT_DATE > sysdate - 360
and     s.SUB_STATUS = 'A'
--and     s.CUSTOMER_ID = sa3.BAN
--and     s.SUBSCRIBER_NO = sa3.SUBSCRIBER_NO
--        ,mdcust_ny.subscriber s
--and     s.SUB_STATUS = 'A'
--and     s.SUBSCRIBER_NO = sa3.SUBSCRIBER_NO
--and     s.CUSTOMER_ID = sa3.BAN
and     sa3.expiration_date > sysdate + 1000
--and     sa3.effective_date > sysdate - 10
--and     sa3.soc in ('PSDH','PSDJ','PSDK','PTMC','PTMG','PTMH')
--and (sa3.soc like 'WDF%' or sa3.soc like 'PK%' or sa3.soc like 'CAL%' or sa3.soc like 'SAF%')     
and     sa3.soc like 'MC%'
--and     (sa3.soc like 'PTM%' or sa3.soc like 'PSD%')
--and     rownum < 10
--and     sa3.SUBSCRIBER_NO in ('GSM04746545156', 'GSM04793039395')
--and     rownum < 1000
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
--SOC-kombinasjon
-- By Grouping
-- See below for single subscribers
select  /*+ parallel(sa1 , 6 )*/ 
        /*+ parallel(sa2, 6 )*/  
sa2.ban, sa2.subscriber_no
--, pd.IMSI
,sa2.soc prisplan
--, min(sa2.effective_date) min_pp_effective_date, max(sa2.effective_date) max_pp_effective_date
,s2.soc_description beskrivelse_pp, /*  sa2.campaign,   */
sa1.soc soc ,/*  substr(sa1.soc,1,3) soc,  */ s1.soc_description beskrivelse_soc
--, min(sa1.effective_date) min_soc_effective_date, max(sa1.effective_date) max_soc_effective_date
--, /*  sum (rc.rate),  */ count (*) antall
--sa2.soc prisplan, s2.soc_description beskrivelse_pp, sa2.campaign, sa1.soc soc,  s1.soc_description beskrivelse_soc,   /*  sum (rc.rate),  */ count (*) antall
from    tmp_hgu_soc_combo /*  mdcust_ny.service_agreement  */ sa1
        ,tmp_hgu_pp_combo sa2
        ,refwh02.soc@wh10p s1
        ,refwh02.soc@wh10p s2--, refwh02.pp_rc_rate rc
        --,mdcust_ny.physical_device pd
where 1=1
--and     imsi is not null
--and     (pd.expiration_date is null or pd.expiration_date > sysdate)
--and     pd.ban = sa1.BAN
--and     pd.SUBSCRIBER_NO = sa1.SUBSCRIBER_NO
--and (substr(sa2.soc,1,3) =  'CON' or substr(sa2.soc,1,3) =  'MPO')
--and substr(sa2.soc,1,2) =  'PK'
--and sa2.service_type = 'P'
and sa1.soc = s1.soc
and sa2.soc = s2.soc
and s1.expiration_date is null
and s2.expiration_date is null
and sa1.expiration_date >  sysdate + 1000 
and sa2.expiration_date >  sysdate + 1000
and sa2.ban = sa1.ban
and sa2.subscriber_no = sa1.subscriber_no
--and sa1.effective_date > sysdate - 10
--and sa2.effective_date > sysdate - 10
--and 
--group by sa1.soc, s1.soc_description , sa2.campaign, sa2.soc, s2.soc_description--, rc.rate
--order by sa2.soc, sa1.soc

);
commit;

-- select  count(*) from tmp_hgu_soc_combo

-- Deleting large temporary work tables

drop table tmp_hgu_pp_combo;
commit;

drop table tmp_hgu_soc_combo;
commit;


select * from tmp_hgu_pp_soc_combo sc
where     1=1
--and     sc.SOC in ('ODB12')
and     rownum < 26
order by prisplan, soc;

--select * from tmp_hgu_pp_soc_combo
--where     1=1
--and     soc <> 'WDFPRE'
--and     soc like 'WDF%'
--and     rownum < 26
--order by prisplan, soc;

select  slg33.prisplan, slg33.beskrivelse_pp, slg33.soc, slg33.beskrivelse_soc,  count(*) 
from    tmp_hgu_pp_soc_combo slg33
where   1=1
group by    slg33.prisplan, slg33.beskrivelse_pp, slg33.soc, slg33.beskrivelse_soc
order by    slg33.prisplan, slg33.beskrivelse_pp, slg33.soc, slg33.beskrivelse_soc;

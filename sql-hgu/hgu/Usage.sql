/*
MDSCORE	HIST_AGGR_USG_TRAFFIC	2903680084
CDATA	USG_ALL2	1253537787
CDATA	USG_ALL3	647098279
MD2	TMP_TRAF_USG_DATA_WH	359972045
CDATA	USG_ALL4	332786178
MC	MC_DAILY_USG_SID_INFO	119981225
MD2	TMP_TRAF_USG_SMS_WH	46576562
CDATA	USG_TEST	43928562
MD2	TMP_TRAF_USG_VOICE_WH	35159783
MDSCORE	TMP_AGGR_USG_TRAFFIC	19061364
MDSCORE	TMP_AGGR_USG_TRAFFIC2	18996124
MDSCORE	TMP_USG_IFS1	18491842
OC	OC_MONTHLY_USG_SID_SUMMARY	12279916
MDSCORE	TMP_USG_IFS2	9899822
MD2	TMP_MIN_BEDRIFT_USG	6502958
NGA_DATA	FAMILYPACK_INFO_AVG_DATA_USG_Q	3137931
NGA_DATA	MC_AM_DATA_USG_P_COUNTRY_Q	2495559
MDSCORE	TMP_USG_SPN	1344452
MD2	TMP_TRAF_USG_MMS_WH	1084173
*/

--SUB               BAN          SUB_ID
--GSM04793001860	292625605	3893063

select /*+ driving_site(a)*/ a.*
  from CDATA.USG_ALL3@wh12p a
-- where rownum < 11
 where a.ban           = 292625605
   and a.subscriber_no = 'GSM04793001860'
   and (a.call_date  like '2021121%' or a.call_date  like '2021122%')
   and a.b_number    like '47%'
   and a.b_number  not in ( '4793096910', '4795174240', '4797128607', '4745679855', '4795168850' )
   and a.at_feature_code like 'GSM%'
order by a.call_date
;

-- Bertelsen Begravelsesbyrå...
-- 292625605	GSM04793001860	20211220	150605	BW01	4772452537	4793001860		242029010900678		2	F	N		248	PPUR	D	292625605	GSMFAS	PPUR	2	3				2,03		1001521	99999	99999	0	11	4,14		GSM	FLN	01					2021-03-22 00:00	2022	1	16501113				274188637	4,14	2,03	168		ZERO     			N	NOSCEN	DEFSCN	2021-12-20 16:25					M		N	396956881

with my_filter as (
select /*+ driving_site(a)*/ a.*
  from CDATA.USG_ALL3@wh12p a
-- where rownum < 11
 where a.ban           = 292625605
   and a.subscriber_no = 'GSM04793001860'
   and (a.call_date  like '2021121%' or a.call_date  like '2021122%')
   and a.b_number    like '47%'
   and a.b_number  not in ( '4793096910', '4795174240', '4797128607', '4745679855' )
   and a.at_feature_code like 'GSM%'
order by a.call_date
)
SELECT /*+ driving_site(s)*/
       mf.call_date, mf.b_number,
       anl.ban, decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , anl.link_type, anl.birth_date
     , nd.tpid, nd.comp_reg_id, nd.e_faktura_ref, nd.first_name, nd.last_business_name, nd.additional_title
     , ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email
     , nd.name_format, ad.adr_type, nd.role_ind
     , nd.id_type, nd.identify
--       , anl.name_id, anl.address_id
--       , nd.*
  FROM subscriber@fokus        s
     , address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
     , my_filter               mf
 WHERE s.subscriber_no    = 'GSM0'||mf.b_number
   AND s.ctn_seq_no       = (SELECT MAX(s2.ctn_seq_no)
                              FROM subscriber@fokus s2
                             WHERE s2.subscriber_no = s.subscriber_no)
   AND anl.ban            = s.customer_id
   AND anl.subscriber_no IN ( s.subscriber_no )
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
--ORDER BY anl.ban, anl.subscriber_no, anl.link_type
ORDER BY mf.call_date, mf.b_number, anl.ban, decode(anl.link_type, 'C', 0, 'L', 1, 'B', 2, 'U', 3, 4), anl.subscriber_no
;

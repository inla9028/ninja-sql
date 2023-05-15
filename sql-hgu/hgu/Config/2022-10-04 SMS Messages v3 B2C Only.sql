select a.*
  from sms_messages_v3 a
 where a.msg_id       IN ( 8 )
   and a.customer_type = 'P'
   and a.language_code = 'NO'
   and sysdate   between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;


/*
--
-- Pre....
--

8 NO P
"Hei, nummeret ditt er bestilt av annen operatør. Vi vil minne om at brudd på bindingstid faktureres med kr :PORT_PENALTY. Ring 924 05050 for spørsmål. Hilsen Telia"

--
-- Post...
--

8 NO P
"Hei!

Nummeret ditt er bestilt av annen operatør og vi vil minne om bindingstiden din hos oss. Ettersom denne utløper :PORT_DATETIME vil du faktureres med :PORT_PENALTY kroner i bruddgebyr. Du kan unngå bruddgebyret ved å kontakte din nye operatør og be om at overføringen blir utsatt eller stanset.

Hilsen oss i Telia
"

*/


--
-- Expire current...
--
update sms_messages_v3 a
   set a.expiration_date = SYSDATE - (1/1440)
 where sysdate    between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and a.msg_id        IN ( 8 )
   and a.customer_type  = 'P'
   and a.language_code  = 'NO'
;

--
-- Insert new
--
INSERT INTO sms_messages_v3 (MSG_ID, LANGUAGE_CODE, CUSTOMER_TYPE, EFFECTIVE_DATE, FROM_CTN, MSG_TEXT)
VALUES (8, 'NO', 'P', SYSDATE, '05050', 'Hei!

Nummeret ditt er bestilt av annen operatør og vi vil minne om bindingstiden din hos oss. Ettersom denne utløper :PORT_DATETIME vil du faktureres med :PORT_PENALTY kroner i bruddgebyr. Du kan unngå bruddgebyret ved å kontakte din nye operatør og be om at overføringen blir utsatt eller stanset.

Hilsen oss i Telia')
;

--
--
--

select a.*
  from sms_messages_v3 a
 where a.msg_id       IN ( 8 )
   and a.customer_type = 'P'
   and a.language_code = 'NO'
   and sysdate   between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;

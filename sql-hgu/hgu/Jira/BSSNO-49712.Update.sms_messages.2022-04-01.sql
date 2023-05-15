select a.*
  from sms_messages_v3 a
 where a.msg_id        in ( 9    )
   and a.customer_type in ( 'P'  )
   and a.language_code IN ( 'NO' )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3
;

-- Expire the old message(s).
update sms_messages_v3 a
   set a.expiration_date = SYSDATE
 where a.msg_id        in ( 9    )
   and a.customer_type in ( 'P'  )
   and a.language_code IN ( 'NO' )
   and sysdate -1 between a.effective_date and nvl(a.expiration_date, sysdate + 1)
;

-- Msg id 9, B2C, Norwegian only.
insert into sms_messages_v3 (msg_id, language_code, customer_type, effective_date, from_ctn, msg_text, expiration_date)
values (9, 'NO', 'P', SYSDATE, '05051', 'Nå nærmer det seg! Vi minner om overføring til Telia :PORT_DATETIME. Husk å ha det nye SIM-kortet ditt klart. Dersom du ikke får dekning med en gang, kan vi foreslå å ta en restart av telefonen etter et par minutter.

Bruker du BankID på mobil? Da må du logge inn med kodebrikke i nettbanken din for å aktivere tjenesten på nytt 

Hilsen oss i Telia', NULL)
;

select a.*
  from sms_messages_v3 a
 where a.msg_id        in ( 9    )
   and a.customer_type in ( 'P'  )
   and a.language_code IN ( 'NO' )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3
;

select a.*
  from sms_messages_v3 a
 where a.msg_id        in ( 9, 10 )
   and a.customer_type in ( 'B'   )
   and a.language_code IN ( 'NO'  )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3
;

-- Expire the old messages.
update sms_messages_v3 a
   set a.expiration_date = SYSDATE
 where a.msg_id        in ( 9, 10 )
   and a.customer_type in ( 'B'   )
   and a.language_code IN ( 'NO'  )
   and sysdate -1 between a.effective_date and nvl(a.expiration_date, sysdate + 1)
;

-- Msg id 9, B2B, Norwegian only.
insert into sms_messages_v3 (msg_id, language_code, customer_type, effective_date, from_ctn, msg_text, expiration_date)
values (9, 'NO', 'B', SYSDATE, '05051', 'Hei, velkommen til Telia. Nummeret ditt overføres til oss :PORT_DATETIME. Ha nytt SIM-kort klart og husk at BankID på mobil må aktiveres på nytt med kodebrikke i nettbanken din.

Hilsen oss i Telia.', NULL)
;

-- Msg id 10, B2B, Norwegian only.
insert into sms_messages_v3 (msg_id, language_code, customer_type, effective_date, from_ctn, msg_text, expiration_date)
values (10, 'NO', 'B', SYSDATE, '05051', 'Ditt nummer :MSISDN er nå overført til Telia. Vi har lagt inn en 3 timers Data Boost til deg i Telia-appen. Det betyr at du kan surfe så mye du vil i perioden uten å bruke av din inkluderte datakvote. Og ikke glem at BankID på mobil må aktiveres på nytt i nettbanken med kodebrikke. Du finner informasjon om hvordan du kommer i gang med ditt nye abonnement her: telia.no/bedrift/velkommen

Hilsen oss i Telia.', NULL)
;

select a.*
  from sms_messages_v3 a
 where a.msg_id        in ( 9, 10 )
   and a.customer_type in ( 'B'   )
   and a.language_code IN ( 'NO'  )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3
;

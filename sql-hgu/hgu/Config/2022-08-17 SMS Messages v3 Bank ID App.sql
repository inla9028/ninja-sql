select a.*
  from sms_messages_v3 a
 where a.msg_id       IN ( 9, 10 )
   and a.language_code = 'NO'
   and sysdate   between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;


/*
--
-- Pre BankID APP.
--

9 NO B
"Hei, velkommen til Telia. Nummeret ditt overføres til oss :PORT_DATETIME. Ha nytt SIM-kort klart og husk at BankID på mobil må aktiveres på nytt med kodebrikke i nettbanken din.

Hilsen oss i Telia."

9 NO P
"Nå nærmer det seg! Vi minner om overføring til Telia :PORT_DATETIME. Husk å ha det nye SIM-kortet ditt klart. Dersom du ikke får dekning med en gang, kan vi foreslå å ta en restart av telefonen etter et par minutter.

Bruker du BankID på mobil? Da må du logge inn med kodebrikke i nettbanken din for å aktivere tjenesten på nytt 

Hilsen oss i Telia"

10	NO	B
"Ditt nummer :MSISDN er nå overført til Telia. Vi har lagt inn en 3 timers Data Boost til deg i Telia-appen. Det betyr at du kan surfe så mye du vil i perioden uten å bruke av din inkluderte datakvote. Og ikke glem at BankID på mobil må aktiveres på nytt i nettbanken med kodebrikke. Du finner informasjon om hvordan du kommer i gang med ditt nye abonnement her: telia.no/bedrift/velkommen

Hilsen oss i Telia."

10	NO	P
"Velkommen til Telia! Nå er mobilnummeret ditt :MSISDN overført. Ha en fortsatt fin dag, hilsen Telia"

--
-- Post BankID APP.
--

9 NO B
"Hei, velkommen til Telia. Nummeret ditt overføres til oss :PORT_DATETIME. Ha nytt SIM-kort klart. 

Benytter du BankID på mobil? I så fall må du installere BankID-appen etter overføringen for å aktivere tjenesten på nytt. Les mer her: BankID på mobilen | Telia Kundeservice.
Hilsen oss i Telia
"

9 NO P
"Nå nærmer det seg! Vi minner om overføring til Telia :PORT_DATETIME. Husk å ha det nye SIM-kortet ditt klart. Dersom du ikke får dekning med en gang, foreslår vi at du tar en restart av telefonen etter et par minutter.

Benytter du BankID på mobil? I så fall må du installere BankID-appen etter overføringen for å aktivere tjenesten på nytt. Les mer her: BankID på mobilen | Telia Kundeservice.

Hilsen oss i Telia
"

10	NO	B
"Ditt nummer :MSISDN er nå overført til Telia. Vi har lagt inn en 3 timers Data Boost til deg i Telia-appen. Det betyr at du kan surfe så mye du vil i perioden uten å bruke av din inkluderte datakvote. Og ikke glem at BankID på mobil er under utfasing og erstattes med BankID App. Du finner informasjon om hvordan du kommer i gang med ditt nye abonnement her: telia.no/bedrift/velkommen
Hilsen oss i Telia
"

10	NO	P
"Velkommen til Telia! Nå er mobilnummeret ditt :MSISDN overført. Vi har lagt til 2 x 3 timer Data Boost til deg i Telia-appen. Det betyr at du kan surfe så mye du vil i perioden uten å bruke av din inkluderte datakvote. Og ikke glem at BankID på mobil er under utfasing og erstattes med BankID App. Det kan du lese mer om her: BankID på mobilen | Telia Kundeservice
Hilsen oss i Telia
"

*/


--
-- Expire current...
--
update sms_messages_v3 a
   set a.expiration_date = SYSDATE - (1/1440)
 where sysdate    between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and a.msg_id        IN ( 9, 10 )
   and a.language_code  = 'NO'
   and a.customer_type IN ( 'B', 'P' )
;

--
-- Insert new
--
INSERT INTO sms_messages_v3 (MSG_ID, LANGUAGE_CODE, CUSTOMER_TYPE, EFFECTIVE_DATE, FROM_CTN, MSG_TEXT)
VALUES (9, 'NO', 'B', SYSDATE, '05051', 'Hei, velkommen til Telia. Nummeret ditt overføres til oss :PORT_DATETIME. Ha nytt SIM-kort klart. 

Benytter du BankID på mobil? I så fall må du installere BankID-appen etter overføringen for å aktivere tjenesten på nytt. Les mer her: BankID på mobilen | Telia Kundeservice.
Hilsen oss i Telia')
;

INSERT INTO sms_messages_v3 (MSG_ID, LANGUAGE_CODE, CUSTOMER_TYPE, EFFECTIVE_DATE, FROM_CTN, MSG_TEXT)
VALUES (9, 'NO', 'P', SYSDATE, '05050', 'Nå nærmer det seg! Vi minner om overføring til Telia :PORT_DATETIME. Husk å ha det nye SIM-kortet ditt klart. Dersom du ikke får dekning med en gang, foreslår vi at du tar en restart av telefonen etter et par minutter.

Benytter du BankID på mobil? I så fall må du installere BankID-appen etter overføringen for å aktivere tjenesten på nytt. Les mer her: BankID på mobilen | Telia Kundeservice.

Hilsen oss i Telia')
;

INSERT INTO sms_messages_v3 (MSG_ID, LANGUAGE_CODE, CUSTOMER_TYPE, EFFECTIVE_DATE, FROM_CTN, MSG_TEXT)
VALUES (10, 'NO', 'B', SYSDATE, '05051', 'Ditt nummer :MSISDN er nå overført til Telia. Vi har lagt inn en 3 timers Data Boost til deg i Telia-appen. Det betyr at du kan surfe så mye du vil i perioden uten å bruke av din inkluderte datakvote. Og ikke glem at BankID på mobil er under utfasing og erstattes med BankID App. Du finner informasjon om hvordan du kommer i gang med ditt nye abonnement her: telia.no/bedrift/velkommen
Hilsen oss i Telia')
;

INSERT INTO sms_messages_v3 (MSG_ID, LANGUAGE_CODE, CUSTOMER_TYPE, EFFECTIVE_DATE, FROM_CTN, MSG_TEXT)
VALUES (10, 'NO', 'P', SYSDATE, '05050', 'Velkommen til Telia! Nå er mobilnummeret ditt :MSISDN overført. Vi har lagt til 2 x 3 timer Data Boost til deg i Telia-appen. Det betyr at du kan surfe så mye du vil i perioden uten å bruke av din inkluderte datakvote. Og ikke glem at BankID på mobil er under utfasing og erstattes med BankID App. Det kan du lese mer om her: BankID på mobilen | Telia Kundeservice
Hilsen oss i Telia')
;

--
--
--

select a.*
  from sms_messages_v3 a
 where a.msg_id       IN ( 9, 10 )
   and a.language_code = 'NO'
   and sysdate   between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1,2,3,4
;

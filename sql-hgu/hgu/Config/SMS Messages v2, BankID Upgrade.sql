select a.*
  from sms_messages_v2 a
 where a.msg_id = 9
order by 1,2,3,4
;


/*
-- Pre BankID.
9 NO P 'Hei, nummeret ditt vil bli overført til Telia :PORT_DATETIME. Husk å ha det nye SIM-kortet klart. Hvis du bruker BankID på mobil må du logge inn med kodebrikke i din nettbank for å aktivere tjenesten på nytt. Hilsen Telia'

9 NO B 'Hei, velkommen til Telia.

Nummeret ditt :MSISDN overføres til oss :PORT_DATETIME. Ha nytt SIM-kort klart og husk at BankID på mobil må aktiveres på nytt med kodebrikke i nettbanken din. Og hvis tidspunktet ikke passer for deg, ring oss på 92405051 så ordner vi det.

Hilsen oss i Telia.'
*/

/*
-- Post BankID.
9 NO P 'Hei, vi minner om at nummeret ditt overføres til oss :PORT_DATETIME. Da kan du bytte ditt SIM-kort.
Hvis du bruker BankID på mobil, må du aktivere tjenesten på nytt med kodebrikke i nettbanken.

Grunnet planlagte endringer i BankID-tjenesten, vil dette imidlertid ikke være mulig i perioden 21.-26.10. Dette gjelder alle banker og operatører. Dersom du har en kodebrikke, vil denne fortsatt fungere. For deg som ikke har kodebrikke, kan vi forslå å legge inn en bestilling hos banken snarest. Da er du nemlig klar til å aktivere BankID på mobil f.o.m. 27.10 :)

Hilsen oss i Telia'

9 NO B 'Hei, vi minner om at nummeret ditt overføres til oss :PORT_DATETIME. Da kan du bytte ditt SIM-kort.
Hvis du bruker BankID på mobil, må du aktivere tjenesten på nytt med kodebrikke i nettbanken.

Grunnet planlagte endringer i BankID-tjenesten, vil dette imidlertid ikke være mulig i perioden 21.-26.10. Dette gjelder alle banker og operatører. Dersom du har en kodebrikke, vil denne fortsatt fungere. For deg som ikke har kodebrikke, kan vi forslå å legge inn en bestilling hos banken snarest. Da er du nemlig klar til å aktivere BankID på mobil f.o.m. 27.10 :)

Hilsen oss i Telia'
*/

update sms_messages_v2 a
   set a.msg_text      = 'Hei, vi minner om at nummeret ditt overføres til oss :PORT_DATETIME. Da kan du bytte ditt SIM-kort.
Hvis du bruker BankID på mobil, må du aktivere tjenesten på nytt med kodebrikke i nettbanken.

Grunnet planlagte endringer i BankID-tjenesten, vil dette imidlertid ikke være mulig i perioden 21.-26.10. Dette gjelder alle banker og operatører. Dersom du har en kodebrikke, vil denne fortsatt fungere. For deg som ikke har kodebrikke, kan vi forslå å legge inn en bestilling hos banken snarest. Da er du nemlig klar til å aktivere BankID på mobil f.o.m. 27.10 :)

Hilsen oss i Telia'
 where a.msg_id        = 9
   and a.language_code = 'NO'
   and a.customer_type = 'B'
;

--
-- Putting the "old" messages back
--
update sms_messages_v2 a
   set a.msg_text      = 'Hei, velkommen til Telia.

Nummeret ditt :MSISDN overføres til oss :PORT_DATETIME. Ha nytt SIM-kort klart og husk at BankID på mobil må aktiveres på nytt med kodebrikke i nettbanken din. Og hvis tidspunktet ikke passer for deg, ring oss på 92405051 så ordner vi det.

Hilsen oss i Telia.'
 where a.msg_id        = 9
   and a.language_code = 'NO'
   and a.customer_type = 'B'
;

update sms_messages_v2 a
   set a.msg_text      = 'Hei, nummeret ditt vil bli overført til Telia :PORT_DATETIME.

Husk å ha det nye SIM-kortet klart. Hvis du bruker BankID på mobil må du logge inn med kodebrikke i din nettbank for å aktivere tjenesten på nytt.

Hilsen Telia'
 where a.msg_id        = 9
   and a.language_code = 'NO'
   and a.customer_type = 'P'
;

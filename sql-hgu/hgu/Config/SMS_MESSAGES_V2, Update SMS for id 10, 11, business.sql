SELECT a.msg_id, a.language_code, a.customer_type, a.from_ctn,
       a.msg_text
  FROM sms_messages_v2 a
 WHERE a.msg_id IN (10, 11)
ORDER BY 1,2,3
;

UPDATE sms_messages_v2 a
   SET a.msg_text =
'Velkommen til Telia!

N� er mobilnummeret ditt :MSISDN overf�rt.
En gratis 3 timer Data Boost venter p� deg i Telia-appen.
Det betyr at du kan surfe s� mye du vil i perioden uten � bruke av din inkluderte datakvote.
Du finner appen og annen nyttig informasjon om hvordan komme i gang med ditt nye abonnement her: telia.no/bedrift/velkommen

Hilsen Telia'
 WHERE a.msg_id IN ( 10, 11 )
   AND a.language_code = 'NO'
   AND a.customer_type = 'B'
;


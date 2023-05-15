select a.*
  from porting_sms_filters a
order by 1,2,3
;
-- PPFB, PPFC, PPFD, PPFE
insert into porting_sms_filters (activity_code, filter_type, filter_value, comments , effective_date, expiration_date)
values ('PENSMS', 'PRICEPLAN', 'PPFB', 'See NOXT-17981 and NOCART-1190, Blocking SMSes while phasing out old portfolio', TO_DATE('2022-12-05', 'YYYY-MM-DD'), TO_DATE('2023-01-16 23:59', 'YYYY-MM-DD HH24:MI'));

insert into porting_sms_filters (activity_code, filter_type, filter_value, comments , effective_date, expiration_date)
values ('PENSMS', 'PRICEPLAN', 'PPFC', 'See NOXT-17981 and NOCART-1190, Blocking SMSes while phasing out old portfolio', TO_DATE('2022-12-05', 'YYYY-MM-DD'), TO_DATE('2023-01-16 23:59', 'YYYY-MM-DD HH24:MI'));

insert into porting_sms_filters (activity_code, filter_type, filter_value, comments , effective_date, expiration_date)
values ('PENSMS', 'PRICEPLAN', 'PPFD', 'See NOXT-17981 and NOCART-1190, Blocking SMSes while phasing out old portfolio', TO_DATE('2022-12-05', 'YYYY-MM-DD'), TO_DATE('2023-01-16 23:59', 'YYYY-MM-DD HH24:MI'));

insert into porting_sms_filters (activity_code, filter_type, filter_value, comments , effective_date, expiration_date)
values ('PENSMS', 'PRICEPLAN', 'PPFE', 'See NOXT-17981 and NOCART-1190, Blocking SMSes while phasing out old portfolio', TO_DATE('2022-12-05', 'YYYY-MM-DD'), TO_DATE('2023-01-16 23:59', 'YYYY-MM-DD HH24:MI'));


SELECT activity_code, filter_type, filter_value, effective_date, expiration_date
  FROM porting_sms_filters
 WHERE SYSDATE BETWEEN effective_date AND NVL(expiration_date, SYSDATE + 1)
;


SELECT activity_code, filter_type, filter_value, effective_date, expiration_date
  FROM porting_sms_filters
 WHERE SYSDATE < expiration_date
ORDER BY 1, 2, 3
;




update porting_sms_filters
   set effective_date = TO_DATE('2022-12-05', 'YYYY-MM-DD')
 where filter_value  IN ( 'PPFD', 'PPFE' )
;

update porting_sms_filters
   set expiration_date = TO_DATE('2023-01-16 23:59', 'YYYY-MM-DD HH24:MI')
 where filter_value  IN ( 'PPFD', 'PPFE' )
;

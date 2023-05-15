SELECT a.sim_number, a.reserve_id, a.reserve_date, a.status,
       a.last_update_date, a.dealer_code, a.hlr, a.imsi, a.location,
       a.pin, a.pin2, a.puk, a.puk2, a.sim_type, a.matching_id
  FROM reserved_sim_numbers a
;

INSERT INTO reserved_sim_numbers 
VALUES('08947080041000000019','TERJE_B_SAMSUNG_WATCH',TO_DATE('2016-09-28 12:22:13', 'YYYY-MM-DD HH24:MI:SS'),'RESERVED',TO_DATE('2016-10-24 11:20:27', 'YYYY-MM-DD HH24:MI:SS'),'NENI','90','242029009514467','NCLO',4872,8755,49453040,19059113,'410','1$es9-samsung.oberthur.net$0P7RDNBCZLY3JNLPF');

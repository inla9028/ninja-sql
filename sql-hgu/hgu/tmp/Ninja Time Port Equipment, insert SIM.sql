-- List port-orders in the main table...
SELECT   a.ninja_ref_id, a.nrdb_ref_id, a.user_id, a.ctn, a.ban,
         a.number_owner_code, a.donor_code, a.recipient_code,
         a.date_time_created, a.date_time_modified, a.date_time_port,
         a.description, a.action, a.proc_attempts, a.status, a.ninja_action
    FROM ninjadata.ninja_time_port a
   WHERE a.ctn IN ('04740342864', '04741385852', '04741344486')
     AND a.date_time_created > SYSDATE - 30
ORDER BY a.ctn, a.date_time_port

--Ordrehode: 571209 - Porteringsdato: 04.12.2009 - SIM: 026004747343 / GSM: 04795112150
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(792525,'E','08947080' || '026004747343','Y')
/
--Ordrehode: 571746 - Porteringsdato: 04.12.2009 - SIM: 026004747335 / GSM: 04793037114 
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(792526,'E','08947080' || '026004747335','Y')
/
--Ordrehode: 580617 - Porteringsdato: 07.12.2009 - SIM: 026004747327 / GSM: 04740829585
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(792662,'E','08947080' || '026004747327','Y')
/
--------------------------------------------------------------------------------
-- SIM: 026004747103
-- GSM: 04795112150 
-- Ordrehode: 571209
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(792525,'E','08947080' || '026004747103','Y')
/

--------------------------------------------------------------------------------
-- Ordrehode: 589227 - Porteringsdato. 09.12.2009 - SIM: 026004747095 / GSM: 93241599
/*INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(,'E','08947080' || '','Y')
*/

-- Ordrehode: 590855 - Porteringsdato: 09.12.2009 - SIM: 026004747087 / GSM: 92425338
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(793509,'E','08947080' || '026004747087','Y')
/

-- Ordrehode: 590970 - Porteringsdato: 09.12.2009 - SIM: 026004747079 / GSM: 91333698
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(793510,'E','08947080' || '026004747079','Y')
/

-- Ordrehode: 595510 - Porteringsdato: 10.12.2009 - SIM: 026004747061 / GSM: 95128295
/*INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(,'E','08947080' || '','Y')
*/

--------------------------------------------------------------------------------
-- Ordrehode: 611430 - Porteringsdato. 14.12.2009 - SIM: 026004746972 / GSM: 40342864 
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(791424,'E','08947080' || '026004746972','Y')
/
-- Ordrehode: 701007 - Porteringsdato: 28.12.2009 - SIM: 026004746964 / GSM: 41385852
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(794380,'E','08947080' || '026004746964','Y')
/
-- Ordrehode: 701131 - Porteringsdato: 28.12.2009 - SIM: 026004746956 / GSM: 41344486
INSERT INTO ninjadata.ninja_time_port_equipment
VALUES
(794381,'E','08947080' || '026004746956','Y')
/
--------------------------------------------------------------------------------

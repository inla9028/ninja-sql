ALTER TABLE sp_activation_bans
  ADD sys_update_date DATE
/

CREATE OR REPLACE TRIGGER sp_activation_bans_trg1
 BEFORE INSERT OR UPDATE
  ON sp_activation_bans
REFERENCING NEW AS new OLD AS old
 FOR EACH ROW
BEGIN
    IF INSERTING
    THEN
        IF :new.sys_update_date IS NULL
        THEN
            :new.sys_update_date := SYSDATE;
        END IF;
    END IF;

    IF UPDATING
    THEN
        :new.sys_update_date := SYSDATE;
    END IF;
END;
/

/*
** Run as NINJAMAIN
*/
UPDATE sp_activation_bans a
   SET a.sys_update_date = (SELECT b.sys_update_date FROM billing_account@fokus b WHERE b.ban = a.ban)
;

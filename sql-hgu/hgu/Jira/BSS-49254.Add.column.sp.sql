DESC batch_change_priceplan
;

DESC batch_change_priceplan_w_clone
;

DESC master_chg_pp_trans
;


ALTER TABLE batch_change_priceplan
  ADD sp VARCHAR2(1 CHAR) DEFAULT 'N'
/

ALTER TABLE batch_change_priceplan_w_clone
  ADD sp VARCHAR2(1 CHAR) DEFAULT 'N'
/

ALTER TABLE master_chg_pp_trans
  ADD sp VARCHAR2(1 CHAR) DEFAULT 'N'
/

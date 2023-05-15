SELECT a.*
  FROM batch_change_priceplan a
 WHERE ROWNUM < 11
;

ALTER TABLE batch_change_priceplan
ADD (
    separate_saves VARCHAR2(1 byte) DEFAULT 'N'
)
;

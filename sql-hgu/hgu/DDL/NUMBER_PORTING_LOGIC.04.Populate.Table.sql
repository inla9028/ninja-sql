SELECT a.*
  FROM number_porting_logic a
 WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

SELECT a.effective_date, a.expiration_date, COUNT(1) AS "COUNT"
  FROM number_porting_logic a
GROUP BY a.effective_date, a.expiration_date
ORDER BY a.effective_date, a.expiration_date
;

UPDATE number_porting_logic a
   SET a.expiration_date = TRUNC(SYSDATE)
 WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

INSERT INTO number_porting_logic VALUES('S','X','N',NULL,'Y','PFE','isCleanPortIn()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','X','N','AG','Y','PFE','isCleanPortIn()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('B','N','N','AG','B','PFE','isNetComPortBackFromExternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('B','N','N','AI','I','PFI','isNetComPortBackFromInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('B','N','N','AS','I','PFI','isNetComPortBackFromInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','S','Y','AI','Y','PFI','isNetComPortInFromInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','S','Y','AS','Y','PFI','isNetComPortInFromInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','S','Y','AG','P','PFE','isNetComSPPortInFromExternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','X','N','AI','Y','PFI','isNetComPortInExtNumIntSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','X','N','AS','Y','PFI','isNetComPortInExtNumIntSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('U','X','N','AI','Y','PFI','isNetComPortInExtNumIntSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('U','X','N','AS','Y','PFI','isNetComPortInExtNumIntSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('V','X','N','AI','Y','PFI','isNetComPortInExtNumIntSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('V','X','N','AS','Y','PFI','isNetComPortInExtNumIntSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('B','S','Y','AG','B','PFE2I','isSPPortBackExternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('B','S','N','AI','B','PFI2I','isSPPortBack()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('B','S','N','AS','B','PFI2I','isSPPortBack()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','S','N','AG','P','PFE2I','isSPPortBackSPExternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('U','S','Y','AI','P','PFI2I','isSPPortBackInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('U','S','Y','AS','P','PFI2I','isSPPortBackInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('V','S','Y','AI','P','PFI2I','isSPPortBackInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('V','S','Y','AS','P','PFI2I','isSPPortBackInternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','N','Y','AG','P','PFE2I','isSPNetComPortInExternal()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','S','N','AI','I','PFI2I','isSPPortInInternalSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('S','S','N','AS','I','PFI2I','isSPPortInInternalSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('U','S','N','AI','I','PFI2I','isSPPortInInternalSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('U','S','N','AS','I','PFI2I','isSPPortInInternalSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('V','S','N','AI','I','PFI2I','isSPPortInInternalSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO number_porting_logic VALUES('V','S','N','AS','I','PFI2I','isSPPortInInternalSP()',TRUNC(SYSDATE),TO_DATE('4700-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

SELECT a.*
  FROM number_porting_logic a
 WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

SELECT a.effective_date, a.expiration_date, COUNT(1) AS "COUNT"
  FROM number_porting_logic a
GROUP BY a.effective_date, a.expiration_date
ORDER BY a.effective_date, a.expiration_date
;




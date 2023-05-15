SELECT a.soc1, a.feature_code1, a.soc2, a.feature_code2,
       a.must_be_expired
  FROM ninjaatrules.feature_expiration_rules a
  WHERE a.soc1 IN ('PKOT', 'PKOC', 'PPTH', 'PPOH')

/*
PPOHREG1 	VMORG
PPOHREG1 	VMORG+
PPOHREG1 	VMPOST01

PPTHREG1 	VMPOST01
PPTHREG1 	VMPRIV
PPTHREG1 	VMPRIV+
PPTHREG1 	VMSTO
PPTHREG1 	VMSTO+
*/

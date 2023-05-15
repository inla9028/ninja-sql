/*
    FOR the NEO2.1 and 3.0 to work for companies, the bedrift and privat
    skillemappe have to be created in Fokus and registrered in SalesMaker.
    To update the quality of companies, we need a script that creates a
    skillemappe in Fokus and updating SalesMaker wit h the skillemappe
    BAN number.

    SQL to retrieve MANs that are missing a skillemappe:
*/
--== Underavtale:
SELECT * FROM (
SELECT *
  FROM esm_orion_agreement_dummyban c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'BEDRIFT_ABO_DUMMY')
UNION
SELECT *
  FROM esm_orion_agreement_dummyban c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'PRIVAT_ABO_DUMMY')
) WHERE dummyban = 100248509;

--== Avtale:
SELECT * FROM (
SELECT *
  FROM esm_orion_agreement c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'BEDRIFT_ABO_DUMMY')
UNION
SELECT *
  FROM esm_orion_agreement c
 WHERE c.product_key = 65
   AND c.value_key = 'RAMMEAVTALE'
   AND c.internal_sm_key NOT IN (SELECT er9_key
                                   FROM er9_multivalues
                                  WHERE er9_atribute = 'PRIVAT_ABO_DUMMY')
) WHERE man = '100168400';


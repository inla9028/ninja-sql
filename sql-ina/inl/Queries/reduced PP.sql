  SELECT /*+  ordered  */DISTINCT SOC.SOC,   
         SOC.EFFECTIVE_DATE,   
         SOC.SALE_EFF_DATE,   
         SOC.SALE_EXP_DATE,   
         SOC.SOC_DESCRIPTION,   
         SOC.SERVICE_TYPE,   
         SOC.SOC_LEVEL_CODE,   
         SOC.CUSTOMER_TYPE,   
         SOC.MINIMUM_NO_MONTHS,   
         SOC.EXPIRATION_DATE,   
         SOC_RELATION.SOC_DEST,   
         PROMOTION_TERMS.DURATION,   
         PROMOTION_TERMS.DURATION_IND,   
         PROMOTION_TERMS.CUT_DATE,   
         PROMOTION_TERMS.LIMIT,   
         PROMOTION_TERMS.LIMIT_PERIOD,   
         ' '  
    FROM SOC,   
         SOC_RELATION,   
         PROMOTION_TERMS,   
         SOC_CREDIT_CLASS  
   WHERE ( SOC_RELATION.SOC_SRC = SOC.SOC ) and  
         ( PROMOTION_TERMS.SOC = SOC.SOC ) and  
         ( SOC.SOC = SOC_CREDIT_CLASS.SOC ) and  
         ( SOC.EFFECTIVE_DATE = SOC_CREDIT_CLASS.EFFECTIVE_DATE ) and  
         --( SOC_CREDIT_CLASS.CREDIT_CLASS > =:credit_class OR :credit_class IS NULL) AND  
         ( SOC.SERVICE_TYPE = 'M' ) AND  
         ( SOC.SOC_STATUS = 'A' ) AND  
         ( SOC.FOR_SALE_IND = 'Y' ) AND  
         ( ( SOC.EFFECTIVE_DATE <= sysdate ) AND  
         ( ( SOC.EXPIRATION_DATE >= sysdate ) OR  
         ( SOC.EXPIRATION_DATE IS NULL ) ) ) AND  
         ( SOC_RELATION.RELATION_TYPE = 'F' ) AND  
         ( SOC_RELATION.SRC_EFFECTIVE_DATE <= sysdate ) AND  
         ( SOC_RELATION.DEST_EFFECTIVE_DATE <= sysdate ) AND  
         ( PROMOTION_TERMS.EFFECTIVE_DATE <= sysdate ) AND  
         ( ( PROMOTION_TERMS.EXPIRATION_DATE >= sysdate ) OR  
         ( PROMOTION_TERMS.EXPIRATION_DATE IS NULL ) ) AND  
         ( ( SOC_RELATION.EXPIRATION_DATE >= sysdate ) OR  
         ( SOC_RELATION.EXPIRATION_DATE IS NULL ) ) AND  
         (--(:ls_pp = ' ') OR  
         (SOC_RELATION.SOC_DEST = 'PPTL'))  AND
         ((:sub_org is not NULL)
            AND (SOC.SOC not in (SELECT DISTINCT SUB_ORG_SOC_REL.SOC from  SUB_ORG_SOC_REL 
                                                  WHERE (SUB_ORG_SOC_REL.SUB_ORG_CD <> :sub_org  
                                                      AND SUB_ORG_SOC_REL.SOC <> '*' 
                                                      AND (SUB_ORG_SOC_REL.EFFECTIVE_DATE <= sysdate) 
                                                      AND  (( SUB_ORG_SOC_REL.EXPIRATION_DATE >= sysdate) 
                                                                  OR 
                                                               ( SUB_ORG_SOC_REL.EXPIRATION_DATE IS NULL )))
                                                   minus ( SELECT SUB_ORG_SOC_REL.SOC 
                                                               FROM SUB_ORG_SOC_REL 
                                                               WHERE SUB_ORG_SOC_REL.SUB_ORG_CD = :sub_org
                                                                   AND (SUB_ORG_SOC_REL.EFFECTIVE_DATE <= sysdate) 
                                                                   AND ( ( SUB_ORG_SOC_REL.EXPIRATION_DATE >= sysdate) 
                                                                              OR  
                                                                            ( SUB_ORG_SOC_REL.EXPIRATION_DATE IS NULL )))))
                    OR ((:sub_org is NULL) AND (SOC.SOC not in(SELECT DISTINCT SUB_ORG_SOC_REL.SOC 
                                                                                                FROM SUB_ORG_SOC_REL 
                                                                                                WHERE SUB_ORG_SOC_REL.EFFECTIVE_DATE <= sysdate
                                                                                                     AND (( SUB_ORG_SOC_REL.EXPIRATION_DATE >= sysdate) 
                                                                                                              OR  
                                                                                                             ( SUB_ORG_SOC_REL.EXPIRATION_DATE IS NULL ) )) )))
ORDER BY SOC.SOC_LEVEL_CODE ASC,   
         SOC.SOC ASC   



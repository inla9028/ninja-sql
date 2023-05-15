  SELECT DISTINCT "SOC"."SOC",   
         "SOC"."EFFECTIVE_DATE",   
         "SOC"."SALE_EFF_DATE",   
         "SOC"."SALE_EXP_DATE",   
         "SOC"."SOC_DESCRIPTION",   
         "SOC"."SERVICE_TYPE",   
         "SOC"."SOC_LEVEL_CODE",   
         "SOC"."CUSTOMER_TYPE",   
         "SOC"."MINIMUM_NO_MONTHS",   
         "SOC"."EXPIRATION_DATE",   
         "SOC"."PRODUCT_TYPE" ,
         "SOC"."SOC_GROUP",
		"PROMOTION_TERMS"."DURATION",
		"PROMOTION_TERMS"."DURATION_IND",
		"PROMOTION_TERMS"."AUTO_RENEWAL_IND",  
		"PROMOTION_TERMS"."CUT_DATE",
		"PROMOTION_TERMS"."PP_IND"
    FROM "SOC",   
         "SOC_CREDIT_CLASS",
		"SUB_ORG_SOC_REL",
		"PROMOTION_TERMS"  
   WHERE ("SOC"."SOC" = "PROMOTION_TERMS"."SOC" (+)) AND
         ( "SOC"."EFFECTIVE_DATE" = "PROMOTION_TERMS"."EFFECTIVE_DATE" (+)) AND 
         ( "SOC"."SOC" = "SOC_CREDIT_CLASS"."SOC" ) and  
         ( "SOC"."EFFECTIVE_DATE" = "SOC_CREDIT_CLASS"."EFFECTIVE_DATE" ) and  
         ( "SOC"."FOR_SALE_IND" = 'Y' ) AND  
         ( "SOC"."SERVICE_TYPE" in ('R','E','G') ) AND  
         ( "SOC_CREDIT_CLASS"."CREDIT_CLASS" > =:credit_class OR  
         :credit_class IS NULL) AND  
         ( "SOC"."SOC_STATUS" = 'A' ) AND  
         ( "SOC"."EFFECTIVE_DATE" <= :ld_today ) AND  
         ( ( "SOC"."EXPIRATION_DATE" >= :ld_today ) OR  
         ( "SOC"."EXPIRATION_DATE" IS NULL ) ) AND  
         (("SOC"."CUSTOMER_TYPE" = :as_customer_type OR  
          ("SOC"."CUSTOMER_TYPE" IS NULL and :as_gp_ind = 'Y' )OR  
         :as_customer_type = '-1') AND  
         ("SOC"."CUSTOMER_SUBTYPE" = :as_customer_sub_type OR  
         "SOC"."CUSTOMER_SUBTYPE" IS NULL OR  
         :as_customer_sub_type = '-1')) AND  
         ("SOC"."SOC" in ( SELECT "SOC_SALE_CHANNEL"."SOC" FROM "SOC_SALE_CHANNEL" 
                           WHERE ( ( "SOC_SALE_CHANNEL"."EFFECTIVE_DATE" <= :ld_today ) 
                           AND     ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" >= :ld_today ) 
                                     OR 
                                   ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" IS NULL ) ) 
                           AND ( "SOC_SALE_CHANNEL"."SOC_CHANNEL_CD" in ( :sec_param ) ) 
                           OR ( "SOC_SALE_CHANNEL"."SOC_CHANNEL_CD" = '') 
                           OR ( "SOC_SALE_CHANNEL"."SOC_CHANNEL_CD" IS NULL ) 
                           OR ( :null_ind = 'Y' ) ) 
                    OR  
                         not exists ( SELECT "SOC_SALE_CHANNEL"."SOC" FROM "SOC_SALE_CHANNEL" 
                                      WHERE ( ( "SOC_SALE_CHANNEL"."EFFECTIVE_DATE" <= :ld_today ) 
                                              AND 
                                              ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" >= :ld_today ) 
                                              OR  ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" IS NULL )
                                            ) 
                                      AND   "SOC_SALE_CHANNEL"."SOC" = "SOC"."SOC" ) )  
      AND ((:as_sub_org is not NULL) AND ("SOC"."SOC" not in (SELECT DISTINCT "SUB_ORG_SOC_REL"."SOC" from  "SUB_ORG_SOC_REL" 
                                						  WHERE ("SUB_ORG_SOC_REL"."SUB_ORG_CD" <> :as_sub_org  
                                     				           AND "SUB_ORG_SOC_REL"."SOC" <> '*' 
                                                                 AND ("SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today) 
		                                                        AND  (( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                  OR 
                                                                           ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL )))
                                                           minus ( SELECT "SUB_ORG_SOC_REL"."SOC" 
                                                                       FROM "SUB_ORG_SOC_REL" 
                                                                       WHERE "SUB_ORG_SOC_REL"."SUB_ORG_CD" = :as_sub_org
		                                                                  AND ("SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today) 
		                                                                  AND ( ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                            OR  
                                                                                    ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL )))))
            OR ((:as_sub_org is NULL) AND ("SOC"."SOC" not in(SELECT DISTINCT "SUB_ORG_SOC_REL"."SOC" 
                                                                                                         FROM "SUB_ORG_SOC_REL" 
                                						                                               WHERE "SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today
                                                                                                              AND (( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                                                              OR  
                                                                                                                       ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL ) )) )))
	union 
			SELECT DISTINCT "SOC"."SOC",   
         "SOC"."EFFECTIVE_DATE",   
         "SOC"."SALE_EFF_DATE",   
         "SOC"."SALE_EXP_DATE",   
         "SOC"."SOC_DESCRIPTION",   
         "SOC"."SERVICE_TYPE",   
         "SOC"."SOC_LEVEL_CODE",   
         "SOC"."CUSTOMER_TYPE",   
         "SOC"."MINIMUM_NO_MONTHS",   
         "SOC"."EXPIRATION_DATE",   
         "SOC"."PRODUCT_TYPE" ,
         "SOC"."SOC_GROUP",
		"PROMOTION_TERMS"."DURATION",
		"PROMOTION_TERMS"."DURATION_IND",
		"PROMOTION_TERMS"."AUTO_RENEWAL_IND",  
		"PROMOTION_TERMS"."CUT_DATE",
		"PROMOTION_TERMS"."PP_IND" 
    FROM "SOC",   
         "SOC_CREDIT_CLASS",
		"SOC_ACC_TYP_REL",
         "PROMOTION_TERMS"   
   WHERE ("SOC"."SOC" = "PROMOTION_TERMS"."SOC" (+)) AND
         ( "SOC"."EFFECTIVE_DATE" = "PROMOTION_TERMS"."EFFECTIVE_DATE" (+)) AND 
         ( "SOC"."SOC" = "SOC_CREDIT_CLASS"."SOC" ) and  
	    ("SOC_ACC_TYP_REL"."SOC"="SOC"."SOC") AND 
		("SOC_ACC_TYP_REL"."SOC"=  "SOC_CREDIT_CLASS"."SOC") AND
         ( "SOC"."EFFECTIVE_DATE" = "SOC_CREDIT_CLASS"."EFFECTIVE_DATE" ) and  
         ( "SOC"."FOR_SALE_IND" = 'Y' ) AND  
         ( "SOC"."SERVICE_TYPE" in ('R','E','G') ) AND  
         ( "SOC_CREDIT_CLASS"."CREDIT_CLASS" > =:credit_class OR  
         :credit_class IS NULL) AND  
         ( "SOC"."SOC_STATUS" = 'A' ) AND  
         ( "SOC"."EFFECTIVE_DATE" <= :ld_today ) AND  
         ( ( "SOC"."EXPIRATION_DATE" >= :ld_today ) OR  
         ( "SOC"."EXPIRATION_DATE" IS NULL ) ) and
         ("SOC"."SOC" in ( SELECT "SOC_SALE_CHANNEL"."SOC" FROM "SOC_SALE_CHANNEL" WHERE ( ( "SOC_SALE_CHANNEL"."EFFECTIVE_DATE" <= :ld_today ) AND ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" >= :ld_today ) OR ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" IS NULL ) ) AND ( "SOC_SALE_CHANNEL"."SOC_CHANNEL_CD" in ( :sec_param ) ) OR ( "SOC_SALE_CHANNEL"."SOC_CHANNEL_CD" = '') OR ( "SOC_SALE_CHANNEL"."SOC_CHANNEL_CD" IS NULL ) OR ( :null_ind = 'Y' ) ) OR  
         not exists ( SELECT "SOC_SALE_CHANNEL"."SOC" FROM "SOC_SALE_CHANNEL" WHERE ( ( "SOC_SALE_CHANNEL"."EFFECTIVE_DATE" <= :ld_today ) AND ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" >= :ld_today ) OR ( "SOC_SALE_CHANNEL"."EXPIRATION_DATE" IS NULL ) ) AND "SOC_SALE_CHANNEL"."SOC" = "SOC"."SOC" ) )   and
			((("SOC_ACC_TYP_REL"."EFFECTIVE_DATE" <=  :ld_today) AND ( "SOC_ACC_TYP_REL"."EXPIRATION_DATE" >= :ld_today ) 
		 	OR ( "SOC_ACC_TYP_REL"."EXPIRATION_DATE" IS NULL ))) AND 
			(( "SOC_ACC_TYP_REL"."ACCOUNT_TYPE" = :as_customer_type AND "SOC_ACC_TYP_REL"."ACCOUNT_SUB_TYPE" = :as_customer_sub_type) OR 
			("SOC_ACC_TYP_REL"."ACCOUNT_TYPE" = :as_customer_type AND "SOC_ACC_TYP_REL"."ACCOUNT_SUB_TYPE" ='AL' ) 
		OR ("SOC_ACC_TYP_REL"."ACCOUNT_TYPE" ='A' AND "SOC_ACC_TYP_REL"."ACCOUNT_SUB_TYPE" = :as_customer_sub_type) 
   	OR ("SOC_ACC_TYP_REL"."ACCOUNT_SUB_TYPE" ='AL' AND "SOC_ACC_TYP_REL"."ACCOUNT_TYPE" ='A'))  
	AND ((:as_sub_org is not NULL) AND ("SOC"."SOC" not in (SELECT DISTINCT "SUB_ORG_SOC_REL"."SOC" from  "SUB_ORG_SOC_REL" 
                                						  WHERE ("SUB_ORG_SOC_REL"."SUB_ORG_CD" <> :as_sub_org  
                                     				           AND "SUB_ORG_SOC_REL"."SOC" <> '*' 
                                                                 AND ("SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today) 
		                                                        AND  (( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                  OR 
                                                                           ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL )))
                                                           minus ( SELECT "SUB_ORG_SOC_REL"."SOC" 
                                                                       FROM "SUB_ORG_SOC_REL" 
                                                                       WHERE "SUB_ORG_SOC_REL"."SUB_ORG_CD" = :as_sub_org
		                                                                  AND ("SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today) 
		                                                                  AND ( ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                            OR  
                                                                                    ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL )))))
            OR ((:as_sub_org is NULL) AND ("SOC"."SOC" not in(SELECT DISTINCT "SUB_ORG_SOC_REL"."SOC" 
                                                                                                         FROM "SUB_ORG_SOC_REL" 
                                						                                               WHERE "SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today
                                                                                                              AND (( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                                                              OR  
                                                                                                                       ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL ) )) )))
   UNION   
  SELECT "SOC"."SOC",   
         "SOC"."EFFECTIVE_DATE",   
         "SOC"."SALE_EFF_DATE",   
         "SOC"."SALE_EXP_DATE",   
         "SOC"."SOC_DESCRIPTION",   
         "SOC"."SERVICE_TYPE",   
         "SOC"."SOC_LEVEL_CODE",   
         "SOC"."CUSTOMER_TYPE",   
         "SOC"."MINIMUM_NO_MONTHS",   
         "SOC"."EXPIRATION_DATE",   
         "SOC"."PRODUCT_TYPE",
         "SOC"."SOC_GROUP",
		"PROMOTION_TERMS"."DURATION",
		"PROMOTION_TERMS"."DURATION_IND",
		"PROMOTION_TERMS"."AUTO_RENEWAL_IND",  
		"PROMOTION_TERMS"."CUT_DATE",
		"PROMOTION_TERMS"."PP_IND"
    FROM "SOC",   
         "SOC_CREDIT_CLASS",   
         "SOC_RELATION",
		"PROMOTION_TERMS"  
   WHERE ("SOC"."SOC" = "PROMOTION_TERMS"."SOC" (+)) AND
         ( "SOC"."EFFECTIVE_DATE" = "PROMOTION_TERMS"."EFFECTIVE_DATE" (+)) AND 
         ( "SOC"."SOC" = "SOC_RELATION"."SOC_DEST" ) and  
         ( "SOC"."SOC" = "SOC_CREDIT_CLASS"."SOC" ) and  
         ( "SOC"."EFFECTIVE_DATE" = "SOC_CREDIT_CLASS"."EFFECTIVE_DATE" ) and  
         ("SOC_CREDIT_CLASS"."CREDIT_CLASS" >= :credit_class OR  
         :credit_class is null) AND  
         "SOC"."SERVICE_TYPE" = 'O' AND  
         "SOC"."SOC_STATUS" = 'A' AND  
         "SOC"."FOR_SALE_IND" = 'Y' AND  
         "SOC"."EFFECTIVE_DATE" <= :ld_today AND  
         ("SOC"."EXPIRATION_DATE" >= :ld_today OR  
         "SOC"."EXPIRATION_DATE" is null) AND  
         "SOC_RELATION"."RELATION_TYPE" = 'O' AND  
         "SOC_RELATION"."SRC_EFFECTIVE_DATE" <= :ld_today AND  
         "SOC_RELATION"."DEST_EFFECTIVE_DATE" <= :ld_today AND  
         ("SOC_RELATION"."EXPIRATION_DATE" >= :ld_today OR  
         "SOC_RELATION"."EXPIRATION_DATE" is null) AND  
         "SOC_RELATION"."SOC_SRC" = :ls_pp   
		AND ((:as_sub_org is not NULL) AND ("SOC"."SOC" not in (SELECT DISTINCT "SUB_ORG_SOC_REL"."SOC" from  "SUB_ORG_SOC_REL" 
                                						  WHERE ("SUB_ORG_SOC_REL"."SUB_ORG_CD" <> :as_sub_org  
                                     				           AND "SUB_ORG_SOC_REL"."SOC" <> '*' 
                                                                 AND ("SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today) 
		                                                        AND  (( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                  OR 
                                                                           ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL )))
                                                           minus ( SELECT "SUB_ORG_SOC_REL"."SOC" 
                                                                       FROM "SUB_ORG_SOC_REL" 
                                                                       WHERE "SUB_ORG_SOC_REL"."SUB_ORG_CD" = :as_sub_org
		                                                                  AND ("SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today) 
		                                                                  AND ( ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                            OR  
                                                                                    ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL )))))
            OR ((:as_sub_org is NULL) AND ("SOC"."SOC" not in(SELECT DISTINCT "SUB_ORG_SOC_REL"."SOC" 
                                                                                                         FROM "SUB_ORG_SOC_REL" 
                                						                                               WHERE "SUB_ORG_SOC_REL"."EFFECTIVE_DATE" <= :ld_today
                                                                                                              AND (( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" >= :ld_today) 
		                                                                                                              OR  
                                                                                                                       ( "SUB_ORG_SOC_REL"."EXPIRATION_DATE" IS NULL ) )) )))
ORDER BY 7 ASC,   
         1 ASC   

-- Start of DDL Script for Package Body NINJAMAIN.POPULATE_PREPAID_SOCS
-- Generated 2016-06-24 11:40:03 from NINJAMAIN@NINJAPROD1

CREATE OR REPLACE 
PACKAGE populate_prepaid_socs AS
    PROCEDURE ADD_WDFPRE_SERVICE;
    PROCEDURE ADD_MPODPRE01_SERVICE;
    PROCEDURE ADD_VMMINI_SERVICE;
    PROCEDURE ADD_MMS03_SERVICE;
    PROCEDURE ADD_MMS04_SERVICE;
END POPULATE_PREPAID_SOCS;
/


CREATE OR REPLACE 
PACKAGE BODY populate_prepaid_socs
AS

    PROCEDURE ADD_WDFPRE_SERVICE IS
    
        CURSOR C1 IS
            SELECT  S.SUBSCRIBER_NO, 
                    'WDFPRE'  SOC, 
                    'ADD' ACTION, 
                    SYSDATE AS REQUEST_TIME, 
                    '2' PRIORITY, 
                    'STLI15-' ||  TO_CHAR(SYSDATE, 'DD.MM.YYYY') AS REQUEST_ID,
                    'All PKx subs should have WDFPRE soc. Adding SOC due to error in preactivation of PKx priceplans. On request by Beatrix Daryous Dietze and Staffan Lindberg (Using Ninja Batch Job). '  AS MEMO_TEXT
            FROM     IPL.VW_NINJA_SUB_TO_GET_WDFPRE@OPPE10 S;

        CURSOR_ROW C1%ROWTYPE;
    
        BEGIN    
            FOR CURSOR_ROW IN C1 LOOP
                INSERT INTO MASTER_TRANSACTIONS
                            (TRANS_NUMBER, SUBSCRIBER_NO, SOC, ACTION_CODE, 
                            NEW_SOC, ENTER_TIME, REQUEST_TIME, PROCESS_TIME, 
                            PROCESS_STATUS, STATUS_DESC, DEALER_CODE, SALES_AGENT, 
                            PRIORITY, REQUEST_ID,MEMO_TEXT,
                            STREAM)
                VALUES         (NULL, CURSOR_ROW.SUBSCRIBER_NO,CURSOR_ROW.SOC, CURSOR_ROW.ACTION, 
                             NULL, NULL,CURSOR_ROW.REQUEST_TIME,NULL, 
                             'WAITING', NULL, NULL,NULL, 
                             CURSOR_ROW.PRIORITY, CURSOR_ROW.REQUEST_ID,CURSOR_ROW.MEMO_TEXT,
                             DECODE( MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4),10) + 1,
                                      NULL, 1,
                                     MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4), 10)+ 1
                                   )
                            );
                -- Commit work
                COMMIT;
          
            END LOOP;

        END ADD_WDFPRE_SERVICE;

    PROCEDURE ADD_MPODPRE01_SERVICE IS
    
        CURSOR C2 IS
            SELECT  S.SUBSCRIBER_NO, 
                    'MPODPRE01' SOC, 
                    'ADD' ACTION, 
                    SYSDATE AS REQUEST_TIME, 
                    '2' PRIORITY, 
                    'STLI15-' ||  TO_CHAR(SYSDATE,'DD.MM.YYYY') AS REQUEST_ID, 
                    'All voice PKx subs (except PKOD and PKOU) should have GPRS soc. Adding MPODPRE01 due to error in preactivation of PKx priceplans. On request by Beatrix Daryous Dietze and Staffan Lindberg (Using Ninja Batch Job). ' AS MEMO_TEXT
            FROM     IPL.VW_NINJA_SUB_TO_GET_MPODPRE01@OPPE10 S;

        CURSOR_ROW C2%ROWTYPE;
    
        BEGIN    
            FOR CURSOR_ROW IN C2 LOOP
                INSERT INTO MASTER_TRANSACTIONS
                            (TRANS_NUMBER, SUBSCRIBER_NO, SOC, ACTION_CODE, 
                            NEW_SOC, ENTER_TIME, REQUEST_TIME, PROCESS_TIME, 
                            PROCESS_STATUS, STATUS_DESC, DEALER_CODE, SALES_AGENT, 
                            PRIORITY, REQUEST_ID,MEMO_TEXT,
                            STREAM)
                VALUES         (NULL, CURSOR_ROW.SUBSCRIBER_NO,CURSOR_ROW.SOC, CURSOR_ROW.ACTION, 
                             NULL, NULL,CURSOR_ROW.REQUEST_TIME,NULL, 
                             'WAITING', NULL, NULL,NULL, 
                             CURSOR_ROW.PRIORITY, CURSOR_ROW.REQUEST_ID,CURSOR_ROW.MEMO_TEXT,
                             DECODE( MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4),10) + 1,
                                      NULL, 1,
                                     MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4), 10)+ 1
                                   )
                            );
                -- Commit work
                COMMIT;
          
            END LOOP;

        END ADD_MPODPRE01_SERVICE;


    PROCEDURE ADD_VMMINI_SERVICE IS
    
        CURSOR C3 IS
            SELECT  S.SUBSCRIBER_NO, 
                    'VMMINI'  SOC, 
                    'ADD'  ACTION, 
                    SYSDATE AS REQUEST_TIME, 
                    '2'  PRIORITY, 
                    'STLI15-' ||  TO_CHAR(SYSDATE, 'DD.MM.YYYY' ) AS REQUEST_ID, 
                    'All voice PKx subs should have a voicemail SOC. Adding VMMINI due to error in preactivation of PKx priceplans. On request by Beatrix Daryous Dietze and Staffan Lindberg (Using Ninja Batch Job). ' AS MEMO_TEXT
            FROM     IPL.VW_NINJA_SUB_TO_GET_VMMINI@OPPE10 S;

        CURSOR_ROW C3%ROWTYPE;
    
        BEGIN    
            FOR CURSOR_ROW IN C3 LOOP
                INSERT INTO MASTER_TRANSACTIONS
                            (TRANS_NUMBER, SUBSCRIBER_NO, SOC, ACTION_CODE, 
                            NEW_SOC, ENTER_TIME, REQUEST_TIME, PROCESS_TIME, 
                            PROCESS_STATUS, STATUS_DESC, DEALER_CODE, SALES_AGENT, 
                            PRIORITY, REQUEST_ID,MEMO_TEXT,
                            STREAM)
                VALUES         (NULL, CURSOR_ROW.SUBSCRIBER_NO,CURSOR_ROW.SOC, CURSOR_ROW.ACTION, 
                             NULL, NULL,CURSOR_ROW.REQUEST_TIME,NULL, 
                             'WAITING', NULL, NULL,NULL, 
                             CURSOR_ROW.PRIORITY, CURSOR_ROW.REQUEST_ID,CURSOR_ROW.MEMO_TEXT,
                             DECODE( MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4),10) + 1,
                                      NULL, 1,
                                     MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4), 10)+ 1
                                   )
                            );
                -- Commit work
                COMMIT;
          
            END LOOP;

        END ADD_VMMINI_SERVICE;        

    PROCEDURE ADD_MMS03_SERVICE IS
    
        CURSOR C4 IS
            SELECT  S.SUBSCRIBER_NO, 
                    'MMS03' SOC, 
                    'ADD'  ACTION, 
                    SYSDATE AS REQUEST_TIME, 
                    '2'  PRIORITY, 
                    'STLI15-' ||  TO_CHAR(SYSDATE, 'DD.MM.YYYY' ) AS REQUEST_ID, 
                    'All PKx subs should have MMS soc. Adding MMS03 SOC due to error in preactivation of PKx priceplans. On request by Beatrix Daryous Dietze and Staffan Lindberg (Using Ninja Batch Job). ' AS  MEMO_TEXT
            FROM    IPL.VW_NINJA_SUB_TO_GET_MMS03@OPPE10 S;

        CURSOR_ROW C4%ROWTYPE;
    
        BEGIN    
            FOR CURSOR_ROW IN C4 LOOP
                INSERT INTO MASTER_TRANSACTIONS
                            (TRANS_NUMBER, SUBSCRIBER_NO, SOC, ACTION_CODE, 
                            NEW_SOC, ENTER_TIME, REQUEST_TIME, PROCESS_TIME, 
                            PROCESS_STATUS, STATUS_DESC, DEALER_CODE, SALES_AGENT, 
                            PRIORITY, REQUEST_ID,MEMO_TEXT,
                            STREAM)
                VALUES         (NULL, CURSOR_ROW.SUBSCRIBER_NO,CURSOR_ROW.SOC, CURSOR_ROW.ACTION, 
                             NULL, NULL,CURSOR_ROW.REQUEST_TIME,NULL, 
                             'WAITING', NULL, NULL,NULL, 
                             CURSOR_ROW.PRIORITY, CURSOR_ROW.REQUEST_ID,CURSOR_ROW.MEMO_TEXT,
                             DECODE( MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4),10) + 1,
                                      NULL, 1,
                                     MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4), 10)+ 1
                                   )
                            );
                -- Commit work
                COMMIT;
          
            END LOOP;

    END ADD_MMS03_SERVICE;    
        
    PROCEDURE ADD_MMS04_SERVICE IS
    
        CURSOR C5 IS
            SELECT  S.SUBSCRIBER_NO, 
                    'MMS04'  SOC, 
                    'ADD'  ACTION, 
                    SYSDATE AS REQUEST_TIME, 
                    '2'   PRIORITY, 
                    'STLI15-' ||  TO_CHAR(SYSDATE, 'DD.MM.YYYY' ) AS REQUEST_ID, 
                    'All PKOP / PKOS subs should have MMS04 soc. Adding SOC due to error in preactivation of PKx priceplans. On request by Beatrix Daryous Dietze and Staffan Lindberg (Using Ninja Batch Job). ' AS  MEMO_TEXT
            FROM    IPL.VW_NINJA_SUB_TO_GET_MMS04@OPPE10 S;

        CURSOR_ROW C5%ROWTYPE;
    
        BEGIN    
            FOR CURSOR_ROW IN C5 LOOP
                INSERT INTO MASTER_TRANSACTIONS
                            (TRANS_NUMBER, SUBSCRIBER_NO, SOC, ACTION_CODE, 
                            NEW_SOC, ENTER_TIME, REQUEST_TIME, PROCESS_TIME, 
                            PROCESS_STATUS, STATUS_DESC, DEALER_CODE, SALES_AGENT, 
                            PRIORITY, REQUEST_ID,MEMO_TEXT,
                            STREAM)
                VALUES         (NULL, CURSOR_ROW.SUBSCRIBER_NO,CURSOR_ROW.SOC, CURSOR_ROW.ACTION, 
                             NULL, NULL,CURSOR_ROW.REQUEST_TIME,NULL, 
                             'WAITING', NULL, NULL,NULL, 
                             CURSOR_ROW.PRIORITY, CURSOR_ROW.REQUEST_ID,CURSOR_ROW.MEMO_TEXT,
                             DECODE( MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4),10) + 1,
                                      NULL, 1,
                                     MOD (SUBSTR (CURSOR_ROW.SUBSCRIBER_NO, 4), 10)+ 1
                                   )
                            );
                -- Commit work
                COMMIT;
          
            END LOOP;

    END ADD_MMS04_SERVICE;    
        
END POPULATE_PREPAID_SOCS;
/


-- End of DDL Script for Package Body NINJAMAIN.POPULATE_PREPAID_SOCS


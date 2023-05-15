DROP PACKAGE NINJA_UTILS;

CREATE OR REPLACE PACKAGE           ninja_utils
AS
   PROCEDURE validate_temporary_error (
      p_stack_trace   IN       VARCHAR2,
      x_result        OUT      NUMBER
   );
END ninja_utils;
 
/
DROP PACKAGE BODY NINJA_UTILS;

CREATE OR REPLACE PACKAGE BODY NINJA_UTILS
AS
   g_temporary_error   NUMBER := 1;
   g_regular_error     NUMBER := 0;

   PROCEDURE validate_temporary_error (
      p_stack_trace   IN       VARCHAR2,
      x_result        OUT      NUMBER
   )
   IS
      v_rowcount   NUMBER DEFAULT 0;
   BEGIN
      SELECT COUNT (*)
        INTO v_rowcount
        FROM DUAL
       WHERE p_stack_trace LIKE '%since last retrieve%'
          OR p_stack_trace LIKE '%BanInUseException%'
          OR p_stack_trace LIKE '%BAN%in use%'
          OR p_stack_trace LIKE '%try accessing account again later%'
          OR p_stack_trace LIKE '%Tuxedo server%is down%'
          OR p_stack_trace LIKE '%No Jolt connections available%'
          OR p_stack_trace LIKE '%ResourceDeadException%'
          OR p_stack_trace LIKE '%ResourceDisabledException%'
          OR p_stack_trace LIKE '%Attempting to assign Default Fokus User but encountered a null value%'
          OR p_stack_trace LIKE '%bea.jolt.JoltRemoteService%: Network Error%'
          OR p_stack_trace LIKE '%java.util.ConcurrentModificationException%SocRules%'
          OR p_stack_trace LIKE '%IllegalChargeException%future dates not allowed%BatchChargeAddition%'
          OR p_stack_trace LIKE '%ServiceException%No such service%'
          --OR p_stack_trace LIKE '%Requested Billing Account%does not exist%' -- Ninja error
          OR p_stack_trace LIKE '%CSMPL_RECORD_LOCKED%'
          OR p_stack_trace LIKE '%not connected to ORACLE%'
          OR p_stack_trace LIKE '%Unable to set activation ban%'
          OR p_stack_Trace LIKE '%Failed to open new transaction%because previous transaction is active%'
          OR p_stack_trace LIKE '%SIM is active on another CTN and hence Resume cannot%'
          --OR p_stack_trace LIKE '%%'
      ;

      IF v_rowcount > 0
      THEN
         x_result := g_temporary_error;
      ELSE
         x_result := g_regular_error;
      END IF;
   END validate_temporary_error;
END ninja_utils;
/

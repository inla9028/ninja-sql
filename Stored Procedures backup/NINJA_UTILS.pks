CREATE OR REPLACE PACKAGE NINJAMAIN.ninja_utils
AS
   PROCEDURE validate_temporary_error (
      p_stack_trace   IN       VARCHAR2,
      x_result        OUT      NUMBER
   );
END ninja_utils;
 
/
CREATE OR REPLACE PACKAGE NINJAMAIN."HGU_UTILS" 
AS
   PROCEDURE delete_old_data (l_delete_buffer_size NUMBER);
   PROCEDURE delete_old_data_from_table (l_delete_buffer_size NUMBER, v_table_name VARCHAR2);
END hgu_utils;
/
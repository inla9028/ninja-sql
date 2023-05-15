CREATE OR REPLACE PACKAGE BODY NINJAMAIN."HGU_UTILS" 
AS
   
   PROCEDURE delete_old_data (l_delete_buffer_size NUMBER)
    IS
        TYPE tt_delete IS TABLE OF ROWID;

        t_delete  tt_delete;
        totalwork NUMBER := 0;
        sofar     NUMBER := 0;

        CURSOR c_delete
        IS
            SELECT id FROM ninjamain.tmp_rowid_list; -- The table containing the rowid's

        l_delete_buffer   PLS_INTEGER  := 5000;
        --v_table_to_delete VARCHAR2(30) := 'ninjadata.dsp_request'; -- The table to clean
        v_table_to_delete VARCHAR2(30) := 'ninjadata.master_transactions'; -- The table to clean
    BEGIN
    
        IF l_delete_buffer_size IS NOT NULL AND l_delete_buffer_size BETWEEN 1000 AND 10000
        THEN
            l_delete_buffer := l_delete_buffer_size;
        END IF;

        SELECT COUNT (1) INTO totalwork FROM ninjamain.tmp_rowid_list; -- The table containing the rowid's

        OPEN c_delete;

        LOOP
            FETCH c_delete
              BULK COLLECT INTO t_delete
            LIMIT l_delete_buffer;

            BEGIN
                FORALL i IN 1 .. t_delete.COUNT
                    EXECUTE IMMEDIATE   '   DELETE FROM  ' || v_table_to_delete || '  WHERE ROWID =:1 '
                        USING t_delete (i);
            EXCEPTION
                WHEN OTHERS
                THEN
                    NULL;
            END;

            EXIT WHEN c_delete%NOTFOUND;
            COMMIT;
            sofar := sofar + t_delete.COUNT;
            dbms_output.put_line('Deleted ' || sofar || '/' || t_delete.COUNT || ' (' || TO_CHAR(100 * sofar / t_delete.COUNT, '00') || '%)'); 
        END LOOP;

        CLOSE c_delete;

        COMMIT;
    END;
    
    PROCEDURE delete_old_data_from_table (l_delete_buffer_size NUMBER, v_table_name VARCHAR2)
    IS
        TYPE tt_delete IS TABLE OF ROWID;

        t_delete  tt_delete;
        totalwork NUMBER := 0;
        sofar     NUMBER := 0;

        CURSOR c_delete
        IS
            SELECT id FROM ninjamain.tmp_rowid_list; -- The table containing the rowid's

        l_delete_buffer   PLS_INTEGER  := 5000;
        --v_table_to_delete VARCHAR2(30) := 'ninjadata.dsp_request'; -- The table to clean
        v_table_to_delete VARCHAR2(30) := 'ninjadata.master_transactions'; -- The table to clean
    BEGIN
    
        IF l_delete_buffer_size IS NOT NULL AND l_delete_buffer_size BETWEEN 1000 AND 10000
        THEN
            l_delete_buffer := l_delete_buffer_size;
        END IF;
        
        IF v_table_name IS NOT NULL AND LENGTH(v_table_name) BETWEEN 1 AND 30
        THEN
            v_table_to_delete := v_table_name;
        END IF;

        SELECT COUNT (1) INTO totalwork FROM ninjamain.tmp_rowid_list; -- The table containing the rowid's

        OPEN c_delete;

        LOOP
            FETCH c_delete
              BULK COLLECT INTO t_delete
            LIMIT l_delete_buffer;

            BEGIN
                FORALL i IN 1 .. t_delete.COUNT
                    EXECUTE IMMEDIATE   '   DELETE FROM  ' || v_table_to_delete || '  WHERE ROWID =:1 '
                        USING t_delete (i);
            EXCEPTION
                WHEN OTHERS
                THEN
                    NULL;
            END;

            EXIT WHEN c_delete%NOTFOUND;
            COMMIT;
            sofar := sofar + t_delete.COUNT;
            dbms_output.put_line('Deleted ' || sofar || '/' || t_delete.COUNT || ' (' || TO_CHAR(100 * sofar / t_delete.COUNT, '00') || '%)'); 
        END LOOP;

        CLOSE c_delete;

        COMMIT;
    END;

END hgu_utils;
/
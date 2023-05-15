SELECT A.*
  FROM hgu_tmp_subs A
;

--DELETE
--  FROM hgu_tmp_subs
--;


--DELETE
--  FROM hgu_tmp_ban_sub_etc
--;

SELECT A.*
  FROM hgu_tmp_ban_sub_etc A
 WHERE 1 = 1
--   AND A.customer_telno IS NULL
   AND ROWNUM < 21
;

INSERT INTO hgu_tmp_ban_sub_etc (ban, subscriber_no, link_type)
WITH my_filter AS (SELECT A.param1 AS "TPID"
                     FROM hgu_tmp_subs A
                    WHERE A.param1 IS NOT NULL)
SELECT /*+ driving_site(anl)*/
       anl.ban, anl.subscriber_no, anl.link_type
  FROM address_name_link@fokus anl
     , name_data@fokus         nd
     , my_filter               mf
 WHERE nd.tpid       = mf.tpid
   AND anl.name_id   = nd.name_id
   AND SYSDATE BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

-- Delete/Clear any "0000000000" subscriber no's.
UPDATE hgu_tmp_ban_sub_etc A
   SET A.subscriber_no = NULL
 WHERE A.subscriber_no = '0000000000'
;

UPDATE hgu_tmp_ban_sub_etc A
   SET A.customer_telno = (SELECT /*+ driving_site(ba)*/ ba.ban_status
                             FROM billing_account@fokus ba
                            WHERE ba.ban = A.ban)
 WHERE A.subscriber_no IS NULL
;

UPDATE hgu_tmp_ban_sub_etc A
   SET A.customer_telno = (SELECT /*+ driving_site(s)*/ s.sub_status
                             FROM subscriber@fokus s
                            WHERE s.subscriber_no = A.subscriber_no
                              AND s.customer_id   = A.ban)
 WHERE A.subscriber_no IS NOT NULL
;


SELECT a.link_type, a.customer_telno AS "STATUS", COUNT(1) AS "COUNT"
  FROM hgu_tmp_ban_sub_etc A
GROUP BY A.link_type, a.customer_telno
ORDER BY 1, 2
;

SELECT decode(b.link_type
            , 'B', 'IR'
            , 'L', 'LO'
            , 'U', 'PU'
            , b.link_type) AS "ROLE"
     , decode(b.status
            , 'N', 'Cancelled'
            , 'O', 'Active'
            , 'S', 'Suspended'
            , 'C', 'Closed'
            , 'R', 'Reserved'
            , 'T', 'Tentative'
            , 'A', 'Active'
            , b.status) AS "STATUS"
     , b.count
  FROM (SELECT A.link_type, A.customer_telno AS "STATUS", count(1) AS "COUNT"
          FROM hgu_tmp_ban_sub_etc A
        GROUP BY A.link_type, A.customer_telno
        ORDER BY 1, 2) b
ORDER BY 1,2
;


WITH my_filter AS (SELECT h.* FROM hgu_tmp_ban_sub_etc h)
SELECT /*+ driving_site(anl)*/
       /*+ parallel(anl, 6 )*/
       /*+ parallel(nd,  6 )*/
       /*+ parallel(ba,  6 )*/
       UNIQUE mf.ban
     , ba.account_type
     , RTRIM(ba.account_sub_type) AS "ACCOUNT_SUB_TYPE"
     , mf.subscriber_no
     , decode(mf.link_type
            , 'B', 'IR'
            , 'L', 'LO'
            , 'U', 'PU'
            , mf.link_type)      AS "ROLE"
     , decode(mf.customer_telno
            , 'N', 'Cancelled'
            , 'O', 'Active'
            , 'S', 'Suspended'
            , 'C', 'Closed'
            , 'R', 'Reserved'
            , 'T', 'Tentative'
            , 'A', 'Active'
            , mf.customer_telno) AS "STATUS"
     , nd.tpid
     , nd.comp_reg_id            AS "DSF_PID"
  FROM my_filter               mf
     , address_name_link@fokus anl
     , name_data@fokus         nd
     , billing_account@fokus   ba
 WHERE anl.ban           = mf.ban
   AND anl.subscriber_no = nvl(mf.subscriber_no, '0000000000')
   AND anl.link_type     = mf.link_type
   AND SYSDATE     BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id       = nd.name_id
   AND ba.ban            = mf.ban
ORDER BY 1, 4, 5
;


SELECT UNIQUE
       x.ban
     , x.account_type
     , x.account_sub_type
     , x.subscriber_no
     , (listagg(x.ROLE, ', ') WITHIN GROUP (ORDER BY x.ROLE)) AS "ROLES"
     , x.status
     , x.tpid
     , x.dsf_pid
  FROM (WITH my_filter AS (SELECT h.* FROM hgu_tmp_ban_sub_etc h)
        SELECT /*+ driving_site(anl)*/
               /*+ parallel(anl, 6 )*/
               /*+ parallel(nd,  6 )*/
               /*+ parallel(ba,  6 )*/
               UNIQUE mf.ban
             , ba.account_type
             , RTRIM(ba.account_sub_type) AS "ACCOUNT_SUB_TYPE"
             , mf.subscriber_no
             , decode(mf.link_type
                    , 'B', 'IR'
                    , 'L', 'LO'
                    , 'U', 'PU'
                    , mf.link_type)      AS "ROLE"
             , decode(mf.customer_telno
                    , 'N', 'Cancelled'
                    , 'O', 'Active'
                    , 'S', 'Suspended'
                    , 'C', 'Closed'
                    , 'R', 'Reserved'
                    , 'T', 'Tentative'
                    , 'A', 'Active'
                    , mf.customer_telno) AS "STATUS"
             , nd.tpid
             , nd.comp_reg_id            AS "DSF_PID"
          FROM my_filter               mf
             , address_name_link@fokus anl
             , name_data@fokus         nd
             , billing_account@fokus   ba
         WHERE anl.ban           = mf.ban
           AND anl.subscriber_no = nvl(mf.subscriber_no, '0000000000')
           AND anl.link_type     = mf.link_type
           AND SYSDATE     BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
           AND anl.name_id       = nd.name_id
           AND ba.ban            = mf.ban
        ORDER BY 1, 4, 5) x
ORDER BY 1,4,5
;

---

desc hgu_tmp_ban_sub_etc_etc
;

SELECT A.*
  FROM hgu_tmp_ban_sub_etc_etc A
 WHERE (A.ROLE = 'PU' 
     or a.roles like '%,%')
   and rownum < 21
;

UPDATE hgu_tmp_ban_sub_etc_etc A
   SET A.ROLES = (SELECT listagg(b.role, ',') WITHIN GROUP (ORDER BY b.role)
                     FROM hgu_tmp_ban_sub_etc_etc b
                    WHERE b.tpid = A.tpid
                      and b.ban  = a.ban)
;

UPDATE hgu_tmp_ban_sub_etc_etc A
   SET A.ROLES = (SELECT replace(b.roles, 'PU,PU', 'PU')
                     FROM hgu_tmp_ban_sub_etc_etc b
                    WHERE b.tpid = A.tpid
                      AND b.ban  = A.ban
                      and b.subscriber_no = A.subscriber_no)
 WHERE A.ROLES LIKE '%PU,PU'
;

--ALTER TABLE hgu_tmp_ban_sub_etc_etc
--  MODIFY (roles      VARCHAR2(200 CHAR))
--/



SELECT ban, account_type, account_sub_type, subscriber_no, ROLES, status, tpid, pid
  FROM hgu_tmp_ban_sub_etc_etc
 WHERE (ROLE = 'PU' 
     OR ROLES LIKE '%,%')
ORDER BY 1,4,5
;


SELECT ban, account_type, account_sub_type, subscriber_no, ROLES, status, tpid, pid
  FROM hgu_tmp_ban_sub_etc_etc
 WHERE subscriber_no IS NOT NULL
ORDER BY ban, tpid, ROLES, subscriber_no
;
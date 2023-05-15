select "DONOR", "TO", action, "NP_DATE", status, count(1) AS "COUNT"
  from (select DECODE(a.donor_code, '815', 'Telia', 'SP')     AS "DONOR"
             , DECODE(a.recipient_code, '815', 'Telia', 'SP') AS "TO"
             , a.action
             , TO_CHAR(a.date_time_port, 'YYYY-MM-DD')        AS "NP_DATE"
             , a.status
          from ninja_time_port a
         where a.date_time_port BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE + 7)
           and a.action IN ( 'CONF', 'MOVE', 'NEW' )
           and a.status NOT IN ( 'EXPIRED' ) )
group by "DONOR", "TO", action, "NP_DATE", status
order by 4,3,1,2
;


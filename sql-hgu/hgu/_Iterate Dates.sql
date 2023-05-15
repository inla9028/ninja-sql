SELECT TRUNC(SYSDATE) + 1 - LEVEL AS today,
       TRUNC(SYSDATE) + 2 - LEVEL AS tomorrow
FROM DUAL
CONNECT BY LEVEL <= 365
;
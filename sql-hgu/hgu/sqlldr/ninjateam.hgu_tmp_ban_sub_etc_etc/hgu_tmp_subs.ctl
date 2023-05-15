load data
CHARACTERSET UTF8
into table hgu_tmp_ban_sub_etc_etc
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
BAN,
ACCOUNT_TYPE,
ACCOUNT_SUB_TYPE,
SUBSCRIBER_NO,
ROLE,
ROLES,
STATUS,
TPID,
PID
)

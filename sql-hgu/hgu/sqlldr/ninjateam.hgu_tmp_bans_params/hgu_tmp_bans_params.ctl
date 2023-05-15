load data
CHARACTERSET UTF8
into table hgu_tmp_bans_params
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 ban,
 param1,
 param2,
 param3,
 param4,
 param5,
 param6,
 param7,
 param8,
 param9
)

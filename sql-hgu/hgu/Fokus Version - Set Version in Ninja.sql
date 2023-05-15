/*
** Check before
*/
select sd.*
  from system_defaults sd
 where sd.key = 'NINJA_FOKUS_VERSION'
;

/*
** Update
*/
update system_defaults sd
   set sd.value = '36.1.0.0'
 where sd.key = 'NINJA_FOKUS_VERSION'
;

/*
** Check after
*/
select sd.*
  from system_defaults sd
 where sd.key = 'NINJA_FOKUS_VERSION'
;

/*
** Commit
*/
commit work
;
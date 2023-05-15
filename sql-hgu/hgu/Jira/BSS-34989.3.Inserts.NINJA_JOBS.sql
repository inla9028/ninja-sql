select nj.machine_id, count(1) as "COUNT"
  from ninja_jobs nj
 where nj.job_status != 'STOPPED'
group by nj.machine_id
order by nj.machine_id
;
--> NINJAP1Z_DEMON	61
--> NINJAP2Z_DEMON	50

INSERT INTO ninja_jobs            VALUES ('NINJAP2Z_DEMON',44, 'STOPPED', 'N', 60000, SYSDATE, SYSDATE, NULL, 'batchBanLevelSocs', 'Process BAN-level SOCs', 'N', NULL);
INSERT INTO ninja_jobs_parameters VALUES ('NINJAP2Z_DEMON',44, 1, 'NinjaInternal', 'Weblogic User Parameter');

select nj.*
  from ninja_jobs nj
 where nj.machine_id = 'NINJAP2Z_DEMON'
   and nj.job_id     = 44
order by 1, 2
;

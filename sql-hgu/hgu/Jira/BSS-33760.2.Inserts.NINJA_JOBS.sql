select nj.*
  from ninja_jobs nj
 where nj.machine_id = 'NINJAAT2_SH1'
   and nj.exec_method like 'batchDsp%'
order by 1, 2
;

select nj.machine_id, count(1) as "COUNT"
  from ninja_jobs nj
 where nj.job_status != 'STOPPED'
group by nj.machine_id
order by nj.machine_id
;
--> NINJAP1Z_DEMON	61
--> NINJAP2Z_DEMON	49

INSERT INTO ninja_jobs            VALUES ('NINJAAT2_SH1',42, 'STOPPED', 'N', 60000, SYSDATE, SYSDATE, NULL, 'batchDspExtract', 'Extract private legal customers without COMP_REG_ID', 'N', NULL);
INSERT INTO ninja_jobs_parameters VALUES ('NINJAAT2_SH1',42, 1, 'NinjaInternal', 'Weblogic User Parameter');

INSERT INTO ninja_jobs            VALUES ('NINJAAT2_SH1',43, 'STOPPED', 'N', 60000, SYSDATE, SYSDATE, NULL, 'batchDspUpdate',  'Update private legal customers with COMP_REG_ID ++',  'N', NULL);
INSERT INTO ninja_jobs_parameters VALUES ('NINJAAT2_SH1',43, 1, 'NinjaInternal', 'Weblogic User Parameter');

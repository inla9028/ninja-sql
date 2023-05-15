--==
--== (1) Sjekke om demon-master prosessene kj�rer (ingen linjer = de kj�rer ikke)
--==
SELECT * FROM ninjaconfig.ninja_jobs a
  WHERE a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
    AND a.job_id      = 0
    AND a.job_status NOT IN ('STOPPING', 'STOPPED');


--==
--== F�lgende script kj�res i en og samme foresp�rsel
--==

--==
--== (2) Oppdatere statusen for de jobber som IKKE KJ�RER for �yenblikket
--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.was_running = 'N'
  WHERE a.job_status IN ('STOPPING', 'STOPPED')
    AND a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON');

COMMIT WORK;

--==
--== (3) Oppdatere statusen for de jobber som KJ�RER for �yenblikket
--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.was_running = 'Y'
  WHERE a.job_status NOT IN ('STOPPING', 'STOPPED')
    AND a.machine_id     IN ('NINJAP1_DEMON', 'NINJAP2_DEMON');

COMMIT WORK;

--==
--== (4) Stoppe alle demon-master prosessene, etterp� vil alle andre batch-
--==     jobber automagisk stoppe n�r de er ferdige med sine oppgaver.
--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status  = 'STOPPING',
      a.status_desc = 'Stopped manually by Rolf Henning & Co',
      a.status_time = SYSDATE
  WHERE a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
    AND a.job_id      = 0;

COMMIT WORK;

--==
--== (5) Sjekke at alle prosesser stopper...
--==
SELECT * FROM ninjaconfig.ninja_jobs a
  WHERE a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
    AND a.job_status IN ('SLEEPING', 'RUNNING');

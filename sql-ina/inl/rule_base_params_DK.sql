INSERT INTO rule_base_params 
VALUES('PR10','A','A','TMD','Port In','10,001,0-10,002,110-10,004,120-10,004,410-10,009,600-10,010,800@',NULL);
INSERT INTO rule_base_params 
VALUES('PR20','A','A','TMD','Port Out','20,001,20-20,001,30-20,009,600-20,017,610@',NULL);
INSERT INTO rule_base_params 
VALUES('PR90','A','A','TMD','Port In with cancel','10,001,0-10,002,110-10,004,120-90,007,860@',NULL);
INSERT INTO rule_base_params 
VALUES('PR70','A','A','TMD','Port In with reject','10,001,0-10,002,110-70,006,850@',NULL);
INSERT INTO rule_base_params 
VALUES('PR80','A','A','TMD','Port out with reject','20,001,20-80,006,840@',NULL);
INSERT INTO rule_base_params 
VALUES('PR100','A','A','TMD','Port Out with cancel','20,001,20-20,001,30-100,007,870@',NULL);
INSERT INTO rule_base_params 
VALUES('PR30','A','A','TMD','NP Change (from Telia)','30,017,0-30,017,110-30,017,600-30,017,800@',NULL);
INSERT INTO rule_base_params 
VALUES('PR40','A','A','TMD','Np Change\Termination In (External)','40,009,600@',NULL);
INSERT INTO rule_base_params 
VALUES('PR60','A','A','TMD','Termination Out','60,012,0-60,002,110-60,009,600-60,010,800@',NULL);
INSERT INTO rule_base_params 
VALUES('PR110','A','A','TMD','Internal Porting between Networks','10,001,0-10,002,110-20,001,20-20,001,30-10,004,120-10,004,410-20,009,600-20,010,610-10,010,800@',NULL);
INSERT INTO rule_base_params 
VALUES('PR120','A','A','TMD','Internal Porting between Networks-reject','10,001,0-10,002,110-20,001,20-20,001,840-70,006,850@',NULL);
INSERT INTO rule_base_params 
VALUES('PR130','A','A','TMD','Internal Porting between Networks-cancel','10,001,0-10,002,110-20,001,20-20,001,30-10,004,120-10,004,860-100,007,870@',NULL);

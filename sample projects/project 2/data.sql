insert into DEPARTMENT values (1,'Computer Sciences','West Lafayette');
insert into DEPARTMENT values (2,'Management','West Lafayette');
insert into DEPARTMENT values (3,'Medical Education','Purdue Calumet');
insert into DEPARTMENT values (4,'Education','Purdue North Central');
insert into DEPARTMENT values (5,'Pharmacal Sciences','Indianapolis');

insert into STUDENT values (0418,'S.Jack',1,'SO',19);
insert into STUDENT values (0671,'A.Smith',2,'FR',20);
insert into STUDENT values (1234,'T.Banks',3,'SR',18);
insert into STUDENT values (3726,'M.Lee',5,'SO',20);
insert into STUDENT values (4829,'J.Bale',3,'JR',22);
insert into STUDENT values (5765,'L.Lim',1,'SR',19);
insert into STUDENT values (0019,'D.Sharon',2,'FR',20);
insert into STUDENT values (7357,'G.Johnson',1,'JR',19);
insert into STUDENT values (8016,'E.Cho',5,'JR',22);


insert into FACULTY values (101,'S.Layton',1);
insert into FACULTY values (102,'B.Jungles',2);
insert into FACULTY values (103,'N.Guzaldo',5);
insert into FACULTY values (104,'S.Boling',4);
insert into FACULTY values (105,'G.Mason',1);
insert into FACULTY values (106,'S.Zwink',2);
insert into FACULTY values (107,'Y.Walton',5);
insert into FACULTY values (108,'I.Teach',5);
insert into FACULTY values (109,'C.Jason',5);

insert into class values ('ENG400',to_timestamp('08:30','HH:MI'),'U003',104);
insert into class values ('ENG320', to_timestamp('09:30','HH:MI'),'R128',104);
insert into class values ('COM100', to_timestamp('11:30','HH:MI'),'L108',104);
insert into class values ('ME308', to_timestamp('10:30','HH:MI'),'R128',102);
insert into class values ('CS448', to_timestamp('09:30','HH:MI'),'R128',101);
insert into class values ('HIS210', to_timestamp('01:30','HH:MI'),'L108',104);
insert into class values ('MATH275', to_timestamp('02:30','HH:MI'),'L108',105);
insert into class values ('STAT110', to_timestamp('04:30','HH:MI'),'R128',105);
insert into CLASS values ('PHYS100', to_timestamp('04:30','HH:MI'),'U003',101);

insert into ENROLLED values (0418,'CS448');
insert into ENROLLED values (0418,'MATH275');
insert into ENROLLED values (1234,'ENG400');
insert into ENROLLED values (8016,'ENG400');
insert into ENROLLED values (8016,'ENG320');
insert into ENROLLED values (8016,'HIS210');
insert into ENROLLED values (8016,'STAT110');
insert into ENROLLED values (0418,'STAT110');
insert into ENROLLED values (1234,'COM100');
insert into ENROLLED values (0671,'ENG400');
insert into ENROLLED values (1234,'HIS210');
insert into ENROLLED values (5765,'PHYS100');
insert into ENROLLED values (5765,'ENG320');

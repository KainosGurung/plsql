CREATE TABLE student
  (
    snum   NUMBER PRIMARY KEY,
    sname  VARCHAR2(30),
    deptid NUMBER,
    slevel VARCHAR2(30),
    age    NUMBER
  );
CREATE TABLE CLASS
  (
    cname    VARCHAR2(30) primary key,
    meets_at DATE,
    room     VARCHAR2(30),
    fid      NUMBER
  );
CREATE TABLE enrolled
  ( 
    snum NUMBER,
    cname VARCHAR2(30),
    ADD CONSTRAINT fk_snum FOREIGN KEY (snum) REFERENCES student(snum),
     ADD CONSTRAINT fk_cname FOREIGN KEY (cname) REFERENCES "class"(cname)
    
  ) ;
CREATE TABLE faculty
  (
    fid    NUMBER PRIMARY KEY,
    fname  VARCHAR2(30),
    deptid NUMBER
  ) ;
CREATE TABLE DEPARTMENT
  (
    deptid   NUMBER primary key,
    dname    VARCHAR2(30),
    LOCATION VARCHAR2(30)
  ) ; 
  
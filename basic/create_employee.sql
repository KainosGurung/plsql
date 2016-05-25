CREATE TABLE employee(
  ID NUMBER PRIMARY KEY,
  fname VARCHAR2(30),
  lname VARCHAR2(30),
  age NUMBER CHECK (age >= 21),
  sex VARCHAR2(10),
  email VARCHAR2(100),
  address VARCHAR2(50)  
);
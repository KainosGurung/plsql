drop table book;
CREATE TABLE book (
bookid NUMBER,
title VARCHAR2(50),
pages number);

INSERT INTO book VALUES (475, 'The old and the gray', 127);
INSERT INTO book VALUES (573, 'As I walk through the valley', 422);
INSERT INTO book VALUES (860, 'For whom it may concern', 195);

drop table sales;
CREATE TABLE sales (
ID NUMBER,
bookid NUMBER,
locationid NUMBER,
dateid NUMBER,
pitches number,
sales NUMBER
);

INSERT INTO sales VALUES(1, 475, 1732, 989, 5, 18);
INSERT INTO sales VALUES(2, 475, 1732, 990, 2, 24);
INSERT INTO sales VALUES(3, 573, 1990, 989, 0, 45);
INSERT INTO sales VALUES(4, 860, 1990, 989, 12, 4);
insert into sales values(5, 860, 1990, 990, 11, 9);

drop table "LOCATION";
CREATE TABLE "LOCATION" (
locationid NUMBER,
city VARCHAR2(50),
state VARCHAR2(10),
zip number
);

INSERT INTO "LOCATION" VALUES(1732, 'Albany', 'NY', 12203);
INSERT INTO "LOCATION" VALUES(1990, 'Windsor', 'CT', 06095);

drop table "DATE";
CREATE TABLE "DATE" (
dateid NUMBER,
day number,
MONTH NUMBER,
year number
);
INSERT INTO "DATE" VALUES(989, 3, 12, 2011);
INSERT INTO "DATE" VALUES(990, 4, 12, 2011);
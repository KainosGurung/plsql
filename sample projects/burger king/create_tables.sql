drop table bk_locations_clean;
create table bk_locations_clean(
longitude	NUMBER,
latitude	NUMBER,
street_address VARCHAR2(200 BYTE),
city VARCHAR2(200 BYTE),
state VARCHAR2(200 BYTE),
zip NUMBER,
phone VARCHAR2(200 BYTE)
);

drop table bk_locations_unresolved;
CREATE TABLE bk_locations_unresolved(
longitude	NUMBER,
LATITUDE	NUMBER,
NAME	VARCHAR2(200 BYTE),
address	VARCHAR2(200 BYTE),
problem_desc VARCHAR2(200 BYTE)
);

DROP TABLE zip_db;

CREATE TABLE zip_db(
zip number,
city VARCHAR2(30),
state VARCHAR2(5),
latitude NUMBER,
longitude NUMBER,
timezone NUMBER,
dst number
);
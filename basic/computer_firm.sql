--  CREATE TABLE "ADMIN"."PRODUCT" 
--   (	"MAKER" VARCHAR2(10 BYTE), 
--	"MODEL" NUMBER(5,0), 
--	"TYPE" VARCHAR2(10 BYTE)
--   );
--
--Data for Product table
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('B',1121,'PC');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('A',1232,'PC');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('A',1233,'PC');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('E',1260,'PC');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('A',1276,'Printer');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('D',1288,'Printer');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('A',1298,'Laptop');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('C',1321,'Laptop');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('A',1401,'Printer');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('A',1408,'Printer');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('D',1433,'Printer');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('E',1434,'Printer');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('B',1750,'Laptop');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('A',1752,'Laptop');
--Insert into PRODUCT (MAKER,MODEL,TYPE) values ('E',2112,'PC');
--INSERT INTO product (maker,MODEL,TYPE) VALUES ('E',2113,'PC');
--
--
--
--  CREATE TABLE "ADMIN"."PC" 
--   (	"CODE" NUMBER, 
--	"MODEL" NUMBER, 
--	"SPEED" NUMBER, 
--	"RAM" NUMBER, 
--	"HD" NUMBER, 
--  "CD" VARCHAR2(10 BYTE), 
--	"PRICE" NUMBER
--   );
--
--Data for PC table
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (9,1232,450,32,10,'24x',350);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (10,1260,500,32,10,'12x',350);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (7,1232,500,32,10,'12x',400);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (1,1232,500,64,5,'12x',600);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (3,1233,500,64,5,'12x',600);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (8,1232,450,64,8,'24x',350);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (4,1121,600,128,14,'40x',850);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (5,1121,600,128,8,'40x',850);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (6,1233,750,128,20,'50x',950);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (11,1233,900,128,40,'40x',980);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (12,1233,800,128,20,'50x',970);
--Insert into PC (CODE,MODEL,SPEED,RAM,HD,CD,PRICE) values (2,1121,750,128,14,'40x',850);
--
--
--
--  CREATE TABLE "ADMIN"."PRINTER" 
--   (	"CODE" NUMBER, 
--	"MODEL" NUMBER, 
--	"COLOR" VARCHAR2(1 BYTE), 
--	"TYPE" VARCHAR2(10 BYTE), 
--	"PRICE" NUMBER
--   );
--
--Data for Printer table
--Insert into PRINTER (CODE,MODEL,COLOR,TYPE,PRICE) values (1,1276,'n','Laser',400);
--Insert into PRINTER (CODE,MODEL,COLOR,TYPE,PRICE) values (2,1433,'y','Jet',270);
--Insert into PRINTER (CODE,MODEL,COLOR,TYPE,PRICE) values (3,1434,'y','Jet',290);
--Insert into PRINTER (CODE,MODEL,COLOR,TYPE,PRICE) values (4,1401,'n','Matrix',150);
--INSERT INTO printer (code,MODEL,color,TYPE,price) VALUES (5,1408,'n','Matrix',270);
--Insert into PRINTER (CODE,MODEL,COLOR,TYPE,PRICE) values (6,1288,'n','Laser',400);
--
--
--
--  CREATE TABLE "ADMIN"."LAPTOP" 
--   (	"CODE" NUMBER, 
--	"MODEL" NUMBER, 
--	"SPEED" NUMBER, 
--	"RAM" NUMBER, 
--	"HD" NUMBER, 
--	"PRICE" NUMBER, 
--	"SCREEN" NUMBER
--   ); 
--
--Data for Laptop table
--Insert into LAPTOP (CODE,MODEL,SPEED,RAM,HD,PRICE,SCREEN) values (1,1298,350,32,4,700,11);
--Insert into LAPTOP (CODE,MODEL,SPEED,RAM,HD,PRICE,SCREEN) values (2,1321,500,64,8,970,12);
--Insert into LAPTOP (CODE,MODEL,SPEED,RAM,HD,PRICE,SCREEN) values (3,1750,750,128,12,1200,14);
--Insert into LAPTOP (CODE,MODEL,SPEED,RAM,HD,PRICE,SCREEN) values (4,1298,600,64,10,1050,15);
--INSERT INTO laptop (code,MODEL,speed,ram,hd,price,screen) VALUES (5,1752,750,128,10,1150,14);
--Insert into LAPTOP (CODE,MODEL,SPEED,RAM,HD,PRICE,SCREEN) values (6,1298,450,64,10,950,12);

--====================================BEGIN QUERIES=========================================
--====================================BEGIN QUERIES=========================================

--Find the model number, speed and hard drive capacity for all the PCs with prices below $500. Result set: model, speed, hd.
SELECT model, speed, hd FROM pc WHERE price < 500;

-------------------------------------------------------------
--List all printer makers. Result set: maker.
SELECT DISTINCT maker FROM product WHERE type = 'printer';

-------------------------------------------------------------
--Find the model number, RAM and screen size of the laptops with prices over $1000.
SELECT model, ram, screen FROM laptop WHERE price > 1000;

-------------------------------------------------------------
--Find all records FROM the Printer table containing data about color printers.
SELECT * FROM printer WHERE color = 'y';

-------------------------------------------------------------
--Find the model number, speed and hard drive capacity of PCs cheaper than $600 HAVING a 12x or a 24x CD drive.
SELECT model, speed, hd FROM pc WHERE price < 600 AND (cd='12x' OR cd='24x');

-------------------------------------------------------------
--For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.
SELECT DISTINCT Product.maker,
  Laptop.speed
FROM Product
INNER JOIN Laptop
ON product.model = laptop.model
WHERE Laptop.hd >= 10;

--------------------------------------------------------------
--Find out the models and prices for all the products (of any type) produced by maker B.
SELECT product.model,
  pc.price
FROM product
INNER JOIN pc
ON product.model    = pc.model
WHERE product.maker = 'B'
UNION
SELECT product.model,
  laptop.price
FROM product
INNER JOIN laptop
ON product.model    = laptop.model
WHERE product.maker = 'B'
UNION
SELECT product.model,
  Printer.price
FROM product
INNER JOIN Printer
ON product.model    = Printer.model
WHERE product.maker = 'B';

-------------------------------------------------------------
--Find the makers producing PCs but not laptops.
SELECT DISTINCT maker FROM product WHERE type = 'PC'
MINUS
SELECT DISTINCT maker FROM product WHERE type = 'Laptop';

-------------------------------------------------------------
--Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.
SELECT DISTINCT product.maker
FROM product
INNER JOIN pc
ON product.model = pc.model
WHERE speed  >= 450;

-------------------------------------------------------------
--Find the printer models HAVING the highest price. Result set: model, price.
SELECT model,
  price
FROM printer
WHERE price =
  (SELECT MAX(price) AS price FROM printer
  );

-------------------------------------------------------------
--Find out the average speed of PCs.
SELECT AVG(speed) FROM pc;

-------------------------------------------------------------
--Find out the average speed of the laptops priced over $1000.
SELECT AVG(speed) FROM laptop WHERE price > 1000;

-------------------------------------------------------------
--Find out the average speed of the PCs produced by maker A.
SELECT AVG(speed)
FROM pc
WHERE model IN
  (SELECT model FROM product WHERE maker = 'A' AND type = 'PC'
  );

-------------------------------------------------------------
--Get the makers who produce only one product type and more than one model. Output: maker, type.
SELECT maker,
  MAX(type) AS type
FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1
AND COUNT(model)            > 1;

-------------------------------------------------------------
--Get hard drive capacities that are identical for two or more PCs. Result set: hd.
SELECT hd FROM pc GROUP BY hd HAVING COUNT(hd) >= 2;

-------------------------------------------------------------
--Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i).  Result set: model with the bigger number, model with the smaller number, speed, and RAM.
SELECT b.model,
  a.model,
  a.speed,
  a.ram
FROM pc a,
  pc b
WHERE a.speed = b.speed
AND a.ram     = b.ram
AND a.model  != b.model
GROUP BY b.model,
  a.model,
  a.speed,
  a.ram
HAVING a.model < b.model;

-------------------------------------------------------------
--Get the laptop models that have a speed smaller than the speed of any PC. result SET: TYPE, MODEL, speed.
SELECT DISTINCT b.type,
  b.model,
  a.speed
FROM laptop a
INNER JOIN product b
ON a.model    = b.model
WHERE a.speed < ALL
  (SELECT speed FROM pc
  )
AND b.type = 'Laptop';

-------------------------------------------------------------
--Find the makers of the cheapest color printers. Result set: maker, price.
SELECT DISTINCT A.maker,
  b.price
FROM product A
INNER JOIN printer b
ON A.MODEL    = b.MODEL
WHERE b.price =
  (SELECT MIN(price) FROM printer WHERE color = 'y'
  )
AND b.color = 'y';

-------------------------------------------------------------
--For each maker having models in the Laptop table, find out the average screen size of the laptops he produces. Result set: maker, average screen size.
SELECT maker,
  AVG(screen)
FROM
  (SELECT A.maker AS maker,
    b.screen      AS screen
  FROM product A
  INNER JOIN laptop b
  ON A.MODEL = b.MODEL
  )
GROUP BY maker;

-------------------------------------------------------------
--Find the makers producing at least three distinct models of PCs. Result set: maker, number of PC models.
SELECT maker,
  cnt
FROM
  (SELECT maker,
    COUNT(MODEL) AS cnt
  FROM
    ( SELECT DISTINCT maker, model FROM product WHERE type = 'PC'
    )
  GROUP BY maker
  )
WHERE cnt >= 3;

-------------------------------------------------------------
--Find out the maximum PC price for each maker having models in the PC table. Result set: maker, maximum price.
SELECT maker,
  MAX(price)
FROM
  ( SELECT DISTINCT a.maker AS maker,
    a.model,
    b.price AS price
  FROM product a
  INNER JOIN pc b
  ON a.model = b.model
  WHERE type = 'PC'
  )
GROUP BY maker;

-------------------------------------------------------------
--For each value of PC speed that exceeds 600 MHz, find out the average price of PCs with identical speeds. Result set: speed, average price.
SELECT speed,
  AVG(price)
FROM
  (SELECT speed, price FROM pc WHERE speed > 600
  )
GROUP BY speed;

-------------------------------------------------------------
--Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with a speed of 750 MHz or higher. Result set: maker
SELECT maker
FROM
  (SELECT maker,
    COUNT(maker) AS cnt
  FROM
    ( SELECT DISTINCT maker
    FROM product
    WHERE MODEL IN
      (SELECT DISTINCT MODEL FROM pc WHERE speed >= 750
      )
    UNION ALL
    SELECT DISTINCT maker
    FROM product
    WHERE MODEL IN
      (SELECT DISTINCT MODEL FROM laptop WHERE speed >= 750
      )
    )
  GROUP BY maker
  )
WHERE cnt >= 2;

-------------------------------------------------------------
--List the models of any type having the highest price of all products present in the database.

SELECT DISTINCT model
FROM
  (SELECT A.MODEL, b.price FROM product A INNER JOIN pc b ON A.MODEL = b.MODEL
  UNION ALL
  SELECT A.MODEL,
    b.price
  FROM product A
  INNER JOIN laptop b
  ON A.MODEL = b.MODEL
  UNION ALL
  SELECT A.MODEL,
    b.price
  FROM product A
  INNER JOIN printer b
  ON A.MODEL = b.MODEL
  )
WHERE price =
  (SELECT MAX(price)
  FROM
    ( SELECT A.MODEL, b.price FROM product A INNER JOIN pc b ON A.MODEL = b.MODEL
    UNION ALL
    SELECT A.MODEL,
      b.price
    FROM product A
    INNER JOIN laptop b
    ON A.MODEL = b.MODEL
    UNION ALL
    SELECT A.MODEL,
      b.price
    FROM product A
    INNER JOIN printer b
    ON A.MODEL = b.MODEL
    )
  );

-------------------------------------------------------------
--Find the printer makers also producing PCs with the lowest RAM capacity and the highest processor speed of all PCs having the lowest RAM capacity. Result set: maker.
SELECT DISTINCT maker
FROM product
WHERE MODEL IN
  (SELECT MODEL
  FROM pc
  WHERE speed =
    (SELECT MAX(speed) AS maxspeed
    FROM pc
    WHERE ram =
      (SELECT MIN(ram) AS minram FROM pc
      )
    )
  AND ram =
    (SELECT MIN(ram) AS minram FROM pc
    )
  )
AND maker IN
  ( SELECT DISTINCT maker FROM product WHERE type = 'Printer'
  );

-------------------------------------------------------------
--Find out the average price of PCs and laptops produced by maker A. Result set: one overall average price for all items.
SELECT AVG(price)
FROM
  (SELECT price
  FROM pc
  WHERE MODEL IN
    (SELECT MODEL FROM product WHERE maker = 'A' AND TYPE = 'PC'
    )
  UNION ALL
  SELECT price
  FROM laptop
  WHERE MODEL IN
    (SELECT MODEL FROM product WHERE maker = 'A' AND TYPE = 'Laptop'
    )
  );

-------------------------------------------------------------
--Find out the average hard disk drive capacity of PCs produced by makers who also manufacture printers. Result set: maker, average HDD capacity.
SELECT maker,
  AVG(hd)
FROM
  (SELECT a.maker AS maker,
    b.hd          AS hd
  FROM product a
  INNER JOIN pc b
  ON a.model = b.model
  WHERE type = 'PC'
  AND maker IN
    ( SELECT DISTINCT maker FROM product WHERE TYPE = 'PC'
    INTERSECT
    SELECT DISTINCT maker FROM product WHERE type = 'Printer'
    )
  )
GROUP BY maker;
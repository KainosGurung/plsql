--Find the model number, speed and hard drive capacity for all the PCs with prices below $500. Result set: model, speed, hd.

SELECT model, speed, hd 
FROM pc 
WHERE price < 500;

-------------------------------------------------------------
--List all printer makers. Result set: maker.

SELECT DISTINCT maker 
FROM product  
WHERE type = 'printer';

-------------------------------------------------------------
--Find the model number, RAM and screen size of the laptops with prices over $1000.

SELECT model, ram, screen 
FROM laptop 
WHERE price > 1000;

-------------------------------------------------------------
--Find all records FROM the Printer table containing data about color printers.

SELECT * 
FROM printer 
WHERE color = 'y';

-------------------------------------------------------------
--Find the model number, speed and hard drive capacity of PCs cheaper than $600 HAVING a 12x or a 24x CD drive.

SELECT model, speed, hd 
FROM pc 
WHERE price < 600 AND (cd='12x' or cd='24x');

-------------------------------------------------------------
--For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.

SELECT DISTINCT Product.maker, Laptop.speed
FROM Product INNER JOIN Laptop  ON product.model = laptop.model
WHERE Laptop.hd >= 10;

--------------------------------------------------------------
--Find out the models and prices for all the products (of any type) produced by maker B.

SELECT product.model, pc.price 
FROM product INNER JOIN pc 
ON product.model = pc.model
WHERE product.maker = 'B'

UNION

SELECT product.model, laptop.price 
FROM product INNER JOIN laptop 
ON product.model = laptop.model
WHERE product.maker = 'B'

UNION

SELECT product.model, Printer.price 
FROM product INNER JOIN Printer 
ON product.model = Printer.model
WHERE product.maker = 'B';

-------------------------------------------------------------
--Find the makers producing PCs but not laptops.

SELECT DISTINCT maker 
FROM product 
WHERE type = 'PC'
Except
SELECT DISTINCT maker 
FROM product 
WHERE type = 'Laptop';

-------------------------------------------------------------
--Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.

SELECT DISTINCT product.maker 
FROM product INNER JOIN pc ON product.model = pc.model 
WHERE speed >= 450

-------------------------------------------------------------
--Find the printer models HAVING the highest price. Result set: model, price.

SELECT model, price 
FROM printer 
WHERE price = (SELECT max(price) AS price FROM printer);

-------------------------------------------------------------
--Find out the average speed of PCs.

SELECT avg(speed) 
FROM pc;

-------------------------------------------------------------
--Find out the average speed of the laptops priced over $1000.

SELECT avg(speed) 
FROM laptop 
WHERE price > 1000;

-------------------------------------------------------------
--Find out the average speed of the PCs produced by maker A.

SELECT avg(speed) 
FROM pc 
WHERE model in (SELECT model FROM product WHERE maker = 'A' AND type = 'PC');

-------------------------------------------------------------
--Get the makers who produce only one product type and more than one model. Output: maker, type.

SELECT maker,
       MAX(type) AS type
FROM   product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1
       AND COUNT(model) > 1;

-------------------------------------------------------------
--Get hard drive capacities that are identical for two or more PCs. Result set: hd.

SELECT hd 
FROM pc 
GROUP BY hd 
HAVING count(hd) >= 2;

-------------------------------------------------------------
--Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i).  Result set: model with the bigger number, model with the smaller number, speed, and RAM.

SELECT b.model, a.model, a.speed, a.ram
FROM pc a, pc b 
WHERE a.speed = b.speed AND a.ram = b.ram AND a.model != b.model 
GROUP BY b.model, a.model, a.speed, a.ram
HAVING a.model < b.model;

-------------------------------------------------------------

-------------------------------------------------------------

-------------------------------------------------------------

-------------------------------------------------------------

-------------------------------------------------------------






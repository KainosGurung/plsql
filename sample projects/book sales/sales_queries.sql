--How many sales were there in Windsor, CT on December 4, 2011?
SELECT count(*) as "# of sales" FROM sales s INNER JOIN "LOCATION" l ON s.locationid = l.locationid INNER JOIN "DATE" d ON d.dateid = s.dateid
where l.city like 'Windsor' and l.state like 'CT' and d.DAY = 4 and d.month = 12 and d.year = 2011
;

--How many pitches and sales were there in Albany, NY on December 4, 2011?
SELECT sum(s.sales) + sum(s.pitches) as "# of sales and pitches" FROM sales s INNER JOIN "LOCATION" l ON s.locationid = l.locationid INNER JOIN "DATE" d ON d.dateid = s.dateid
WHERE l.city LIKE 'Albany' AND l.state LIKE 'NY' AND d.DAY = 4 AND d.MONTH = 12 AND d.YEAR = 2011
;

--How many sales were there on December 3, 2011?
SELECT sum(s.sales) as "# of sales" FROM sales s INNER JOIN "DATE" d ON d.dateid = s.dateid
WHERE d.DAY = 3 AND d.MONTH = 12 AND d.YEAR = 2011
;

--For the weekend of December 3 and December 4, 2011, what location had the most sales?
select locationid, city, state from (
select locationid, city, state, count(*) as cnt from (
SELECT l.locationid, l.city, l.state FROM sales s INNER JOIN "LOCATION" l ON s.locationid = l.locationid INNER JOIN "DATE" d ON d.dateid = s.dateid
WHERE (d.DAY = 3 OR d.DAY = 4) AND d.MONTH = 12 AND d.YEAR = 2011
) group by locationid, city, state order by cnt desc) where rownum = 1;


--Though not shown in the sample data, what are the monthly sales totals for Windsor, CT
--for the last three months (i.e., the last quarter of 2011)?
SELECT * FROM (
SELECT d.MONTH, d.YEAR, sum(s.sales) FROM sales s INNER JOIN "DATE" d ON d.dateid = s.dateid INNER JOIN "LOCATION" l ON s.locationid = l.locationid
where l.city like 'Windsor' and l.state like 'CT'
GROUP BY d.MONTH, d.YEAR order by year desc, month desc) where rownum <= 3;


--What are the monthly sales totals for all locations for the last three months?
select * from (
SELECT d.MONTH, d.YEAR, sum(s.sales) FROM sales s INNER JOIN "DATE" d ON d.dateid = s.dateid
GROUP BY d.MONTH, d.YEAR order by year desc, month desc) where rownum <= 3;

--What are the least productive locations (i.e., which locations have the least sales)?
SELECT locationid, sum(sales) FROM sales GROUP BY locationid
having sum(sales) = (select min(cnt) from ( (select cnt from ( SELECT locationid, sum(sales) as cnt FROM sales GROUP BY locationid))));

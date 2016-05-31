--Display city and total number of stores present in each city.
SELECT DISTINCT city,
  COUNT(city)
FROM toy_store
GROUP BY city;

------Display store which is open for maximum time.
SELECT *
FROM
  (SELECT toy_store_name,
    store_closing_time - store_opening_time AS time_open
  FROM toy_store
  ORDER BY time_open DESC
  )
WHERE rownum = 1;

----Display store which has been open at least two hours before current time.
SELECT toy_store_name
FROM toy_store
WHERE extract(hour FROM CURRENT_TIMESTAMP - store_opening_time) >= 2;

----Display stores which are either open before 9: 00 am or close after 9 :00 pm.
SELECT toy_store_name
FROM toy_store
WHERE EXTRACT(HOUR FROM store_opening_time) < 9
OR EXTRACT(HOUR FROM store_closing_time)   >= 21;

----Display store names that start with 'P' and contain 'e' also some where in the name.
SELECT toy_store_name
FROM toy_store
WHERE toy_store_name LIKE 'P%e%';

----Display city with second highest number of stores.
SELECT city, --get the second from the the below query
  store_count
FROM
  (SELECT city, --append rownumber column to each of the rows from the sub query below
    store_count,
    ROWNUM AS rn
  FROM
    (SELECT city, --get cities along with their count
      COUNT(city) AS store_count
    FROM toy_store
    GROUP BY city
    )
  )
WHERE rn = 2;

----Display all stores whose name is starting with 'Kid'.
SELECT toy_store_name
FROM toy_store
WHERE toy_store_name LIKE 'Kid%';

----Display all outdoor toys.
SELECT toy_name
FROM toy_dtls
WHERE CATEGORY IN ('o', 'b');

----Display total number of toys based on their category.
SELECT category,
  COUNT(category)
FROM toy_dtls
GROUP BY category;

----Display stores that sell only outdoor toys.
SELECT DISTINCT c.toy_store_name --get toy stores that sell out door toys
FROM toy_rel A
INNER JOIN toy_dtls b
ON A.toy_id = b.toy_id
INNER JOIN toy_store c
ON c.toy_store_id = A.toy_store_id
WHERE b.CATEGORY  = 'o'
MINUS                  --subtract those stores that sell toys from other categories as well
SELECT DISTINCT c.toy_store_name
FROM toy_rel A
INNER JOIN toy_dtls b
ON A.toy_id = b.toy_id
INNER JOIN toy_store c
ON c.toy_store_id = A.toy_store_id
WHERE b.CATEGORY != 'o';

----Display number of stores based on category of Toys they sell.
SELECT CATEGORY   AS CATEGORY, --count the number of stores that sell each type of category
  COUNT(CATEGORY) AS COUNT
FROM
  (SELECT b.toy_store_id, --get toy store ids and the category of toys they sell
    A.CATEGORY,
    COUNT(*) AS cnt
  FROM toy_dtls A
  INNER JOIN toy_rel b
  ON A.toy_id = b.toy_id
  GROUP BY b.toy_store_id,
    A.CATEGORY
  )
GROUP BY CATEGORY;

----Display toys from highest to lowest rating.
SELECT *
FROM toy_dtls
ORDER BY toy_rating DESC NULLS LAST;

----Display toys that are not given any rating.
SELECT *
FROM toy_dtls
WHERE toy_rating IS NULL;

----Display average rating of toys.
SELECT AVG(toy_rating) FROM toy_dtls;

----Display stores that sell highest rated toys.
SELECT DISTINCT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT toy_store_id
  FROM toy_rel
  WHERE toy_id IN
    (SELECT toy_id
    FROM toy_dtls
    WHERE toy_rating =
      (SELECT MAX(toy_rating) FROM toy_dtls
      )
    )
  );

----Display toys age group wise.
SELECT * FROM toy_dtls ORDER BY agegroup;

----Display stores that sell toys for children of lowest age group.
SELECT DISTINCT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT toy_store_id
  FROM toy_rel
  WHERE toy_id IN
    (SELECT toy_id
    FROM toy_dtls
    WHERE agegroup =
      (SELECT MIN(agegroup) FROM toy_dtls
      )
    )
  );

----Display average rating for toys that belong to the lowest age group.
SELECT AVG(toy_rating)
FROM
  (SELECT * FROM toy_dtls WHERE agegroup =
    (SELECT MIN(agegroup) FROM toy_dtls
    )
  );

----Display toys with maximum discount.
SELECT *
FROM toy_dtls
WHERE discount_percent =
  (SELECT MAX(discount_percent) FROM toy_dtls
  );

----Display calculated price after applying discount for discounted toys.
SELECT toy_name,
  toy_price,
  discount_percent,
  CASE
    WHEN discount_percent IS NULL
    THEN toy_price
    ELSE toy_price - toy_price * (discount_percent / 100)
  END AS new_price
FROM toy_dtls;

----Display toys with lowest price or lowest discounted price.
SELECT toy_name,
  toy_price,
  toy_price - toy_price * (discount_percent / 100) AS discount_price
FROM toy_dtls
WHERE toy_price =
  (SELECT MIN(toy_price) FROM toy_dtls
  )
OR toy_price - toy_price * (discount_percent / 100) =
  (SELECT MIN(new_price)
  FROM
    (SELECT toy_name,
      toy_price,
      CASE
        WHEN discount_percent IS NULL
        THEN toy_price
        ELSE toy_price - toy_price * (discount_percent / 100)
      END AS new_price
    FROM toy_dtls
    )
  )
ORDER BY toy_price;

----Display difference between the highest priced and lowest priced toy.
SELECT MAX(toy_price) - MIN(toy_price) AS diff
FROM toy_dtls;

----Display stores that sell the highest priced toys
SELECT A.toy_store_name
FROM toy_store A
INNER JOIN toy_rel b
ON A.toy_store_id = b.toy_store_id
WHERE toy_id     IN
  (SELECT toy_id
  FROM toy_dtls
  WHERE toy_price =
    (SELECT MAX(toy_price) FROM toy_dtls
    )
  );

----Display stores that sell the lowest discounted priced toys.
SELECT A.toy_store_name
FROM toy_store A
INNER JOIN toy_rel b
ON A.toy_store_id = b.toy_store_id
WHERE toy_id     IN
  (SELECT toy_id
  FROM toy_dtls
  WHERE toy_price =
    (SELECT MIN(toy_price) FROM toy_dtls
    )
  );

----Display toys whose price is greater than average price of all toys.
SELECT *
FROM toy_dtls
WHERE toy_price >
  (SELECT AVG(toy_price) FROM toy_dtls
  );

----Display the category of toys which is having its average price greater than minimum toy price.
SELECT *
FROM
  (SELECT CATEGORY AS category,
    AVG(toy_price) AS average
  FROM
    (SELECT toy_price, CATEGORY FROM toy_dtls WHERE CATEGORY = 'i'
    )
  GROUP BY CATEGORY
  UNION
  SELECT CATEGORY  AS category,
    AVG(toy_price) AS average
  FROM
    (SELECT toy_price, CATEGORY FROM toy_dtls WHERE CATEGORY = 'o'
    )
  GROUP BY CATEGORY
  UNION
  SELECT CATEGORY  AS category,
    AVG(toy_price) AS average
  FROM
    (SELECT toy_price, CATEGORY FROM toy_dtls WHERE CATEGORY = 'b'
    )
  GROUP BY CATEGORY
  )
WHERE average >
  (SELECT MIN(toy_price) FROM toy_dtls
  );

----Display city that has the highest count of toys for the minimum age group.
SELECT * -- get the city with the highest count
FROM
  (SELECT city, --get cities along with their count
    COUNT(city) AS city_count
  FROM
    (SELECT A.city --get cities in which there are stores with toys from the min age group
    FROM toy_store A
    INNER JOIN toy_rel b
    ON A.toy_store_id = b.toy_store_id
    WHERE b.toy_id   IN
      (SELECT toy_id --get all toy_ids for the min age group
      FROM toy_dtls
      WHERE agegroup =
        (SELECT MIN(agegroup) FROM toy_dtls /*--get the min age group from toy_dtls*/
        )
      )
    )
  GROUP BY city
  )
WHERE rownum = 1;

----Display city names and the count of toy stores and toys with them city wise.
SELECT a.city,
  a.toy_count,
  b.store_count
FROM
  (SELECT city,
    COUNT(city) AS toy_count
  FROM
    (SELECT toy_id, --gets the unique rows basically
      city,
      COUNT(*)
    FROM
      (SELECT b.toy_id,
        A.city
      FROM toy_store A
      INNER JOIN toy_rel b
      ON A.toy_store_id = b.toy_store_id
      )
    GROUP BY toy_id,
      city
    )
  GROUP BY city
  ) a
INNER JOIN
  (SELECT city, COUNT(city) AS store_count FROM toy_store GROUP BY city
  ) b
ON a.city = b.city;

----Display toy store name, toy name and total number of each toy available in each toy store.
SELECT A.toy_store_name,
  c.toy_name,
  b.available_qty
FROM toy_store a
INNER JOIN toy_rel b
ON a.toy_store_id = b.toy_store_id
INNER JOIN toy_dtls c
ON b.toy_id = c.toy_id;


----Display toy store which has maximum available quantity of lowest priced toys.
SELECT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT toy_store_id
  FROM toy_rel
  WHERE available_qty =
    (SELECT MAX(available_qty)
    FROM toy_rel
    WHERE toy_id IN
      (SELECT toy_id
      FROM toy_dtls
      WHERE toy_price =
        (SELECT MIN(toy_price) FROM toy_dtls
        )
      )
    )
  AND toy_id IN
    (SELECT toy_id
    FROM toy_dtls
    WHERE toy_price =
      (SELECT MIN(toy_price) FROM toy_dtls
      )
    )
  );

----Display toy store with toy name and available quantity details for which stock is present but available quantity is <12.
SELECT A.toy_store_name,
  c.toy_name,
  b.available_qty
FROM toy_store a
INNER JOIN toy_rel b
ON a.toy_store_id = b.toy_store_id
INNER JOIN toy_dtls c
ON b.toy_id = c.toy_id
WHERE available_qty BETWEEN 1 AND 11; --between [1,11] inclusive

----Display age group wise total number of toys available for age group above 5.
SELECT COUNT(*) FROM toy_dtls WHERE agegroup > 5;

----Display toy store name where total number of toys available is greater than maximum available quantity for any toy.
SELECT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT toy_store_id
  FROM
    (SELECT toy_store_id,
      SUM(available_qty) AS sum_qty
    FROM toy_rel
    GROUP BY toy_store_id
    ORDER BY toy_store_id
    )
  WHERE sum_qty >
    (SELECT MAX(available_qty) FROM toy_rel
    )
  );

----Display toy store names that belong to the same city.
--what?

----Display toy names that have the same price.
SELECT toy_name, --gets toys whose prices matches the below sub query
  toy_price
FROM toy_dtls
WHERE toy_price IN
  (SELECT toy_price --get prices with counts larger than 1
  FROM
    (SELECT toy_price, COUNT(toy_price) AS cnt FROM toy_dtls GROUP BY toy_price --get unique prices along with their counts
    )
  WHERE cnt > 1
  );

----Display toy store which has not stored any toys yet.
SELECT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT toy_store_id
  FROM
    (SELECT toy_store_id,
      SUM(available_qty) AS sum_qty
    FROM toy_rel
    GROUP BY toy_store_id
    )
  WHERE sum_qty = 0
  ); 

----Display Toys that are not available in any toy store yet.
SELECT toy_name
FROM toy_dtls
WHERE toy_id IN
  (SELECT toy_id FROM toy_rel WHERE available_qty = 0
  );

----Display Toy store name with Toy names it sells, also those stores which do not sell any toys yet should be displayed.
SELECT toy_store_name,
  toy_name
FROM toy_rel a
INNER JOIN toy_dtls b
ON a.toy_id = b.toy_id
RIGHT OUTER JOIN toy_store c
ON A.toy_store_id = c.toy_store_id ORDER BY toy_store_name;

----Display Toy store name with Toy names it sells, also those toys which are not sold in any toy store yet should be displayed.
SELECT A.toy_store_name,
  c.toy_name
FROM toy_store A
INNER JOIN toy_rel b
ON A.toy_store_id = b.toy_store_id
RIGHT OUTER JOIN toy_dtls c
ON b.toy_id = c.toy_id ORDER BY toy_store_name;

----Display Toy store name with Toy names it sells, also those stores which do not sell any toys yet should be displayed including those toys which are not sold in any toy store yet.
SELECT x.toy_store_name, z.toy_name
FROM toy_store x
LEFT OUTER JOIN toy_rel y --left outer join to get nulls in toy_store
ON x.toy_store_id = y.toy_store_id
FULL OUTER JOIN toy_dtls z --full outer join to kepe nulls from the first join and get nulls from the second join
ON y.toy_id = z.toy_id;

----Display stores that do not sell toys below rating of 3.

SELECT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT DISTINCT x.toy_store_id --join the toy_rel table with the toy_dtl table to view toy ratings
  FROM toy_rel x
  INNER JOIN toy_dtls y
  ON x.toy_id = y.toy_id
  MINUS                 --subtract from the above table, those stores which have toys with ratings below a 3
  SELECT DISTINCT x.toy_store_id 
  FROM toy_rel x        
  INNER JOIN toy_dtls y
  ON x.toy_id = y.toy_id
  WHERE y.toy_rating < 3
  OR y.toy_rating   IS NULL
  ) ;

----Display stores that do not sell toys that do not have maximum rating.
SELECT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT DISTINCT x.toy_store_id --join the toy_rel table with the toy_dtl table to view toy ratings
  FROM toy_rel x
  INNER JOIN toy_dtls y
  ON x.toy_id = y.toy_id
  MINUS --subtract from the above table, those stores which have toys with maximum ratings
  SELECT DISTINCT x.toy_store_id
  FROM toy_rel x
  INNER JOIN toy_dtls y
  ON x.toy_id        = y.toy_id
  WHERE y.toy_rating =
    (SELECT MAX(toy_rating) FROM toy_dtls
    )
  );
  
----Display stores that do not give any discount.
SELECT toy_store_name
FROM toy_store
WHERE toy_store_id IN
  (SELECT DISTINCT x.toy_store_id --join the toy_rel table with the toy_dtl table to view toy ratings
  FROM toy_rel x
  INNER JOIN toy_dtls y
  ON x.toy_id = y.toy_id
  MINUS --subtract from the above table, those stores which have toys with discounts
  SELECT DISTINCT x.toy_store_id
  FROM toy_rel x
  INNER JOIN toy_dtls y
  ON x.toy_id        = y.toy_id
  WHERE y.discount_percent > 0
  );

----Display toys that are sold only in one store exclusively i.e. not available in any other store.
SELECT toy_name
FROM toy_dtls
WHERE toy_id IN
  (SELECT toy_id
  FROM
    ( SELECT toy_id, COUNT(toy_id) AS cnt FROM toy_rel GROUP BY toy_id
    )
  WHERE cnt = 1
  );

----Display details of toys having '_' (underscore) in their name.
SELECT * FROM toy_dtls WHERE toy_name LIKE '%\_%' ESCAPE '\';

----Display details of Toys that have more than 6 characters in their name.
SELECT * FROM toy_dtls WHERE LENGTH(toy_name) > 6;

----Display all toy prices in words like One Hundred Fifty
SELECT toy_price,
  TO_CHAR(TO_DATE(toy_price,'J'),'JSP') AS words
FROM toy_dtls;

----Display all Toy store and Toy names without any spaces like PingpongBall.
SELECT REPLACE(toy_store_name, ' ', '') as replaced FROM toy_store
UNION
SELECT REPLACE(toy_name, ' ', '') FROM toy_dtls;

----Display Toy name, Price and available quantity for Puzzles and More in following format Toy name**Price**Available Quantity. For ex: Bat**500**3.
SELECT concat(concat(concat(concat(x.toy_name, '**'), TO_CHAR(x.toy_price)), '**'), TO_CHAR(y.available_qty)) AS my_str
FROM toy_dtls x
INNER JOIN toy_rel y
ON x.toy_id          = y.toy_id
WHERE y.toy_store_id =
  (SELECT toy_store_id
  FROM toy_store
  WHERE toy_store_name LIKE 'Puzzles and More'
  );

----Display count of store names that start with the same first alphabet, also display that alphabet.
SELECT sub,
  COUNT(sub)
FROM
  ( SELECT SUBSTR(toy_store_name, 0, 1) AS sub FROM toy_store
  )
GROUP BY sub
ORDER BY sub;
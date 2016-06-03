--For each department, print the department id, department name and number of
--faculty affiliated  with  that  department. Print  0  as  the  number  of
--faculty if a department has no faculty.
SELECT deptid,
  dname,
  COUNT (fname) AS "Number of Faculty"
FROM
  (SELECT d.deptid,
    d.dname,
    f.fname
  FROM department d
  LEFT JOIN faculty f
  ON d.deptid = f.deptid
  )
GROUP BY deptid,
  dname
ORDER BY deptid;


--Print  the  faculty  id,  name  and  department  id  of  the  faculty
--teaching the maximum number of classes 
SELECT fid,
  fname,
  deptid
FROM faculty
WHERE fid =
  (SELECT fid
  FROM
    ( SELECT fid, COUNT(fid) AS cnt FROM CLASS GROUP BY fid ORDER BY cnt DESC
    )
  WHERE rownum = 1
  );

--Print the name, department id and age of the student enrolled in the maximum
--NUMBER  OF classes  taught BY faculty  affiliated WITH THE  computer sciences 
--department (i.e. dname is Computer Sciences) 
SELECT sname,
  deptid,
  age
FROM student
WHERE snum =
  (SELECT snum
  FROM
    (SELECT snum,
      COUNT(snum) AS cnt
    FROM enrolled
    WHERE cname IN
      (SELECT cname
      FROM CLASS
      WHERE fid IN
        (SELECT fid
        FROM faculty
        WHERE deptid =
          (SELECT deptid FROM department WHERE dname LIKE 'Computer Sciences'
          )
        )
      )
    GROUP BY snum
    ORDER BY cnt DESC
    )
  WHERE rownum = 1
  );

--Print the name  and department  id  of  the student(s)  who take  classes in
--all rooms that  a class is  taught  OR  are younger than  20. 
SELECT sname,
  deptid
FROM student
WHERE snum IN
  (SELECT snum
  FROM
    (SELECT snum,
      COUNT(snum) AS room_count
    FROM
      ( SELECT DISTINCT a.snum,
        b.room
      FROM
        (SELECT *
        FROM enrolled
        WHERE snum IN
          (SELECT snum
          FROM
            ( SELECT snum, COUNT(snum) AS cnt FROM enrolled GROUP BY snum
            )
          WHERE cnt >= 3
          )
        ) A
      INNER JOIN CLASS b
      ON A.cname = b.cname
      )
    GROUP BY snum
    )
  WHERE room_count =
    (SELECT COUNT(DISTINCT room) FROM class
    )
  )
OR age < 20;

--Print the ids (snum) of the students who have more than 3 (distinct)
--classmates  in  total.

------get classes and snums from those classes with more than 1 student
------not done
select * from enrolled where cname in (
select cname from (select cname, count(cname) as cnt from enrolled group by cname) where cnt > 1);


--select snum from enrolled a where snum in ( select snum ,count(cname) from enrolled b where a.cname=b.cname group by cname having co

select cname from enrolled group by cname having count(cname) > 3;
SELECT snum, count(1) FROM enrolled GROUP BY snum HAVING count(1) > 3;

8016, 5765
5765, 8016
1234, 8016
1234, 671
8016, 1234
8016, 671
671, 8016
671, 1234
8016,1234
1234, 8016
8016, 418
418, 8016






--Print the names of (distinct) faculty who teach 2 or more classes in
--the same room
SELECT fname
FROM faculty
WHERE fid IN
  (SELECT fid
  FROM
    (SELECT fid,
      room,
      COUNT(room)
    FROM class
    GROUP BY fid,
      room
    HAVING COUNT(room) > 1
    )
  );
  
--For each department except Management (i.e. dname = Management), print the 
--department id and the average age of students in that department. if a 
--department has no students, print 0 for the average age. 
select d.deptid,
  NVL(AVG(s.age), 0) --nvl function replaces null value with 0
FROM student s
RIGHT JOIN department d
ON s.deptid  = d.deptid
WHERE dname != 'Management'
GROUP BY d.deptid;

--Print the department id, name and age of the youngest student not enrolled in 
--any classes 
SELECT *
FROM
  (SELECT deptid,
    sname,
    age
  FROM student
  WHERE snum IN
    ( SELECT DISTINCT snum FROM student
    MINUS
    SELECT DISTINCT snum FROM enrolled
    )
  ORDER BY age
  )
WHERE rownum = 1;

--Print the ids (snum)  of  the students  majoring  in  a department  whose
--faculty do not teach any classes 

SELECT snum
FROM student
WHERE deptid IN
  ( SELECT DISTINCT deptid --get the departments whom contain faculties that do not teach a class
  FROM faculty
  WHERE fid NOT IN
    (SELECT DISTINCT fid FROM class
    )
  MINUS                    --get those departments that only contain facilties that do not teach a class
  SELECT DISTINCT deptid ----get the departments whom contain faculties that DO teach a class
  FROM faculty
  WHERE fid IN
    (SELECT DISTINCT fid FROM class
    )
  UNION --combine those departs whose faculty do not teach any class with departments that do not contain faculties
    (SELECT DISTINCT deptid FROM department
    MINUS --get those departments which contain no faculties
    SELECT DISTINCT deptid FROM faculty
    )
  );


--What is the name of the faculty teaching the class with the greatest number of 
--students enrolled? What is the number of students in that class?
SELECT fname,
  cnt
FROM faculty,
  (SELECT cnt
  FROM
    (SELECT cname,
      COUNT(cname) AS cnt
    FROM enrolled
    GROUP BY cname
    ORDER BY cnt DESC
    )
  WHERE rownum = 1
  )
WHERE fid =
  (SELECT fid
  FROM class
  WHERE cname =
    (SELECT cname
    FROM
      (SELECT cname,
        COUNT(cname) AS cnt
      FROM enrolled
      GROUP BY cname
      ORDER BY cnt DESC
      )
    WHERE rownum = 1
    )
  );



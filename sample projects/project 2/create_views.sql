create or replace view project2_viewa as
SELECT f.fname, count(c.cname) AS "Class Count" FROM faculty f LEFT JOIN CLASS c ON f.fid = c.fid GROUP BY f.fname ORDER BY f.fname;

create or replace view project2_viewb as
select s.snum as "ID", s.sname as "NAME", c.cname as "COURSE NAME", c.room, to_char(c.meets_at, 'HH:MI') as "TIME", 's' as "TYPE" from student s inner join enrolled e on s.snum = e.snum
inner join class c on e.cname = c.cname
UNION
select f.fid as "ID", f.fname as "NAME", c.cname as "COURSE NAME", c.room, to_char(c.meets_at, 'HH:MI') as "TIME", 'f' as "TYPE" from faculty f inner join class c on f.fid = c.fid
ORDER BY "COURSE NAME";

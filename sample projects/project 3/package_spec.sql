CREATE OR REPLACE PACKAGE BODY project3_package
AS
  PROCEDURE pro_department_report
  IS
    CURSOR get_dept
    IS
      SELECT deptid, dname FROM department;
  TYPE custom_dept
IS
  RECORD
  (
    deptid department.deptid%TYPE,
    dname department.dname%TYPE );
  dept custom_dept;
TYPE get_student_cursor
IS
  REF
  CURSOR;
    get_student get_student_cursor;
    sname student.sname%type;
    scount binary_integer;
  BEGIN
    OPEN get_dept;
    LOOP
      FETCH get_dept INTO dept;
    EXIT
  WHEN get_dept%notfound;
    dbms_output.put_line('Department: ' || dept.dname);
    SELECT COUNT(snum) INTO scount FROM student WHERE deptid = dept.deptid;
    dbms_output.put_line('Total Number of Students: ' || scount);
    dbms_output.put_line('-­‐-­‐-­‐-­‐-­‐-­‐-­‐-­‐-­‐-­‐-­‐-­‐-­‐');
    OPEN get_student FOR SELECT sname FROM student WHERE deptid = dept.deptid ORDER BY sname;
    LOOP
      FETCH get_student INTO sname;
      EXIT
    WHEN get_student%notfound;
      dbms_output.put_line(sname);
    END LOOP;
    CLOSE get_student;
    dbms_output.new_line;
  END LOOP;
CLOSE get_dept;
END;
PROCEDURE pro_student_stats
IS
  CURSOR student_class
  IS
    SELECT s.sname,
      COUNT(e.cname)
    FROM student s
    INNER JOIN enrolled e
    ON s.snum = e.snum
    GROUP BY s.sname
    ORDER BY s.sname;
  sname student.sname%TYPE;
  sc_count binary_integer;
BEGIN
  dbms_output.put_line('Student Name  # Classes');
  dbms_output.put_line('------------  ---------');
  OPEN student_class;
  LOOP
    FETCH student_class INTO sname, sc_count;
    EXIT
  WHEN student_class%notfound;
    dbms_output.put_line(sname || CHR(9) || sc_count);
  END LOOP;
END;
PROCEDURE pro_faculty_stats
IS
BEGIN
  NULL;
END;
PROCEDURE pro_histogram
IS
BEGIN
  NULL;
END;
PROCEDURE pro_enroll
IS
BEGIN
  NULL;
END;
END project3_package;
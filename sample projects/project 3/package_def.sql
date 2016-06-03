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
  CURSOR get_student_count
  IS
    SELECT f.fname,
      NVL(COUNT(e.snum),0) AS student_count
    FROM (faculty f
    LEFT JOIN CLASS c
    ON f.fid = c.fid)
    LEFT JOIN enrolled e
    ON c.cname = e.cname
    GROUP BY f.fname
    ORDER BY f.fname;
TYPE stu_table_type
IS
  TABLE OF NUMBER INDEX BY faculty.fname%TYPE;
  stu_table stu_table_type;
  fname faculty.fname%TYPE;
  sc_count  NUMBER;
  max_count NUMBER := -1;
  min_count NUMBER := -1;
  bin_rate  NUMBER;
  rs1       NUMBER;
  rs2       NUMBER;
BEGIN
  OPEN get_student_count;
  LOOP
    FETCH get_student_count INTO fname, sc_count;
    EXIT
  WHEN get_student_count%notfound;
    --If min_count and max_count are set to their default values
    --we know that this is the first iteration of the loop
    IF(min_count = -1 AND max_count = -1) THEN
      min_count := sc_count;
      max_count := sc_count;
    END IF;
    IF(sc_count  < min_count) THEN --update min_count if sc_count is less than min_count
      min_count := sc_count;
    END IF;
    IF (sc_count > max_count) THEN --update max_count if sc_count is greater than max_count
      max_count := sc_count;
    END IF;
    stu_table(fname) := sc_count; --insert the data we fetched from the cursor into an array
  END LOOP;
  CLOSE get_student_count;
  bin_rate := floor((max_count-min_count)/4);
  dbms_output.put(rpad('Faculty Name', 15) || rpad('# of Students:',16));
  dbms_output.put(rpad(min_count, 6));
  dbms_output.put(rpad((min_count                    +bin_rate ||' >= X > ' || min_count), 12));
  dbms_output.put(rpad((TO_CHAR(min_count            + 2*bin_rate)||' >= X > ' || TO_CHAR(min_count+bin_rate)),12));
  dbms_output.put(rpad((TO_CHAR(min_count            +3*bin_rate) ||' >= X > ' || TO_CHAR(min_count+2*bin_rate)),12));
  dbms_output.put(rpad((TO_CHAR(min_count            +4*bin_rate) ||' >= X > ' || TO_CHAR(min_count+3*bin_rate)),12));
  IF( floor((max_count                               -min_count)/4) != (max_count-min_count)/4) THEN
    dbms_output.put(rpad(('X > ' || TO_CHAR(min_count+4*bin_rate)), 6));
  END IF;
  dbms_output.new_line();--output the contents of the buffer
  dbms_output.put('------------   --------------  --    ----------- ----------- ----------  ----------');
  IF( floor((max_count-min_count)/4) != (max_count-min_count)/4) THEN
    dbms_output.put('  ------');
  END IF;
  dbms_output.new_line();--output the contents of the buffer
  fname       := stu_table.FIRST;
  WHILE fname IS NOT NULL
  LOOP
    dbms_output.put(rpad(fname,15) || rpad(TO_CHAR(stu_table(fname)),16));
    sc_count   := stu_table(fname);
    IF(sc_count = min_count) THEN
      dbms_output.put(rpad('X',6));
    elsif( min_count+bin_rate >= sc_count AND sc_count > min_count) THEN
      dbms_output.put(lpad('X',7));
    elsif( min_count+2*bin_rate >= sc_count AND sc_count > min_count+bin_rate) THEN
      dbms_output.put(lpad('X',19));
    elsif( min_count+3*bin_rate >= sc_count AND sc_count > min_count+2*bin_rate) THEN
      dbms_output.put(lpad('X',31));
    elsif( min_count+4*bin_rate >= sc_count AND sc_count > min_count+3*bin_rate) THEN
      dbms_output.put(lpad('X',43));
    elsif( sc_count > min_count+4*bin_rate) THEN
      dbms_output.put(lpad('X',55));
    END IF;
    dbms_output.new_line();
    fNAME := stu_table.NEXT(fNAME);
  END LOOP;
END;
PROCEDURE pro_histogram
IS
  CURSOR student_median
  IS
    SELECT age, COUNT(age) FROM student GROUP BY age ORDER BY age;
  age        NUMBER;
  a_count    NUMBER;
  median_age NUMBER;
  integer_median binary_integer := -1;
BEGIN
  SELECT median(age) INTO median_age FROM student;
  IF(floor(median_age) = median_age) THEN
    integer_median    := 1;
  END IF;
  dbms_output.put_line(rpad('Age',5) || '| ' || rpad('Count',7));
  dbms_output.put_line('------------');
  OPEN student_median;
  LOOP
    FETCH student_median INTO age, a_count;
    dbms_output.put(rpad(TO_CHAR(age),5) || '| ' || rpad(TO_CHAR(a_count),5)) ;
    IF (age = median_age AND integer_median = 1) THEN
      dbms_output.put('<-- median');
    END IF;
    dbms_output.new_line();
    EXIT
  WHEN student_median%notfound;
  END LOOP;
  CLOSE student_median;
END;
PROCEDURE get_all_enrolled
IS
  CURSOR get_all_enrolled_cursor
  IS
    SELECT * FROM enrolled ORDER BY snum;
  enrolled_record enrolled%rowtype;
BEGIN
  dbms_output.put_line(rpad('SNUM',8) || rpad('CNAME',15));
  dbms_output.put_line(rpad('-',13,'-'));
  OPEN get_all_enrolled_cursor;
  LOOP
    FETCH get_all_enrolled_cursor INTO enrolled_record;
    EXIT
  WHEN get_all_enrolled_cursor%notfound;
    dbms_output.put_line(enrolled_record.snum || ' ' ||enrolled_record.cname);
  END LOOP;
  CLOSE get_all_enrolled_cursor;
  dbms_output.new_line;
  dbms_output.new_line;
END;
PROCEDURE pro_enroll(
    sname_in IN student.sname%type,
    cname_in IN class.cname%type)
IS
  CURSOR get_snum
  IS
    SELECT snum FROM student WHERE sname LIKE sname_in;
  snum student.snum%TYPE;
BEGIN
  OPEN get_snum;
  FETCH get_snum INTO snum;
  CLOSE get_snum;

  IF (snum IS NOT NULL) THEN
    get_all_enrolled();
  INSERT INTO enrolled VALUES
    (snum, cname_in
    );
  get_all_enrolled();
  ELSE
    dbms_output.put_line('Student with name: ' || sname_in || ' not found.');
  end if;
END;
END project3_package;
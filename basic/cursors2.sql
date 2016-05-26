DECLARE
  CURSOR employee IS 
  SELECT ID, fname, age, sex FROM employees WHERE ROWNUM <= 10 AND ID <= 10;
  
  id employees.id%TYPE;
  fname employees.fname%TYPE;
  age employees.age%TYPE;
  sex employees.sex%TYPE;

BEGIN
  OPEN employee; -- allocate memory to the cursor by opening it
  loop
    fetch employee INTO id, fname, age, sex; -- fetch a row from the cursor
    exit WHEN employee%notfound;
    dbms_output.put_line(id || ' ' || fname || ' ' || age || ' ' || sex);
  END loop;
  CLOSE employee; -- release the allocated memory
  
END;
/
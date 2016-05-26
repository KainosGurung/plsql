DECLARE
  CURSOR employee_cursor IS
  SELECT * FROM employees WHERE ID > 20 AND ID < 25;
  
  employee_record employees%rowtype;

BEGIN
  OPEN employee_cursor; --open the cursor so we can fetch rows from it
  loop
    fetch employee_cursor INTO employee_record;
    exit WHEN employee_cursor%notfound;
    dbms_output.put_line(employee_record.ID || ' ' || employee_record.fname);
  END loop;
  CLOSE employee_cursor; --close the cursor and free the memory
END;
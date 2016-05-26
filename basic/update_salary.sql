set serveroutput on ;
DECLARE 
   total_rows number(2);
BEGIN
  --Increase salary by 500 for those whose salaries are less than 4000
  UPDATE customers
  SET salary = salary + 500
  WHERE salary < 4000;
  
  --If the query affected no rows...
  IF sql%notfound THEN
   dbms_output.put_line('no customers selected');
  ELSIF sql%found THEN
    total_rows := sql%rowcount;
    dbms_output.put_line( total_rows || ' customers selected ');
  END IF; 
END;
/
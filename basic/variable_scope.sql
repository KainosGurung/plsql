DECLARE
num1 INTEGER := 1;
num2 INTEGER := 3;

BEGIN
  
  dbms_output.put_line('outer: ' || num1);
  dbms_output.put_line('outer: ' || num2 ||chr(10));
  
  DECLARE
  num1 INTEGER := 2;
  num2 INTEGER := 4;
  
  BEGIN
    dbms_output.put_line('inner: ' || num1);
    dbms_output.put_line('inner: ' || num2 ||chr(10));
    dbms_output.put_line('Changing inner num1 and num2' ||chr(10));
    num1 := 22;
    num2 := 44;
  END;
  
  dbms_output.put_line('outer: ' || num1);
  dbms_output.put_line('outer: ' || num2);
  
END;

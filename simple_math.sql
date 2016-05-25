DECLARE
num1 INTEGER := 5;
num2 INTEGER := 8;

x INTEGER := 11;
y NUMBER := 23;

BEGIN
  
  dbms_output.put_line(num1 || '*' || num2 || '=' || num1*num2);
  dbms_output.put_line(num1 || '/' || num2 || '-' || x || '=' || (num1/num2-x));

END;

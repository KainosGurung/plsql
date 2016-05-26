DECLARE
  employee employees%rowtype;

BEGIN
  SELECT * INTO employee FROM employees WHERE ID = 93;
  
  dbms_output.put_line(employee.fname || employee.sex); --pads extra space after fname
  dbms_output.put_line(employee.fname || employee.age);
  dbms_output.put_line(employee.fname || 'string');
  dbms_output.put_line(employee.fname || employee.fname);
  dbms_output.put_line(employee.fname || employee.sex || employee.age); --pads extra space after fname
  dbms_output.put_line(employee.fname || employee.fname || employee.fname);
  dbms_output.put_line(employee.fname || employee.fname || employee.age);
  dbms_output.put_line(employee.fname || employee.age || employee.fname);
  dbms_output.put_line(employee.fname || employee.age || employee.fname || employee.fname);

END;
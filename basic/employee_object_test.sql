SET serveroutput ON;

DECLARE
  emp_object employee;
  e_obj employee := employee(123, 'Jack', 'Key', 53, 'MALE', 'Drunken.Master@mail.co', 'Mt. Tai Grove');
BEGIN
  --store query result into employee object emp_object
  SELECT employee(id, fname, lname, age, sex, email, address) INTO emp_object FROM employees WHERE ID = 30;
  dbms_output.put_line(emp_object.get_name());
  
  dbms_output.put_line(e_obj.get_name());
  dbms_output.put_line(e_obj.validate_age);
  dbms_output.put_line(e_obj.email);
END;
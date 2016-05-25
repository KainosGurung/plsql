DECLARE
   c_id customers.id%TYPE := 1;
   c_name  customers.name%TYPE;
   c_addr customers.address%TYPE;
   c_sal  customers.salary%TYPE;
BEGIN
   SELECT name, address, salary INTO c_name, c_addr, c_sal
   FROM customers
   WHERE id = c_id;

   dbms_output.put_line
   ('Customer ' ||c_name || ' from ' || c_addr || ' earns ' || c_sal);
END;
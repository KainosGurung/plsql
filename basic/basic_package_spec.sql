CREATE OR REPLACE PACKAGE BODY basic_pack AS
  PROCEDURE hello_world IS
    message VARCHAR(20) := 'Hello World!';
  BEGIN
      dbms_output.put_line(message);
  END hello_world;
  
  
  PROCEDURE get_circumference(radius BINARY_DOUBLE) IS
    circumference binary_double;
  BEGIN
    circumference := 2 * pi * radius;
    dbms_output.put_line(circumference);
  END get_circumference;
  
  
  PROCEDURE get_area(radius BINARY_DOUBLE) IS
    area BINARY_DOUBLE;
  BEGIN
    area := pi * radius *radius;
    dbms_output.put_line(area);
  END get_area;

END basic_pack;
CREATE OR REPLACE PACKAGE basic_pack AS
  PROCEDURE hello_world;
  PROCEDURE get_area(radius BINARY_DOUBLE);
  PROCEDURE get_circumference(radius BINARY_DOUBLE);

  pi CONSTANT BINARY_DOUBLE := 3.14159;
END basic_pack;
/
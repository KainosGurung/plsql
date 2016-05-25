CREATE OR REPLACE PROCEDURE max_proc( x integer, y integer)
AS
BEGIN
  IF ( x > y) THEN
    dbms_output.put_line(x);
  ELSE
    dbms_output.put_line(y);
  end if;
END;

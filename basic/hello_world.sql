SET serveroutput ON;
DECLARE
message VARCHAR2(20) := 'Hello World';
BEGIN
  dbms_output.put_line(message);
END;

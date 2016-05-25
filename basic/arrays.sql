DECLARE
   TYPE namesarray IS VARRAY(5) OF VARCHAR2(10);
   TYPE gradesarray IS VARRAY(5) OF INTEGER;
   names namesarray := namesarray('Adam', 'Bob', 'Charlie', 'Doug', 'Eric');
   grades gradesarray := gradesarray(100, 89, 56, 75, 88);
   total integer := names.count;
BEGIN
   dbms_output.put_line('Total: '|| total || ' Students');
   FOR i IN 1 .. total loop
      dbms_output.put_line(grades(i) || ' - ' || names(i));
   END LOOP;
END;
/
DECLARE
  TYPE number_table IS TABLE OF NUMBER INDEX BY VARCHAR2(30);
  numbers number_table;
  num   VARCHAR2(20);
BEGIN
  -- adding elements to the table
  numbers('one')  := 1;
  numbers('two')  := 2;
  numbers('three') := 3;
  numbers('four') := 4;
  numbers('five') := 5;

  -- printing the table
  -- the array is auto sorted based on the index (varchar)
  num := numbers.FIRST;
  WHILE num IS NOT null LOOP
    dbms_output.put_line
    (num || ' is ' || TO_CHAR(numbers(num)));
    num := numbers.NEXT(num);
  END LOOP;
END;
/
DECLARE
   r1 rectangle;
   r2 rectangle;
   r3 rectangle;
   inc_factor number := 5;
BEGIN
   r1 := rectangle(3, 4);
   r2 := rectangle(5, 7);
   r3 := r1.enlarge(inc_factor);
   dbms_output.put_line('--- Displaying r3 ---');
   r3.display;

   -- the measure function is used to compare objects
   IF (r1 > r2) THEN -- the > operator uses the measure function
      dbms_output.put_line('--- Displaying r1 ---');
      r1.display;
   ELSE
      dbms_output.put_line('--- Displaying r2 ---');
      r2.display;
   END IF;
END;
/
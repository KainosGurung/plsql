DECLARE
  x INTEGER;
  y INTEGER;
  maxx constant INTEGER := 50;
  flag integer;
BEGIN

  << outer_loop >>
  FOR x IN 2 .. maxx loop --Go from 2 to max inclusive. One is not a prime
    
    flag := 0; --reset the flag
    
    << inner_loop >>
    FOR y IN REVERSE 2 .. x-1 loop --Go from x-1 down to 2, x%x=0 so we skip it
    
      
      IF (mod(x,y) = 0) THEN --Take the mod, if the remainder is 0, then we have found a factor
        flag := 1; --set the flag and exit the inner loop
        EXIT;
      END IF;
      
    END loop inner_loop;
    
    IF (flag = 0) THEN --if the flag was never set, then we found a prime
      dbms_output.put_line(x);
    END IF;
    
  END loop outer_loop;
END; 
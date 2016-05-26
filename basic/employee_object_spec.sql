CREATE OR REPLACE TYPE BODY employee AS
  MEMBER FUNCTION get_name RETURN VARCHAR2 IS
  BEGIN
    RETURN concat(concat(fname, ' '), lname);
  END;
  
  
  MEMBER FUNCTION validate_age RETURN VARCHAR2 IS
  BEGIN
    IF (age > 21) THEN
      return 'You are old enough';
    ELSE
      return 'You are too young';
    END IF;
  END;
  
END;
/
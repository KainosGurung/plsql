--Updating the salay using the guide (tale data editor)
--does not fire the trigger
CREATE OR REPLACE TRIGGER salary_trigger
AFTER INSERT OR UPDATE OF salary ON customers
FOR EACH ROW
WHEN (NEW.ID > 0)
DECLARE
   sal_diff number;
BEGIN
   sal_diff := :NEW.salary  - :OLD.salary;
   dbms_output.put_line('Salary for ID: ' || :OLD.id);
   dbms_output.put_line('Old salary: ' || :OLD.salary);
   dbms_output.put_line('New salary: ' || :NEW.salary);
   dbms_output.put_line('Salary difference: ' || sal_diff);
END;
/
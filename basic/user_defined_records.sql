DECLARE
  TYPE book IS record
    (isbn INTEGER,
    title VARCHAR(50),
    author VARCHAR(50));
  book1 book;
  
BEGIN
  book1.isbn := 1;
  book1.title := 'C++ programming guide';
  book1.author := 'Bjourn Stroopse';
  
  dbms_output.put_line('isbn ' || book1.isbn);
  dbms_output.put_line('title ' || book1.title);
  dbms_output.put_line('author ' || book1.author);
END;
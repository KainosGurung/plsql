CREATE OR REPLACE PACKAGE word_count_midterm_package
AS
  FUNCTION generatepassword(
      n IN NUMBER,
      m IN NUMBER)
    RETURN VARCHAR2;
    
    procedure displayFrequencyReport(bookid in m_books.id%type);
END;
/
CREATE OR REPLACE PACKAGE BODY word_count_midterm_package
AS
  FUNCTION generatepassword(
      n IN NUMBER,
      m IN NUMBER)
    RETURN VARCHAR2
  IS
TYPE wordids_type
IS
  TABLE OF m_words.ID%TYPE INDEX BY binary_integer;
  wordids wordids_type;
TYPE random_nums_type
IS
  TABLE OF binary_integer INDEX BY binary_integer;
  random_nums_array random_nums_type;
  wordids_size binary_integer;
  random_num binary_integer;
  loop_var binary_integer;
  pass VARCHAR2(1000);
  word VARCHAR2(100);
BEGIN
  SELECT wordid bulk collect --get all the ids of the unique words and store into an array
  INTO wordids
  FROM m_wordcounts
  WHERE wordid IN
    (SELECT wordid
    FROM
      (SELECT wordid,
        COUNT(wordid)
      FROM m_wordcounts
      GROUP BY wordid
      HAVING COUNT(wordid) = 1
      )
    )
  AND wordid NOT IN
    (SELECT wordid FROM m_stopwords
    )
  AND COUNT     = 1;
  wordids_size := wordids.count + 1;
  --generate n unique random numbers between 1 and the size of the unique word array
  --that is going to be used to index the unique word array
  WHILE (random_nums_array.count != n)
  LOOP
    SELECT TRUNC(dbms_random.VALUE(1, wordids_size)) INTO random_num FROM dual;
    random_nums_array(random_num) := random_num;
  END LOOP;
  
  --loop through the generated indexes and retrieve the word associated with that id
  loop_var       := random_nums_array.FIRST;
  WHILE loop_var IS NOT NULL
  LOOP
    SELECT word INTO word FROM m_words WHERE ID = loop_var;
    pass := pass || word;
    --generate random numbers and append it to the password after each word
    FOR i IN 1 .. m
    LOOP
      SELECT TRUNC(dbms_random.VALUE(0, 9)) INTO random_num FROM dual;
      pass := pass || TO_CHAR(random_num);
    END LOOP;
    loop_var := random_nums_array.next(loop_var);
  END LOOP;
  dbms_output.put_line(pass);
  RETURN pass;
END;

PROCEDURE displayfrequencyreport(bookid IN m_books.ID%TYPE) IS
TYPE book_query_ref_cursor
IS
  REF
  CURSOR;
    book_query_cursor book_query_ref_cursor;
  TYPE words_count_table_type
IS
  TABLE OF binary_integer INDEX BY binary_integer;
  words_count_table words_count_table_type;
TYPE words_table_type
IS
  TABLE OF VARCHAR2(100) INDEX BY binary_integer;
  words_table words_table_type;
  bk_id binary_integer  := bookid;
  loop_var binary_integer;
  inner_loop_var binary_integer;
  word_count binary_integer;
  words_in_group binary_integer;
  myword VARCHAR2(100);
BEGIN

  OPEN book_query_cursor FOR SELECT cnt, COUNT(cnt) FROM
  (SELECT wordid,
    SUM(COUNT) AS cnt
  FROM m_wordcounts
  WHERE bookid = case when bk_id > 0 then bk_id else bookid end
  GROUP BY wordid
  ) GROUP BY cnt ;

  dbms_output.put_line(rpad('Word Count', 15) || rpad('# of Words in group', 25) || 'Words (at most 4)');
  dbms_output.put_line('----------     -------------------      -----------------');
LOOP
  FETCH book_query_cursor INTO word_count, words_in_group;
  EXIT
WHEN book_query_cursor%notfound;
  words_count_table(word_count) := words_in_group;
END LOOP;
CLOSE book_query_cursor;
loop_var       := words_count_table.LAST;
WHILE loop_var IS NOT NULL
loop
  dbms_output.put(rpad(loop_var, 15) || rpad(words_count_table(loop_var),25));
  SELECT word bulk collect
  INTO words_table
  FROM m_words
  WHERE id IN
    (SELECT wordid
    FROM
      (SELECT wordid,
        cnt,
        rownum AS rn
      FROM
        (SELECT wordid,
          SUM(COUNT) AS cnt
        FROM m_wordcounts
        WHERE bookid = case when bk_id > 0 then bk_id else bookid end
        GROUP BY wordid
        HAVING SUM(COUNT) = loop_var
        )
      )
    WHERE rn <= 4
    );
  inner_loop_var       := words_table.FIRST;
  WHILE inner_loop_var IS NOT NULL
  loop
    dbms_output.put( rpad(words_table(inner_loop_var),20));
    inner_loop_var := words_table.next(inner_loop_var);
  END LOOP;
  dbms_output.new_line();
  words_table.delete; --clear the table
  loop_var := words_count_table.PRIOR(loop_var);
END LOOP;
END;
  END word_count_midterm_package;
/

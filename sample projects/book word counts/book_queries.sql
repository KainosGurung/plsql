--How many unique words are there across all books? Note that to be unique, a word must only appear once.
SELECT COUNT(*)
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
AND count = 1;


--How many unique words are there per book? Design your query to display the results ordered
--alphabetically by book title.
SELECT bookid, --unique words per book (not unique across all books)
  COUNT(bookid) AS "Unique Words"
FROM
  ( SELECT * FROM m_wordcounts WHERE COUNT = 1
  )
GROUP BY bookid;

SELECT bookid,
  COUNT(bookid) AS "Unique Words" --unique words per book across all books
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
AND COUNT = 1
GROUP BY bookid;



--What are the top eight most frequently occurring words across all books? Design your query
--to display the results in order starting from the most frequently occurring word.
SELECT *
FROM
  (SELECT wordid,
    SUM(COUNT) AS word_count
  FROM m_wordcounts
  GROUP BY wordid
  ORDER BY word_count DESC
  )
WHERE rownum <= 40;


--How many unique words are there per author? How many unique words are there per editor?
--design your QUERY TO combine THE above results AND display THE results ORDERED alphabetically
--by author/editor name.
SELECT author         AS "Author/Editor",
  SUM("Unique Words") AS "count"
FROM
  (SELECT b.author,
    w."Unique Words"
  FROM m_books b
  INNER JOIN
    (SELECT bookid,
      COUNT(bookid) AS "Unique Words" --unique words per book across all books
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
    AND COUNT = 1
    GROUP BY bookid
    ) w
  ON b.ID         = w.bookid
  WHERE b.author IS NOT NULL
  )
GROUP BY author
UNION
SELECT editor         AS "Author/Editor",
  SUM("Unique Words") AS "count"
FROM
  (SELECT b.editor,
    w."Unique Words"
  FROM m_books b
  INNER JOIN
    (SELECT bookid,
      COUNT(bookid) AS "Unique Words" --unique words per book across all books
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
    AND COUNT = 1
    GROUP BY bookid
    ) w
  ON b.ID         = w.bookid
  WHERE b.editor IS NOT NULL
  )
GROUP BY editor ;


--What is the percentage of word counts to total unique words per book? For example, if a
--word occurs 47 times IN A WORK that contains 4700 UNIQUE words, THE percentage FOR this word
--is 1%.
SELECT w.bookid, w.wordid, w.count, u."Unique Words", (w.count / u."Unique Words")*100 AS "Percentage"  
from m_wordcounts w inner join
(
SELECT bookid, --unique words per book (not unique across all books)
  COUNT(bookid) AS "Unique Words"
FROM
  ( SELECT * FROM m_wordcounts WHERE COUNT = 1
  )
GROUP BY bookid)
u ON w.bookid = u.bookid;


--Write a single SQL query that inserts rows into the (assumed-to-be-empty) m_stopwords
--table by selecting the top 20 most frequently occurring words across all books  
INSERT INTO m_stopwords
  (wordid
  )
SELECT wordid
FROM
  (SELECT *
  FROM
    (SELECT wordid,
      SUM(COUNT) AS word_count
    FROM m_wordcounts
    GROUP BY wordid
    ORDER BY word_count DESC
    )
  WHERE ROWNUM <= 20
  );

--Taking stopwords from the m_stopwords table into account, write an SQL query that selects
--THE top 20 most frequently occurring words across ALL books, i.e., IGNORE stopwords. be sure
--you do NOT DELETE OR CHANGE ANY OF THE existing TABLES OR their DATA (i.e, do NOT simply DELETE
--stopwords from m_wordcounts).
SELECT *
FROM
  (SELECT wordid,
    SUM(COUNT) AS word_count
  FROM m_wordcounts
  where wordid not in (select wordid from m_stopwords)
  GROUP BY wordid
  ORDER BY word_count DESC
  )
WHERE rownum <= 20;


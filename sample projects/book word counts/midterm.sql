create table m_books
(
  id integer,
  title varchar(200),
  author varchar(100),
  editor varchar(100),
  isbn varchar(40),
  year integer,
  url varchar(200)
);

create table m_counts
(
  bookid integer,
  totalwords integer,
  pages integer
);

create table m_words
(
  id integer,
  word varchar(80)
);

create table m_wordcounts
(
  bookid integer,
  wordid integer,
  count integer
);

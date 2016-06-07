--How many words start or end with the letter 'g' (only show the count)?
SELECT count(*) FROM ospd_words WHERE word LIKE '%g' OR word LIKE 'g%';


--How many four-letter words are there in the dataset?
SELECT count(*) FROM ospd_words WHERE LENGTH(word) = 4;


select * from ospd_words where word like '%w%' and word like '%x%';


select * from ospd_words where REGEXP_LIKE(word, '[a-t|v-z]');


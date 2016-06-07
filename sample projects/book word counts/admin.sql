TRUNCATE TABLE bk_locations_clean;
TRUNCATE table bk_locations_unresolved;

execute bk_data_cleanup.clean_bk_locations;

SELECT count(*) FROM bk_locations_clean
UNION ALL
SELECT count(*) FROM bk_locations_unresolved
UNION ALL
SELECT count(*) FROM burger_king_locations;



select * from (SELECT t.*, ROWNUM as rn FROM zip_db t) where rn = 3000;




SELECT cnt AS "word count", count(cnt) AS "# Words in group" FROM (
SELECT wordid, sum(count) AS cnt FROM m_wordcounts where bookid = 1 GROUP BY wordid
) GROUP BY cnt ORDER BY cnt DESC
;


SELECT cnt AS "word count", count(cnt) AS "# Words in group" FROM (
SELECT wordid, sum(count) AS cnt FROM m_wordcounts where bookid = 1 GROUP BY wordid
) GROUP BY cnt ORDER BY cnt DESC
;




select word from m_words where id in (select wordid from (
select wordid, cnt, rownum as rn from (
SELECT wordid, sum(count) AS cnt FROM m_wordcounts WHERE bookid = 1 GROUP BY wordid
HAVING sum(count) = 1))
WHERE rn <= 4);


select * from m_words where word like 'ffffff';
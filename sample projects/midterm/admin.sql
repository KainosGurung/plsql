TRUNCATE TABLE bk_locations_clean;
TRUNCATE table bk_locations_unresolved;

execute bk_data_cleanup.clean_bk_locations;

SELECT count(*) FROM bk_locations_clean
UNION ALL
SELECT count(*) FROM bk_locations_unresolved
UNION ALL
SELECT count(*) FROM burger_king_locations;


execute bk_data_cleanup.clean_zip_db;

select * from zip_db where rownum = 2433;
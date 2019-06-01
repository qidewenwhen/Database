
/* 1 MOVIES */
SELECT COUNT(*) AS Movies_count FROM Movies;

/* 2 GENRES */
SELECT COUNT(*) AS Genres_count FROM (SELECT DISTINCT g.genres FROM Genres g);

SELECT COUNT(*) AS Genres_rows_num FROM Genres g;

/* 3 TAGS */
SELECT COUNT(*) AS Tag_count FROM Tags;

SELECT COUNT(*) AS MovieTag_rows_num FROM MovieTag;

/* 4 COUNTRIES */
SELECT COUNT(*) AS Country_count FROM (SELECT DISTINCT mc.country FROM MovieCountry mc);

SELECT COUNT(*) AS MovieCountry_rows_num FROM MovieCountry;


/* 5 LOCATIONS */
SELECT COUNT(*) AS MovieLocation_rows_num FROM MovieLocation;


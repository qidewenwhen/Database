SELECT M.Title, (MAX(R.Stars) - MIN(R.Stars)) AS Rating_span
FROM Review_table R, Movie_table M                   
WHERE M.Serial_No = R.Movie_ID
GROUP BY R.Movie_ID, M.Title
ORDER BY Rating_span DESC, M.Title;


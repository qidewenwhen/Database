SELECT D.First_name || ' ' || D.Last_name AS Full_name, M.Title, M.Rlease_year AS Year
FROM Movie_table M, Director_table D, Movie_Genre_table MG
WHERE M.Director_ID = D.ID AND M.Serial_No = MG.Movie_ID AND MG.Genre = 'Drama' AND MOD(M.Rlease_year, 4) = 0;

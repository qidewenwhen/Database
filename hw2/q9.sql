CREATE TABLE Temp AS 
        SELECT R.Movie_ID, SUM(R.Stars) / COUNT(*) AS Average_rating
        FROM Review_table R
        GROUP BY R.Movie_ID;

SELECT N1.Average_before2005, N2.Average_after2005, ABS(N1.Average_before2005 - N2.Average_after2005) AS Difference
FROM (  SELECT SUM(T1.Average_rating) / COUNT(M1.Serial_No) AS Average_before2005
        FROM Movie_table M1, Temp T1
        WHERE M1.Serial_No = T1.Movie_ID AND M1.Rlease_year < 2005) N1,
     (  SELECT SUM(T2.Average_rating) / COUNT(M2.Serial_No) AS Average_after2005
        FROM Movie_table M2, Temp T2
        WHERE M2.Serial_No = T2.Movie_ID AND M2.Rlease_year >= 2005) N2;

DROP TABLE Temp;
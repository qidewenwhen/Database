CREATE TABLE New_table AS 
    (SELECT MC.Person_ID AS ID, COUNT(*) AS Count
    FROM Movie_Cast_table MC, Movie_table M, Director_table D
    WHERE MC.Movie_ID = M.Serial_No AND M.Director_ID = D.ID AND D.First_name = 'Steven' AND D.Last_name = 'Spielberg'
    GROUP BY MC.Person_ID);


SELECT A.ID, A.First_name, A.Last_name, A.DOB AS Birthday, A.Gender, A.Birth_T AS Birthplace
FROM Actor_table A,  New_table N 
WHERE A.ID = N.ID AND N.Count = (   SELECT MAX(N2.Count) 
                                    FROM New_table N2
                                );
DROP TABLE New_table;
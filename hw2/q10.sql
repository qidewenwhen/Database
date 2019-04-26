CREATE TABLE Onejump_ID AS 
        SELECT DISTINCT MC.Person_ID
        FROM Movie_Cast_table MC
        WHERE MC.Movie_ID IN (  SELECT MC2.Movie_ID
                                FROM Actor_table A, Movie_Cast_table MC2
                                WHERE A.ID = MC2.Person_ID AND A.First_name = 'Matt' AND A.Last_name = 'Damon');

SELECT DISTINCT A.ID, A.First_name, A.Last_name, A.DOB AS Birthday, A.Gender, A.Birth_T AS Birthplace
FROM Actor_table A, Movie_Cast_table MC2
WHERE A.ID = MC2.Person_ID 
        AND MC2.Movie_ID IN (SELECT DISTINCT MC.Movie_ID
                            FROM Movie_Cast_table MC
                            WHERE MC.Person_ID IN (SELECT O.Person_ID FROM Onejump_ID O))
        AND A.ID NOT IN (SELECT A2.ID 
                        FROM Actor_table A2
                        WHERE A2.First_name = 'Matt' AND A2.Last_name = 'Damon')
        AND A.ID NOT IN (SELECT O2.Person_ID FROM Onejump_ID O2);

DROP TABLE Onejump_ID;


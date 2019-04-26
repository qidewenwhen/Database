-- Assumption:
-- The 'actors' refer to both male and female actors here.

SELECT A.ID, A.First_name, A.Last_name, A.DOB AS Birthday, A.Gender, A.Birth_T AS Birthplace
FROM Actor_table A
WHERE A.ID IN ( SELECT MC.Person_ID
                FROM Movie_Cast_table MC, Movie_table M
                WHERE MC.Movie_ID = M.Serial_No 
                GROUP BY MC.Person_ID
                HAVING COUNT(DISTINCT(M.Director_ID)) >= 4);
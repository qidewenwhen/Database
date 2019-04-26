-- Assumption:
-- 1. "Actors" refer to both female and male actors here.
-- 2. Those actors, who act in less or equal to one movie, will not be taken into account here.

SELECT A.ID, A.First_name, A.Last_name, A.DOB AS Birthday, A.Gender, A.Birth_T AS Birthplace
FROM Actor_table A 
WHERE A.ID IN ( SELECT MC.Person_ID
                FROM Movie_Cast_table MC
                GROUP BY MC.Person_ID
                HAVING COUNT(*) > 1)
INTERSECT 
SELECT A.ID, A.First_name, A.Last_name, A.DOB AS Birthday, A.Gender, A.Birth_T AS Birthplace
FROM Actor_table A 
WHERE NOT EXISTS ( SELECT *
                    FROM  Movie_table M1, Movie_Cast_table MC1, Movie_table M2, Movie_Cast_table MC2
                    WHERE   M1.Serial_No = MC1.Movie_ID AND M2.Serial_No = MC2.Movie_ID AND
                            MC1.Person_ID = A.ID  AND MC2.Person_ID = A.ID  AND
                            M1.Rlease_year - M2.Rlease_year > 2 AND
                             NOT EXISTS (SELECT *
                                        FROM Movie_table M3, Movie_Cast_table MC3
                                        WHERE M3.Serial_No = MC3.Movie_ID AND MC3.Person_ID = A.ID  AND M1.Rlease_year > M3.Rlease_year AND M3.Rlease_year > M2.Rlease_year));

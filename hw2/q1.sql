SELECT DISTINCT A.First_name, A.Last_name
FROM Movie_table M, Movie_Cast_table MA, Actor_table A
WHERE M.Serial_No = MA.Movie_ID AND MA.Person_ID = A.ID AND M.Title LIKE '%Star Wars%';
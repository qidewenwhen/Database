SELECT DISTINCT AF.First_name || ' ' || AF.Last_name AS Actress_fullname, AM.First_name || ' ' || AM.Last_name AS Actor_fullname, COUNT(*) AS Movie_count
FROM Actor_table AF, Actor_table AM, Movie_Cast_table MCF, Movie_Cast_table MCM
WHERE AF.ID = MCF.Person_ID AND MCF.Movie_ID = MCM.Movie_ID AND AM.ID = MCM.Person_ID AND AF.Gender = 'F'AND AM.Gender = 'M'
GROUP BY AF.ID, AF.First_name, AF.Last_name, AM.ID, AM.First_name, AM.Last_name
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;
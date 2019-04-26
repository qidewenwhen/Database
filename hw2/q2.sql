SELECT D.First_name, D.Last_name, COUNT(*) AS MCount
FROM Movie_table M, Director_table D
WHERE M.Director_ID = D.ID
GROUP BY D.ID, D.First_name, D.Last_name
HAVING COUNT(*) >= 5 
ORDER BY COUNT(*) DESC;


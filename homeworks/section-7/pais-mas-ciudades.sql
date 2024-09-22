-- Quiero que me muestren el país con más ciudades
-- Campos: total de ciudades y el nombre del país
-- usar INNER JOIN

SELECT count(*) as total, b.name as country
FROM city a
INNER JOIN country b on a.countrycode = b.code
GROUP BY b.name
ORDER BY count(*) DESC
LIMIT 1;


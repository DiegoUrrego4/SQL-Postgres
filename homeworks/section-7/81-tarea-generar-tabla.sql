-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa

-- Cons esto obtengo todos los continentes que no hacen parte de America
-- Mi solución:
SELECT COUNT(*) AS total_countries, b.name
FROM country a
         INNER JOIN continent b ON a.continent = b.code
WHERE b.name NOT LIKE '%America%'
GROUP BY b.name
UNION
SELECT SUM(number_of_countries) AS total_countries, 'America'
FROM (SELECT COUNT(*) AS number_of_countries -- Acá obtengo únicamente los continentes que hacen parte de America
      FROM country a
               INNER JOIN continent b ON a.continent = b.code
      WHERE b.name LIKE '%America%'
      GROUP BY b.name) AS america_countries_count
ORDER BY total_countries, name;

-- La solución del docente:
SELECT COUNT(*) AS total, b.name
FROM country a
         INNER JOIN continent b ON a.continent = b.code
WHERE b.name NOT LIKE '%America%'
GROUP BY b.name
UNION
(SELECT COUNT(*) AS total, 'America'
 FROM country a
          INNER JOIN continent b ON a.continent = b.code
 WHERE b.name LIKE '%America%')
ORDER BY total;
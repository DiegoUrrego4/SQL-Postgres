-- Clausula UNION; Muy util para unir resultados en un solo result set
SELECT *
FROM continent
WHERE name LIKE '%America%'
UNION
SELECT *
FROM continent
WHERE code IN (3, 5)
ORDER BY name ASC;
-- Las queries son diferentes, pero salen en una misma consulta
-- IMPORTANTE: Deben hacer match tanto los tipos como las columnas, de lo contrario obtendremos un error.


-- Unión de tablas usando WHERE (NO recomendado)
SELECT a.name AS country, b.name AS continent
FROM country a,
     continent b
WHERE a.continent = b.code
ORDER BY b.name ASC;

-- Unión de tablas usando JOIN (Recomendado)
-- INNER JOIN
SELECT a.name AS country, b.name AS continent
FROM country a
         INNER JOIN continent b ON a.continent = b.code
ORDER BY a.name;

-- Alterar secuencias
ALTER SEQUENCE continent_code_seq RESTART WITH 9;

-- TAREA: country a - name, continent
-- continent b - name (poner alias)
-- hacerlo con un FUL OUTER JOIN
SELECT a.name AS country_name, a.continent, b.name AS country_continent
FROM country a
         FULL OUTER JOIN continent b ON a.continent = b.code
ORDER BY a.name DESC;

-- RIGHT OUTER JOIN (con exclusión): Todos los continentes que no tienen registros en nuestra tabla de países
SELECT b.name AS country_continent
FROM country a
         RIGHT OUTER JOIN continent b ON a.continent = b.code
WHERE a.continent IS NULL
ORDER BY a.name DESC;

-- Aggregations + JOINS
SELECT COUNT(*) AS count, b.name
FROM country a
         INNER JOIN continent b ON a.continent = b.code
GROUP BY b.name -- Este primer query excluye a los continentes que no tienen un país asociado
UNION
SELECT 0 AS count, b.name -- Todos los continentes que NO tienen país
FROM country a
         RIGHT JOIN continent b ON a.continent = b.code
WHERE a.continent IS NULL
GROUP BY b.name -- Este segundo query muestra solo los continentes que NO tienen un país asociado
ORDER BY count; -- Ordenamos por el alias (que debe ser el mismo en ambas consultas del count);


-- Quiero saber los idiomas oficiales que se hablan por continente
SELECT *
FROM countrylanguage WHERE isofficial = true;

SELECT *
FROM country;

SELECT *
FROM continent;

SELECT DISTINCT a.language, c.name
FROM countrylanguage a
INNER JOIN country b on a.countrycode = b.code
INNER JOIN continent c ON b.continent = c.code
WHERE isofficial = true;

-- Cuantos idiomas oficiales se habla por continentes
SELECT count(*), continent FROM
(SELECT DISTINCT a.language, c.name as continent
FROM countrylanguage a
INNER JOIN country b on a.countrycode = b.code
INNER JOIN continent c ON b.continent = c.code
WHERE isofficial = true) as totales
GROUP BY continent
ORDER BY count(*);

SELECT DISTINCT a.language, d.name, c.name
FROM countrylanguage a
INNER JOIN country b on a.countrycode = b.code
INNER JOIN continent c ON b.continent = c.code
INNER JOIN language d ON d.code = a.languagecode
WHERE isofficial = true;
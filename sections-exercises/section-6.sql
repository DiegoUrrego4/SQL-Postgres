-- Todos los continentes presentes en tabla country
SELECT DISTINCT continent
FROM country
ORDER BY continent ASC;

-- Inserción de registros en tabla continent
INSERT INTO continent (name)
SELECT DISTINCT continent
FROM country
ORDER BY continent ASC;

-- Volcado de información
INSERT INTO country_bk
SELECT *
FROM country;

-- Actualización masiva
SELECT a.name,
       a.continent,
       (SELECT b.code FROM continent b WHERE b.name = a.continent)
FROM country a;

UPDATE country a
SET continent = (SELECT b.code FROM continent b WHERE b.name = a.continent);

-- Modificar tipo columna
ALTER TABLE country
    ALTER COLUMN continent TYPE INTEGER;
-- Introducción a las relaciones
-- Tipos:
-- Uno a uno: One to one
-- Uno a muchos: One to many
-- Relaciones a sí mismas: Self joining relationships
-- Muchos a muchos: Many to many

-- LLaves - Keys
-- Para que las relaciones de BB DD sean posibles se necesitan llaves
-- Las llaves nos permiten tener una integridad referencial.
-- Tipos:
-- Primary Key: Identifica un registro de forma única. Una tabla puede tener varios identificadores únicos. La llave primaria está basada en los requerimientos
-- Super Key: Conjunto de atributos que puede identificar de forma única. Es un superconjunto de una clave candidata (combinación de campos)
-- Candidate Key: Un atributo o conjunto de ellos que identifica de forma única un registro
-- Foreign Key: Son usadas para apuntar a la llave primaria de otra tabla
-- Composite Key: Cuando una clave primaria consta de más de un atributo se conoce como llave compuesta
-- Hay más, y todas las llaves sirven para identificar registros. Entre otras: Alternate keys, Artificial Keys


-- Agregar una primary key (manualmente)
ALTER TABLE country
    ADD PRIMARY KEY (code);

SELECT *
FROM country
WHERE continent = 'Africa';

-- Agregar constrains
ALTER TABLE country
    ADD CHECK ( surfacearea >= 0 );

SELECT DISTINCT continent
FROM country;

ALTER TABLE country
    ADD CHECK (
        (continent = 'Asia') OR
        (continent = 'North America') OR
        (continent = 'Central America') OR
        (continent = 'South America') OR
        (continent = 'Oceania') OR
        (continent = 'Antarctica') OR
        (continent = 'Africa') OR
        (continent = 'Europe')
        );

-- Para borrar un constraint
ALTER TABLE country
    DROP CONSTRAINT country_continent_check;

SELECT *
FROM country
WHERE code = 'CRI';

UPDATE country
SET continent = 'Central America'
WHERE code = 'CRI';

-- índices -> Ayuda a identificar registros
CREATE INDEX "country_continent" ON country (continent);

-- Unique index, problemas de la vida real
CREATE UNIQUE INDEX "unique_name_countrycode_district" ON city (name, countrycode, district);

SELECT *
FROM city
WHERE name = 'Jinzhou'
  AND countrycode = 'CHN'
  AND district = 'Liaoning';

CREATE INDEX "index_district" ON city (district);

-- Creación de llaves foráneas
ALTER TABLE city
    ADD CONSTRAINT fk_country_code FOREIGN KEY (countrycode) REFERENCES country (code); -- ON DELETE CASCADE

-- País faltante
INSERT INTO country
		values('AFG', 'Afghanistan', 'Asia', 'Southern Asia', 652860, 1919, 40000000, 62, 69000000, NULL, 'Afghanistan', 'Totalitarian', NULL, NULL, 'AF');

ALTER TABLE countrylanguage
    ADD CONSTRAINT fk_country_code FOREIGN KEY (countrycode) REFERENCES country (code); -- ON DELETE CASCADE

-- Eliminación en cascada
SELECT *
FROM country WHERE code = 'AFG';
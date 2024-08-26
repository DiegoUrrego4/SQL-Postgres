-- Mi primera tabla
CREATE TABLE "users"
(
    name VARCHAR(10) UNIQUE
);


-- Inserciones
INSERT INTO "users" -- Acá podríamos especificar los nombres de las columnas o directamente que se infiera
VALUES ('Diego2'),
       ('Diego3'),
       ('Diego4'),
       ('Ricardo');

-- Actualizaciones
UPDATE users
SET name='Alberto'
WHERE name = 'Diego';

-- Selección de registros (sin where)
SELECT *
FROM users
LIMIT 2 OFFSET 2;

-- Clausula where
SELECT *
FROM users
WHERE name LIKE '_ie%'; -- Estas sentencias LIKE pueden ser lentas

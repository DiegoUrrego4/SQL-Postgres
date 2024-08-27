-- Mi primera tabla
CREATE TABLE "users"
(
    name VARCHAR(10) UNIQUE
);


-- Inserciones
INSERT INTO "users" -- Acá podríamos especificar los nombres de las columnas o directamente que se infiera
VALUES ('Diego1'),
       ('Diego2'),
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
WHERE name LIKE '_ie%';
-- Estas sentencias LIKE pueden ser lentas

-- Eliminaciones
DELETE
FROM users
WHERE name LIKE '_ie%';

-- DROP vs TRUNCATE
DROP TABLE users; -- Comando destructivo. La tabla se borra completamente
TRUNCATE TABLE users;
-- Se purgan los registros, pero la tabla seguirá existiendo

-- Operadores de strings y funciones
SELECT id,
       UPPER(name)                  AS upper_name,
       LOWER(name)                  AS lower_name,
       LENGTH(name)                 AS name_length,
       (20 * 2)                     AS constante,
       CONCAT(id, ' * ', name, ' * '),
       id || ' * ' || name || ' * ' AS bar_code,
       name
FROM users;

-- Substring y position
SELECT name,
       SUBSTRING(name, 0, 5), -- El último valor es excluyente
       POSITION(' ' IN name),
       SUBSTRING(name, 0, POSITION(' ' IN name)) AS first_name,
       SUBSTRING(name, POSITION(' ' IN name) + 1) AS last_name -- El primer valor es incluyente
FROM users;


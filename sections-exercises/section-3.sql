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

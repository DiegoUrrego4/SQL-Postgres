CREATE TABLE users
(
    user_id  SERIAL PRIMARY KEY, -- Esto asigna valores en forma correlativa y sucesiva
    username VARCHAR
);

CREATE TABLE users2
(
    user_id  INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Esto asigna valores en forma correlativa y sucesiva
    username VARCHAR
);

CREATE TABLE users3
(
    user_id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- Esto asigna valores PERO NO permite asignar valores más arriba o abajo de la secuencia
    username VARCHAR
);

CREATE TABLE users4
(
    user_id  INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 100 INCREMENT BY 2) PRIMARY KEY, -- Esto asigna valores con un inicio y un incremento asignado, en este caso de a 2 en 2 e iniciando en 100
    username VARCHAR
);

-- Llave primaria compuesta
CREATE TABLE usersDual
(
    id1 INT,
    id2 INT,
    PRIMARY KEY (id1, id2) -- La combinación de los campos será la llave primaria
);

-- UUIDs
-- Crear extensiones (Para usar versiones espécificas de UUIDs)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Generar uuid random (sin versión), Generar uuid con la v4
SELECT gen_random_uuid(), uuid_generate_v4();

-- Para eliminar funciones como las de generación de uuids
DROP EXTENSION "uuid-ossp";


CREATE TABLE users5
(
    user_id  uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    username VARCHAR
);

-- Secuencias
-- Creación
CREATE SEQUENCE user_sequence;
-- Eliminación
DROP SEQUENCE user_sequence;

SELECT NEXTVAL('user_sequence'); -- Cada vez que esto es invocado la secuencia aumenta en 1
SELECT NEXTVAL('user_sequence'), CURRVAL('user_sequence');
-- De esta forma podemos obtener el valor actual de la secuencia sin aumentar la secuencia
-- NOTA: Esto NO nos protege de que el usuario pueda insertar valores en la secuencia a su antojo

CREATE TABLE users6
(
    user_id  INTEGER PRIMARY KEY DEFAULT NEXTVAL('user_sequence'),
    username VARCHAR
);

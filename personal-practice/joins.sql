-- CONCEPTOS IMPORTANTES A TENER EN CUENTA
-- FK: Foreign Keys. Se usan para establecer relaciones entre tablas
-- Tipos de relaciones:
-- Uno a muchos(1:N)
-- Ejemplo, un equipo tiene muchos jugadores, peor un jugador solo puede tener un equipo
-- En este caso, la FK debe estar en la tabla del lado "muchos"
-- ¿Cómo saber dónde poner la Foreign Key?
--
-- 	1.	Uno a Muchos: La Foreign Key va en la tabla del lado “Muchos” (e.g., Jugadores tiene equipo_id como Foreign Key de Equipos).
-- 	2.	Muchos a Muchos: Se crea una tabla intermedia que contiene Foreign Keys de ambas tablas (e.g., Estudiantes_Cursos).
-- 	3.	Uno a Uno: Puedes poner la Foreign Key en cualquiera de las dos tablas o ambas, dependiendo de cómo quieras estructurarlo.


-- Creación de tablas ejemplos
CREATE TABLE "jugadores"
(
    id_jugador SERIAL NOT NULL PRIMARY KEY ,
    nombre     VARCHAR(20),
    equipo_id  int8
);

CREATE TABLE "equipos"
(
    id_equipo SERIAL NOT NULL PRIMARY KEY ,
    nombre_equipo VARCHAR(50)
);

-- Inserción de datos
INSERT INTO "jugadores" (nombre, equipo_id) VALUES ('Jude Bellingham', 1),
                                        ('Vinícius Júnior', 1),
                                        ('Luka Modrić', 1),
                                        ('Robert Lewandowski', 2),
                                        ('Frenkie de Jong', 2),
                                        ('Gavi', 2),
                                        ('Mohamed Salah', 3),
                                        ('Virgil van Dijk', 3),
                                        ('Trent Alexander-Arnold', 3),
                                        ('Erling Haaland', 4),
                                        ('Phil Foden', 4),
                                        ('Kevin De Bruyne', 4);

INSERT INTO "equipos" (nombre_equipo) VALUES ('Real madrid'),
                                             ('FC Barcelona'),
                                             ('Liverpool'),
                                             ('Manchester City');

-- INNER JOIN: Este tipo de JOIN retorna las filas que tienen coincidencia en ambas tablas.
SELECT a.nombre, b.nombre_equipo
FROM jugadores a
INNER JOIN equipos b ON a.equipo_id = b.id_equipo;

-- LEFT JOIN (Unión izquierda): Este JOIN retorna todas las filas de la tabla de la izquierda (Jugadores), aunque no tengan coincidencia en la derecha. Si no hay coincidencia, se rellenan con NULL.
SELECT a.nombre, b.nombre_equipo
FROM jugadores a -- Esta tabla sería la columna de la "izquierda"
LEFT JOIN equipos b ON a.equipo_id = b.id_equipo;

-- RIGHT JOIN (Unión derecha): Este JOIN retorna todas las filas de la tabla de la derecha (Equipos), aunque no haya coincidencia en la izquierda. Si no hay coincidencia, se rellenan con NULL.
SELECT a.nombre, b.nombre_equipo
FROM jugadores a -- Esta tabla sería la columna de la "izquierda"
RIGHT JOIN equipos b ON a.equipo_id = b.id_equipo; -- Equipos sería la tabla de la "derecha"

-- FULL OUTER JOIN (Unión externa completa): Este JOIN retorna todas las filas de ambas tablas. Si no hay coincidencia, se rellenan con NULL.
SELECT a.nombre, b.nombre_equipo
FROM jugadores a -- Esta tabla sería la columna de la "izquierda"
FULL OUTER JOIN equipos b ON a.equipo_id = b.id_equipo; -- Equipos sería la tabla de la "derecha"
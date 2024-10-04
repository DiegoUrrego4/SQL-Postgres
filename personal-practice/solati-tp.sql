-- Para las pruebas de las consultas, tendré que eliminar y modificar registros iniciales, así que lo más probable es que deba hacer la creación de las tablas varias veces.
-- Para ello y no tener que borrar las tablas manualmente y una a una lo haré al correr el archivo
DROP TABLE IF EXISTS empleado; -- Borro primero esta porque de esta tabla no depende ninguna otra tabla, a diferencia de departamento.
DROP TABLE IF EXISTS departamento;


-- Creación de las tablas
CREATE TABLE empleado
(
    codigo_c  VARCHAR(20) PRIMARY KEY NOT NULL, -- Esto podría haber sido de 16 según el ejercicio proporcionado, pero prefiero asegurar
    nombre    VARCHAR(50)             NOT NULL,
    edad      int8    DEFAULT 0,                -- Esto podría haber sido perfectamente un "integer" pero el rango sería demásiado alto para almacenar edades, por eso preferí TINYINT que va desde -127 a 128 (-2,147,483,648 a 2,147,483,647) -> integer
    oficio    VARCHAR(20)             NOT NULL,
    dir       VARCHAR(20)             NOT NULL,
    fecha_alt VARCHAR(10)             NOT NULL, -- Idealmente, esto debería ser de tipo DATE (YYYY-MM-DD), pero como no vamos a hacer consultas con fechas lo dejé como VARCHAR
    salario   INTEGER DEFAULT 0,
    comision  INTEGER DEFAULT 0,
    depto_no  int8                    NOT NULL
);
-- NOTA: No usé la condición NOT NULL (Que no acepte valores nulos) porque el problema no lo especificaba

CREATE TABLE departamento
(
    depto_no     int8 PRIMARY KEY NOT NULL, -- Esta como va a ser la conexión con la tabla empleado DEBE SER DEL MISMO TIPO que la columna por la cual estará conectada (depto_no)
    nombre_depto VARCHAR(50),
    localizacion VARCHAR(50)
);

-- Agregación de los datos
INSERT INTO empleado
VALUES ('281-160483-0005F', 'Rocha Vargas Hector', 27, 'Vendedor', 'Leon', '12/05/1963', 12000, 0, 40),
       ('281-040483-0056P', 'López Hernandez Julio', 27, 'Analista', 'Chinandega', '14/07/1962', 13000, 1500, 20),
       ('081-130678-0004S', 'Esquivel José', 31, 'Director', 'Juigalpa', '05/06/1961', 16700, 1200, 30),
       ('281-160473-0009Q', 'Delgado Carmen', 37, 'Vendedor', 'Leon', '02/03/1963', 13400, 0, 40),
       ('281-160493-0005F', 'Castillo Montes Luis', 17, 'Vendedor', 'Masaya', '12/06/1962', 16309, 1000, 40),
       ('281-240784-0004Y', 'Esquivel Leonel Alfonso', 26, 'Presidente', 'Nagarote', '12/09/1961', 15000, 0, 30),
       ('281-161277-0008R', 'Perez Luis', 32, 'Empleado', 'Managua', '02/03/1960', 16890, 0, 10);

INSERT INTO departamento
VALUES (10, 'Desarrollo Software', 'El Coyolar'),
       (20, 'Analista Sistema', 'Guadalupe'),
       (30, 'Contabilidad', 'Subtiaya'),
       (40, 'Ventas', 'San Felipe'),
       (0, NULL, NULL);

ALTER TABLE empleado
    ADD CONSTRAINT fk_depto
        FOREIGN KEY (depto_no) REFERENCES departamento (depto_no);

-- PROBLEMA:
-- Dada la siguiente base de datos relacional
-- Resuelva las siguientes consultas en SQL:
-- * Mostrar los nombres de los empleados ordenados alfabéticamente.
SELECT nombre
FROM empleado
ORDER BY nombre ASC;
-- Acá se podría omitir el ASC

-- * Listar los nombres de los empleados cuyo nombre termine con la letra 'o'.
SELECT nombre
FROM empleado
WHERE nombre LIKE '%o';

-- * Seleccionar el nombre, salario y localidad donde trabajan los empleados que tengan un salario entre 10.000 y 13.000
SELECT a.nombre, a.salario, b.localizacion
FROM empleado a
         INNER JOIN departamento b ON a.depto_no = b.depto_no -- Uso el INNER JOIN para traer únicamente los datos que coinciden en ambas tablas y no traer valores nulos
WHERE salario BETWEEN 10000 AND 13000;
-- Acá uso un WHERE en vez de un HAVING porque no estoy usando funciones agregadas, es decir: count(), sum(), avg(), …, etc

-- * ¿Cuántos empleados hay en el departamento de ventas?
SELECT COUNT(*) AS numero_empleados_ventas
FROM empleado
WHERE depto_no = 40;
-- Esta podría ser una respuesta perfectamente válida, o se podría hacer como WHERE oficio = 'Vendedor' sería igual


-- * Para cada oficio obtener la suma de salarios.
SELECT SUM(salario) AS salario_vendedores
FROM empleado
WHERE oficio = 'Vendedor';

SELECT SUM(salario) AS salario_analistas
FROM empleado
WHERE oficio = 'Analista';

SELECT SUM(salario) AS salario_directores
FROM empleado
WHERE oficio = 'Director';

SELECT SUM(salario) AS salario_presidentes
FROM empleado
WHERE oficio = 'Presidente';

SELECT SUM(salario) AS salario_empleados
FROM empleado
WHERE oficio = 'Empleado';

-- * Insertar en la tabla DEPARTAMENTO un departamento cuyo número sea 60 y nombre  'Pruebas'.
INSERT INTO departamento (depto_no, nombre_depto)
VALUES (60, 'Pruebas');
-- Acá, después de departamento en los parenthesis pongo únicamente las columnas correspondientes a los datos que voy a insertar, en este caso número de departamento y nombre

-- * Cambiar la localidad del departamento numero 10 a 'Zaragoza'.
UPDATE departamento
SET localizacion = 'Zaragoza'
WHERE depto_no = 10;

-- * Borra de la tabla EMPLEADO todos los empleados que no tengan comisión.
DELETE
FROM empleado
WHERE comision = 0;

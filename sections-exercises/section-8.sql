-- TRABAJO CON FECHAS
-- Funciones básicas de fechas
SELECT NOW(),
       CURRENT_DATE,
       CURRENT_TIME,
       DATE_PART('hours', NOW())   AS hours,
       DATE_PART('minutes', NOW()) AS minutes,
       DATE_PART('seconds', NOW()) AS seconds,
       DATE_PART('days', NOW())    AS days,
       DATE_PART('months', NOW())  AS months,
       DATE_PART('years', NOW())   AS years;

-- Consultas sobre fechas:
SELECT *
FROM employees
WHERE hire_date > '1998-02-05'
ORDER BY hire_date;

SELECT MAX(hire_date) AS mas_nuevo,
       MIN(hire_date) AS primer_empleado
FROM employees;

SELECT *
FROM employees
WHERE hire_date BETWEEN '1999-01-01' AND '2001-01-04'
ORDER BY hire_date DESC;

-- Intervalos:
SELECT MAX(hire_date),
--        max(hire_date) + INTERVAL '1 days' as days,
--        max(hire_date) + INTERVAL '1 month' as month,
--        max(hire_date) + INTERVAL '1 year' as year
--        max(hire_date) + INTERVAL '1.1 year' + INTERVAL '1 day' as year
       MAX(hire_date) + INTERVAL '1 year' + INTERVAL '1 day' AS year,
       DATE_PART('year', NOW()),
       MAKE_INTERVAL(YEARS := DATE_PART('year', NOW())::INTEGER),
       MAX(hire_date) + MAKE_INTERVAL(YEARS := 23)
FROM employees;

-- Cantidad de años desde la primera contratación hasta este momento:
SELECT hire_date,
       MAKE_INTERVAL(YEARS := 2024 - EXTRACT(YEARS FROM hire_date)::INTEGER) AS manual,
       MAKE_INTERVAL(YEARS := DATE_PART('years', CURRENT_DATE)::INTEGER -
                              EXTRACT(YEARS FROM hire_date)::INTEGER)        AS computed
FROM employees
ORDER BY hire_date DESC;

-- TAREA: Actualizar hire date
UPDATE employees
SET hire_date = hire_date + INTERVAL '24 years';

SELECT first_name,
       last_name,
       hire_date,
       CASE
           WHEN hire_date > NOW() - INTERVAL '1 years' THEN '1 año o menos'
           WHEN hire_date > NOW() - INTERVAL '3 years' THEN '1 a 3 años'
           WHEN hire_date > NOW() - INTERVAL '6 years' THEN '3 a 6 años'
           ELSE '+ 6 años'
           END AS rango_antiguedad
FROM employees
ORDER BY hire_date DESC;
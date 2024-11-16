-- Store Procedures

SELECT country_id,
       country_name,
       region_name
FROM countries
         INNER JOIN regions ON countries.region_id = regions.region_id;

CREATE OR REPLACE FUNCTION country_region()
    RETURNS TABLE
            (
                ID     CHARACTER(2),
                NAME   VARCHAR(40),
                REGION VARCHAR(25)
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT country_id,
               country_name,
               region_name
        FROM countries
                 INNER JOIN regions ON countries.region_id = regions.region_id;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM country_region();

-- Procedimientos almacenados
CREATE OR REPLACE PROCEDURE insert_region_proc(INT, VARCHAR)
AS
$$
    -- Declaración de variables
BEGIN
    INSERT INTO regions(region_id, region_name)
    VALUES ($1, $2);

    RAISE NOTICE 'Variable 1: %, %', $1, $2;

--     ROLLBACK; -- Esto básicamente revierte los cambios
    COMMIT; -- Esto impacta la base de datos de forma directa
END;
$$ LANGUAGE plpgsql;

CALL insert_region_proc(5, 'Central America');

SELECT *
FROM regions;

SELECT CURRENT_DATE                  AS raise_date,
       employee_id,
       salary,
       max_raise(employee_id) * 0.05 AS amount,
       5                             AS percentage
FROM employees;

-- Percentage: 5
CREATE OR REPLACE PROCEDURE controlled_raise(percentage NUMERIC) AS
$$
DECLARE
    real_percentage NUMERIC(8, 2);
    total_employees INT;
BEGIN
    real_percentage = percentage / 100;

    -- Mantener el historic
    INSERT INTO raise_history(date, employee_id, base_salary, amount, percentage)
    SELECT CURRENT_DATE                             AS raise_date,
           employee_id,
           salary,
           max_raise(employee_id) * real_percentage AS amount,
           percentage                               AS percentage
    FROM employees;

    -- Impactar la tabla de empleados
    UPDATE employees
    SET salary = max_raise(employee_id) * real_percentage + salary;

    COMMIT;

    SELECT count(*) into total_employees FROM employees;
    RAISE NOTICE 'Afectados % empleados', total_employees;

END;
$$ LANGUAGE plpgsql;

CALL controlled_raise(1);
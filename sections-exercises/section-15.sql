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
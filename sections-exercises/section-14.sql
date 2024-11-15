SELECT greet_employee('Diego');

SELECT first_name, greet_employee(first_name)
FROM employees;

-- Nuestra primera función
CREATE OR REPLACE FUNCTION greet_employee(employee_name VARCHAR)
    RETURNS VARCHAR
AS
$$
BEGIN
    RETURN 'Hola ' || employee_name;
END;
$$
    LANGUAGE plpgsql;

-- Usando variables
CREATE OR REPLACE FUNCTION max_raise(empl_id INT)
    RETURNS NUMERIC(8, 2) AS
$$
DECLARE
    possible_raise NUMERIC(8, 2);
BEGIN
    SELECT max_salary - salary
    INTO possible_raise
    FROM employees
             INNER JOIN jobs ON jobs.job_id = employees.job_id
    WHERE employee_id = empl_id;

    RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;

SELECT employee_id,
       first_name,
       salary,
       max_salary,
       max_salary - salary AS possible_raise,
       max_raise(employee_id),
       max_raise_2(employee_id)
FROM employees
         INNER JOIN jobs ON jobs.job_id = employees.job_id;

CREATE OR REPLACE FUNCTION max_raise_2(empl_id INT)
    RETURNS NUMERIC(8, 2) AS
$$
DECLARE
    selected_employee EMPLOYEES%ROWTYPE;
    selected_job      JOBS%ROWTYPE;
    possible_raise    NUMERIC(8, 2);
BEGIN
    -- Tomar el puesto de trabajo y el salario
    SELECT *
    INTO selected_employee
    FROM employees
    WHERE employee_id = empl_id;

    -- Tomar el max salary, acorde a su job
    SELECT * INTO selected_job FROM jobs WHERE job_id = selected_employee.job_id;

    -- Cálculos
    possible_raise = selected_job.max_salary - selected_employee.salary;
    IF (possible_raise < 0) THEN
        RAISE EXCEPTION 'Persona con salario mayor al max_salary: id: %, name: %', selected_employee.employee_id, selected_employee.first_name;
--         possible_raise = 0;
    END IF;


    RETURN possible_raise;
END;
$$ LANGUAGE plpgsql;

SELECT employee_id, first_name, salary, max_raise_2(employee_id)
FROM employees
WHERE employee_id = 206;
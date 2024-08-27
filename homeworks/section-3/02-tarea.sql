-- Tarea: Actualizar tabla de usuarios para dejar una columna con el primer nombre y otra con el apellido
UPDATE users
SET first_name = SUBSTRING(name, 0, POSITION(' ' IN name)),
    last_name = SUBSTRING(name, POSITION(' ' IN name) + 1);

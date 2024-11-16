CREATE EXTENSION pgcrypto;

-- Encriptación de contraseña
INSERT INTO "user" (username, password)
VALUES ('strider',
        crypt('123456', gen_salt('bf')));

-- Desencriptación de contraseña
SELECT COUNT(*)
FROM "user"
WHERE username = 'strider'
  AND password = crypt('123456', password);

-- Procedimientos almacenados
CREATE OR REPLACE PROCEDURE user_login(user_name VARCHAR, user_password VARCHAR)
AS
$$
DECLARE
    was_found BOOLEAN;
BEGIN
    SELECT COUNT(*)
    INTO was_found
    FROM "user"
    WHERE username = user_name
      AND password = crypt(user_password, password);

    IF (was_found = FALSE) THEN
        INSERT INTO session_failed (username, "when") VALUES (user_name, NOW());
        COMMIT;
        RAISE EXCEPTION 'Usuario y contraseña, no son correctos'; -- Al lanzar una excepción se hace un rollback
    END IF;


    -- Actualizar la tabla de usuarios
    UPDATE "user" SET last_login = NOW() WHERE username = user_name;
    COMMIT;
    RAISE NOTICE 'Usuario encontrado %', was_found;

END;
$$ LANGUAGE plpgsql;

CALL user_login('strider', '123456');


-- Triggers
CREATE OR REPLACE TRIGGER create_session_trigger
    AFTER UPDATE
    ON "user"
    FOR EACH ROW
    WHEN ( old.last_login IS DISTINCT FROM new.last_login)
EXECUTE FUNCTION create_session_log();


CREATE OR REPLACE FUNCTION create_session_log()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO session (user_id, last_login) VALUES (new.id, NOW());
    RETURN new;
END;
$$
    LANGUAGE plpgsql;
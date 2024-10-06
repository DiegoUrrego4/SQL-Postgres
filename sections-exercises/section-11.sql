-- Funciones
-- Ejemplo:
CREATE OR REPLACE FUNCTION sayHello(user_name VARCHAR)
    RETURNS VARCHAR
AS
$$
BEGIN
    RETURN 'Hola ' || user_name;
END
$$
    LANGUAGE plpgsql;

SELECT sayHello(username), username
FROM users;

-- Hacer la función respectiva para replies
CREATE OR REPLACE FUNCTION comment_replies(id INTEGER)
    RETURNS json
AS
$$
DECLARE
    result json;
BEGIN
    SELECT JSON_AGG(
                   JSON_BUILD_OBJECT(
                           'user', user_id,
                           'comment', content
                   )
           )
    INTO result
    FROM comments
    WHERE comment_parent_id = id;
    RETURN result;
END
$$
    LANGUAGE plpgsql;

SELECT comment_replies(3);
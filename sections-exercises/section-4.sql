-- Operador between
SELECT first_name, last_name, followers
FROM users
WHERE followers BETWEEN 4600 AND 4700 -- BETWEEN incluye ambos (4600 y 4700)
ORDER BY followers DESC;

-- Funciones agregadas
SELECT COUNT(*)              AS total_users,
       MIN(followers)        AS min_followers,
       MAX(followers)        AS max_followers,
       ROUND(AVG(followers)) AS followers_average -- ROUND: Redondea el valor
FROM users;

-- GROUP BY
SELECT COUNT(*),
       followers
FROM users
WHERE followers BETWEEN 4 AND 4999
GROUP BY followers
ORDER BY followers DESC;

-- HAVING
SELECT COUNT(*) AS number_of_persons, country
FROM users
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY COUNT(*) DESC;

-- DISTINCT
SELECT DISTINCT country -- NOTA: Esto NO es eficiente
FROM users;

-- Obtener el dominio del correo electrónico
SELECT COUNT(*),
       SUBSTRING(email, POSITION('@' IN email) + 1) AS domain
FROM users
GROUP BY domain
HAVING COUNT(*) > 1
ORDER BY domain ASC;

-- Sub queries.
-- Queries que se ejecutan dentro de otras queries
SELECT *
FROM (SELECT COUNT(*) as total,
             SUBSTRING(email, POSITION('@' IN email) + 1) AS domain,
             'Fernando'                                   AS name,
             37                                           AS age
      FROM users
      GROUP BY domain
      HAVING COUNT(*) > 1
      ORDER BY domain ASC) AS email_domains;
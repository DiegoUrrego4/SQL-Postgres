-- Creación de vistas NO materializadas y actualización de la misma
CREATE OR REPLACE VIEW comments_per_week AS
SELECT DATE_TRUNC('week', posts.created_at) AS weeks,
       SUM(claps.counter)                   AS total_claps,
       COUNT(DISTINCT posts.post_id)        AS number_of_posts,
       COUNT(*)                             AS number_of_claps
FROM posts
         INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY weeks
ORDER BY weeks DESC;

SELECT *
FROM claps
WHERE post_id = 1;

SELECT *
FROM comments_per_week;

DROP VIEW comments_per_week;
DROP MATERIALIZED VIEW comments_per_week;

-- Creación de vistas materializadas
CREATE MATERIALIZED VIEW comments_per_week_mat AS
SELECT DATE_TRUNC('week', posts.created_at) AS weeks,
       SUM(claps.counter)                   AS total_claps,
       COUNT(DISTINCT posts.post_id)        AS number_of_posts,
       COUNT(*)                             AS number_of_claps
FROM posts
         INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY weeks
ORDER BY weeks DESC;

SELECT *
FROM comments_per_week;

SELECT *
FROM comments_per_week_mat;

-- De esta forma podemos "actualizar" las vistas personalizadas
REFRESH MATERIALIZED VIEW comments_per_week_mat;

SELECT *
FROM posts
WHERE post_id = 1;

-- Cambiar nombre a vistas y vistas materializadas
    ALTER VIEW comments_per_week RENAME TO posts_per_week;
ALTER MATERIALIZED VIEW comments_per_week_mat RENAME TO posts_per_week_mat;


-- CTE: Common Table Expression
WITH posts_week_2024 AS (SELECT DATE_TRUNC('week'::TEXT, posts.created_at) AS weeks,
                                SUM(claps.counter)                         AS total_claps,
                                COUNT(DISTINCT posts.post_id)              AS number_of_posts,
                                COUNT(*)                                   AS number_of_claps
                         FROM posts
                                  JOIN claps ON claps.post_id = posts.post_id
                         GROUP BY (DATE_TRUNC('week'::TEXT, posts.created_at))
                         ORDER BY (DATE_TRUNC('week'::TEXT, posts.created_at)) DESC)
SELECT *
FROM posts_week_2024
WHERE weeks BETWEEN '2024-01-01' AND '2024-12-31'
  AND total_claps > 600;

-- Multiples CTES
WITH claps_per_posts AS (SELECT post_id, SUM(counter)
                         FROM claps
                         GROUP BY post_id),
     posts_from_2023 AS (SELECT *
                         FROM posts
                         WHERE created_at BETWEEN '2023-01-01' AND '2023-12-31')
SELECT *
FROM claps_per_posts
WHERE claps_per_posts.post_id IN (SELECT post_id FROM posts_from_2023);

-- CTES recursivos
-- Nombre de la tabla en memoria
-- campos que vamos a tener
WITH RECURSIVE countdown (val) AS (
    -- Inicialización -> El primer nivel, o valores iniciales
--     VALUES (5)
    SELECT 5 AS val
    UNION
    -- Query recursivo
    SELECT val - 1
    FROM countdown
    WHERE val > 1)
--Select de los campos
SELECT *
FROM countdown;

-- Tarea: Hacer el procedimiento inverso
WITH RECURSIVE counter (val) AS (SELECT 1 AS val
                                 UNION
                                 SELECT val + 1
                                 FROM counter
                                 WHERE val < 10)
SELECT *
FROM counter;

-- Tabla del 5:
WITH RECURSIVE multiplication_table(base, val, result) AS (
    -- Inicialización
    SELECT 5 AS base, 1 AS val, 5 AS result
    UNION
    -- Recursiva
    SELECT 5 AS base, val + 1, (val + 1) * base
    FROM multiplication_table
    WHERE val < 10)
SELECT *
FROM multiplication_table;
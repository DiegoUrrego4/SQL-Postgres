-- Quién sigue a quien
SELECT b.name AS leader,
       c.name AS following
FROM followers a
         INNER JOIN "user" b ON a.leader_id = b.id
         INNER JOIN "user" c ON a.follower_id = c.id;

SELECT follower_id
FROM followers
WHERE leader_id = 1;

SELECT *
FROM followers
WHERE leader_id IN (SELECT follower_id
                    FROM followers
                    WHERE leader_id = 1);
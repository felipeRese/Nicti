-- name: CreateSpace :one
INSERT INTO spaces  (user_id, nickname, balance)
VALUES ($1, $2, 0)
RETURNING *;

-- name: ListSpacesByUserId :many
SELECT * FROM spaces 
WHERE user_id = $1;

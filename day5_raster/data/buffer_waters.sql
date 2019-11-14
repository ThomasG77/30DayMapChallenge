CREATE TABLE buffer_waters AS (
SELECT ST_Buffer(ST_Transform(way, 2154), 500) AS way FROM waters);
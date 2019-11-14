CREATE TABLE waters AS (
SELECT ST_SetSrid(ST_UNION(way), 4326) AS way FROM planet_osm_polygon
  WHERE "natural" IN ('water', 'pond')
 OR waterway IN ('basin', 'canal', 'mill_pond', 'pond', 'riverbank', 'stream', 'lock', 'dock'));
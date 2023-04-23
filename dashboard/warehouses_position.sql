-------------------------------------------------------------------------
-- Get position of each warehouse
--
--  TYPE : GEOMAP
--  LAYER TYPE : MARKERS
-------------------------------------------------------------------------


SELECT DISTINCT source, ST_X(ST_TRANSFORM(geom,4674)) AS lon, ST_Y(ST_TRANSFORM(geom,4674)) AS lat FROM trips,nodes n WHERE seq = 1 and source = n.id
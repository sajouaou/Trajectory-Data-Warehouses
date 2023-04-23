--------------------
-- Query to obtain the density points related to the deliveries
--
--  TYPE : GEOMAP
--  LAYER TYPE : HEATMAP
--------------------

SELECT day_id, ST_X(ST_TRANSFORM(geom,4674)) AS lon, ST_Y(ST_TRANSFORM(geom,4674)) AS lat FROM trips,nodes n WHERE seq != 1 and source = n.id
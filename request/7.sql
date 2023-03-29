
-------------------------------------------------------------------------
-- R7
-------------------------------------------------------------------------

SELECT  COUNT(*)
FROM Deliveries D, Communes S1, Communes S2
WHERE S1.communeid <> S2.communeid AND
    ST_Intersects(trajectory(D.trip), S1.geom) AND
    ST_Intersects(trajectory(D.trip), S2.geom);
SELECT clock_timestamp() INTO endTime;

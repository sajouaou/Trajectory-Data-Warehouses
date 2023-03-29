
-------------------------------------------------------------------------
-- R2
-------------------------------------------------------------------------

SELECT  DT.date_actual, AVG(duration(D.Trip))
FROM Deliveries D, Trips DC, Nodes C, Communes S, Dates DT
WHERE D.vehicle = DC.vehicle AND D.day_id = DC.day_id  AND DC.seq = 1 AND
        DC.source = C.id AND ST_Intersects(C.geom, S.Geom) AND
        S.Name = 'Anderlecht' AND D.day_id = DT.date_dim_id
GROUP BY DT.date_actual
ORDER BY DT.date_actual;

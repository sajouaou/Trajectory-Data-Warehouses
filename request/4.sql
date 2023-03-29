-------------------------------------------------------------------------
-- R4
-------------------------------------------------------------------------
SELECT  DT.year_actual, DT.Month_actual, COUNT(*)
FROM Deliveries D, Dates DT, Communes S,
     unnest(periods(getTime(atGeometry(D.Trip, S.Geom)))) P
WHERE D.day_id = DT.date_dim_id AND S.Name = 'Anderlecht' AND
    D.Trip && S.Geom AND duration(P) >= interval '20 min'
GROUP BY DT.year_actual, DT.Month_actual
ORDER BY DT.year_actual, DT.Month_actual;


-------------------------------------------------------------------------
-- R3   Time: 878069,599 ms (14:38,070)
-------------------------------------------------------------------------
SELECT  T.year_actual, T.Month_actual, COUNT(*)
FROM Deliveries D, Dates T, Communes S
WHERE D.day_id = T.date_dim_id AND S.Name = 'Anderlecht' AND stbox(D.Trip) && stbox(S.Geom) AND
duration(atGeometry(D.Trip, S.Geom)) >= interval '20 min'
GROUP BY T.year_actual, T.Month_actual
ORDER BY T.year_actual, T.Month_actual;

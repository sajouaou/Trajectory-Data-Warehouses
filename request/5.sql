
-------------------------------------------------------------------------
-- R5
-------------------------------------------------------------------------

SELECT  DT.year_actual, DT.Month_actual, COUNT(*)
FROM Deliveries D, Dates DT
WHERE D.day_id = DT.date_dim_id AND length(atTime(D.Trip,
    getTime(atTbox(speed(Trip) * 3.6, tbox(floatspan '[100,inf]')) ))) / 1000 > 50
GROUP BY DT.year_actual, DT.Month_actual
ORDER BY DT.year_actual, DT.Month_actual;
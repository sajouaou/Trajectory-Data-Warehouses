
-------------------------------------------------------------------------
-- R1
-------------------------------------------------------------------------

SELECT  V.Brand, DT.year_actual, DT.Month_actual, SUM(length(D.Trip))
FROM Deliveries D, Vehicles V, Dates DT
WHERE D.Vehicle = V.VehicleID AND
        D.day_id = DT.date_dim_id
GROUP BY V.Brand, DT.year_actual, DT.Month_actual
ORDER BY V.Brand, DT.year_actual, DT.Month_actual;


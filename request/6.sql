-------------------------------------------------------------------------
-- R6
-------------------------------------------------------------------------
WITH Ranges AS  (
    SELECT I AS RangeID, floatrange(((I-1)*20), I*20) AS Range
    FROM generate_series(1,10) I )
SELECT  R.Range, SUM(length(atPeriodSet(D.Trip,
getTime(atRange(speed(D.Trip) * 3.6, R.Range)))) / 1000)
FROM Deliveries D, Ranges R
WHERE atRange(speed(D.Trip) * 3.6, R.Range) IS NOT NULL
GROUP BY R.RangeID, R.Range
ORDER BY R.RangeID;


-------
-- Count number of vehicle per brand
--
--  TYPE : BAR CHART
-------

SELECT brand, COUNT(*) FROM vehicles GROUP BY brand

-------
-- Count number of vehicle per brand
-------

SELECT brand, COUNT(*) FROM vehicles GROUP BY brand

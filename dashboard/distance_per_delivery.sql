-------
-- COUNT TOP 10 Delivery by distances
--
--  TYPE : STAT
--  VALUES OPTIONS : ONLY DISTANCE FIELD
-------

SELECT deliveryid,length(trip) as distance FROM deliveries ORDER BY distance LIMIT 10
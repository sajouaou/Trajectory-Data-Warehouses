--------------------
-- Query to obtain deliveries per warehouses
--
--  TYPE : TABLE
--------------------

SELECT warehouseid,count(*) as delivery FROM trips ,warehouses   WHERE seq = 1 and node = source GROUP BY warehouseid ORDER by delivery

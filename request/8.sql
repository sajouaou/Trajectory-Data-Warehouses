-------------------------------------------------------------------------
-- R8 IN COMMENT BECAUSE TAKE TOO LONG TIME 1968206,021 ms (32:48,206)
-------------------------------------------------------------------------

SELECT D1.deliveryid, D2.deliveryid
FROM Deliveries D1, Deliveries D2
WHERE D1.deliveryid <> D2.deliveryid  AND duration(getTime(
atValue(tdwithin(D1.trip, D2.trip, 1000), TRUE))) > '20 min';

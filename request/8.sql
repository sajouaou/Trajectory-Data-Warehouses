-------------------------------------------------------------------------
-- R8 IN COMMENT BECAUSE TAKE TOO LONG TIME Query complete 00:20:57.218
-------------------------------------------------------------------------

SELECT D1.deliveryid, D2.deliveryid
FROM Deliveries D1, Deliveries D2
WHERE D1.deliveryid <> D2.deliveryid  AND duration(getTime(
atValues(tdwithin(D1.trip, D2.trip, 1000), TRUE))) > '20 min';

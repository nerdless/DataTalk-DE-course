SELECT tips.tip_amount, zl."Zone"
FROM (
SELECT g."DOLocationID", tip_amount
FROM green_taxi_trips gt
JOIN zone_lookup zl
ON gt."PULocationID" = zl."LocationID"
WHERE zl."Zone" = 'Astoria' 
ORDER BY tip_amount DESC
LIMIT 3
) AS tips
JOIN zone_lookup zl
ON tips."DOLocationID" = zl."LocationID"
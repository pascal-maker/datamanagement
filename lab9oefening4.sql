USE Partago;   -- Zeg tegen MySQL dat we in de database Partago willen werken


SELECT   


JSON_UNQUOTE(JSON_EXTRACT(vehicleInformation,'$.brand')) AS Car,
JSON_UNQUOTE(JSON_EXTRACT(vehicleInformation,'$.model')) AS Model,
COUNT(*) AS `Number of cars`


FROM Partago
GROUP BY Car,Model
ORDER BY `Number of cars` DESC;



#Exercise02


SELECT
JSON_UNQUOTE(JSON_EXTRACT(vehicleInformation,'$.model')) AS Model,
JSON_EXTRACT(geoPosition,'$.latitude') AS latitude,
JSON_EXTRACT(geoPosition,'$.longitude') AS longitude



FROM Partago
WHERE JSON_EXTRACT(geoPosition,'$.latitude') > 51.1
  AND JSON_EXTRACT(geoPosition,'$.longitude') > 4.46;
  #o we are literally saying: give me rows where latitude > 51.1 AND longitude > 4.46.
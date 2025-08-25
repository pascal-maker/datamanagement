USE Partago;   -- Zeg tegen MySQL dat we in de database Partago willen werken

CREATE OR REPLACE VIEW CarsPerModel AS   -- Maak een view (of overschrijf bestaande) met de naam CarsPerModel
SELECT
  JSON_UNQUOTE(JSON_EXTRACT(vehicleInformation,'$.brand')) AS brand,  -- Haal merk (brand) uit JSON vehicleInformation en toon het als "brand"
  JSON_UNQUOTE(JSON_EXTRACT(vehicleInformation,'$.model')) AS model,  -- Haal model uit JSON vehicleInformation en toon het als "model"
  COUNT(*) AS `Number of cars`                                        -- Tel hoeveel records er van elke brand/model-combinatie bestaan
FROM partago                                                           -- Data komt uit de tabel Partago (bevat de JSON)
GROUP BY brand,model;                                                  -- Groepeer per merk en model zodat je tellingen krijgt
SELECT * FROM CarsPerModel;   -- Toont de inhoud van de view: dus de samenvatting auto’s per merk/model


SELECT * FROM CarsPerModel;


#Exercise02
CREATE OR REPLACE VIEW LocationsInRange AS    -- Maak een view (of vervang) met de naam LocationsInRange
SELECT 
  JSON_UNQUOTE(JSON_EXTRACT(vehicleInformation,'$.model')) AS model,   -- Toon het model van de wagen
  JSON_UNQUOTE(JSON_EXTRACT(geoPosition,'$.latitude')) AS latitude,    -- Haal latitude uit JSON geoPosition
  JSON_UNQUOTE(JSON_EXTRACT(geoPosition,'$.longitude')) AS longitude   -- Haal longitude uit JSON geoPosition
FROM partago
WHERE CAST(JSON_UNQUOTE(JSON_EXTRACT(geoPosition,'$.latitude')) AS DECIMAL(10,6)) > 51.1   -- Filter: latitude groter dan 51.1
  AND CAST(JSON_UNQUOTE(JSON_EXTRACT(geoPosition,'$.longitude')) AS DECIMAL(10,6)) < 4.46; -- Filter: longitude kleiner dan 4.46
SELECT * FROM LocationsInRange;   -- Toont de gefilterde resultaten in de view

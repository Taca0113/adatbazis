SELECT MIN(nettoar) AS Minimum, 
       MAX(nettoar) AS Maximum, 
       AVG(nettoar) AS Átlag, 
       STDEV(nettoar) AS Szórás
FROM dvd

SELECT MIN(LEN(cim)) AS Minimum_hossz, 
       MAX(LEN(cim)) AS Maximum_hossz, 
       AVG(LEN(cim)) AS Átlagos_hossz, 
       STDEV(LEN(cim)) AS Szórás_hossz
FROM dvd
WHERE cim IS NOT NULL
AND LEN(cim) > 0
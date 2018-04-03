/* Melyek azok a tejtermékek amelyek M-val kezdõdõ városba lettek kiszállítva Németországba?*/  
  SELECT DISTINCT
  t.Terméknév,
  v.Város
FROM rendelésrészletei rr
  INNER JOIN rendelések r
    ON rr.Rendeléskód = r.Rendeléskód
  INNER JOIN vevõk v
    ON r.Vevõkód = v.Vevõkód
  INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
  INNER JOIN kategóriák k
    ON t.Kategóriakód = k.Kategóriakód
WHERE k.Kategóriakód = 4 
AND v.Város LIKE 'M%'
AND v.Ország LIKE 'Németország';

/* 2.) Melyik termék volt  a legkelendõbb 1994. augusztusában? */ 
  SELECT
  t.Terméknév,
  SUM(rr.Mennyiség) AS Mennyiség
FROM rendelésrészletei rr
  INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
  INNER JOIN rendelések r
    ON rr.Rendeléskód = r.Rendeléskód
WHERE YEAR(r.RendelésDátuma) = 1994
AND MONTH(r.RendelésDátuma) = 8
GROUP BY t.Terméknév
  ORDER BY Mennyiség DESC
LIMIT 1 

/* 3.) 


/* Melyek azok a tejterm�kek amelyek M-val kezd�d� v�rosba lettek kisz�ll�tva N�metorsz�gba?*/  
  SELECT DISTINCT
  t.Term�kn�v,
  v.V�ros
FROM rendel�sr�szletei rr
  INNER JOIN rendel�sek r
    ON rr.Rendel�sk�d = r.Rendel�sk�d
  INNER JOIN vev�k v
    ON r.Vev�k�d = v.Vev�k�d
  INNER JOIN term�kek t
    ON rr.Term�kk�d = t.Term�kk�d
  INNER JOIN kateg�ri�k k
    ON t.Kateg�riak�d = k.Kateg�riak�d
WHERE k.Kateg�riak�d = 4 
AND v.V�ros LIKE 'M%'
AND v.Orsz�g LIKE 'N�metorsz�g';

/* 2.) Melyik term�k volt  a legkelend�bb 1994. augusztus�ban? */ 
  SELECT
  t.Term�kn�v,
  SUM(rr.Mennyis�g) AS Mennyis�g
FROM rendel�sr�szletei rr
  INNER JOIN term�kek t
    ON rr.Term�kk�d = t.Term�kk�d
  INNER JOIN rendel�sek r
    ON rr.Rendel�sk�d = r.Rendel�sk�d
WHERE YEAR(r.Rendel�sD�tuma) = 1994
AND MONTH(r.Rendel�sD�tuma) = 8
GROUP BY t.Term�kn�v
  ORDER BY Mennyis�g DESC
LIMIT 1 

/* 3.) 


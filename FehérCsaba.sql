USE nwind13ke;
-- 1. Mennyit tett zsebre a tulaj (a c�g eredm�nye elad�si �r-rakt�ri �r - k�lts�gek) 1995-ben,
--  ha az �sszes k�lts�get ad�paradicsomi k�r�lm�nyek k�z�tt az �sszes fizet�s + annak 10%-a fedezi?

SELECT
   
   SUM((rr.Egys�g�r - t.Egys�g�r)* (1- rr.Engedm�ny) * rr.Mennyis�g)
     - SUM( a.Fizet�s * 1.2) - SUM( a.Fizet�s * 12) AS 'Nyeres�g ?'
  
  FROM term�kek t
INNER JOIN rendel�sr�szletei rr ON t.Term�kk�d = rr.Term�kk�d
INNER JOIN rendel�sek r ON rr.Rendel�sk�d = r.Rendel�sk�d
INNER JOIN alkalmazottak a ON r.Alkalmazottk�d = a.Alkalmazottk�d
WHERE YEAR( r.Rendel�sD�tuma) = 1995;

-- A rakt�ron lev� term�kek egys�g�ra magasabb, mint az elad�si �r,
--  ez�rt negat�v a haszon(lehet, hogy p�nzmosod�ra lelt�nk)
-- --------------------------------------------------------------------------------------


-- 2. �rja ki bev�tel szerint n�vekv� sorrendben, melyik fuvaroz� mennyit keresett �sszesen!

SELECT
  s.C�gn�v, SUM( r.Sz�ll�t�siK�lts�g) AS Bev�tel
  
  FROM sz�ll�t�k s
INNER JOIN term�kek t ON s.Sz�ll�t�k�d = t.Sz�ll�t�k�d
INNER JOIN rendel�sr�szletei rr ON t.Term�kk�d = rr.Term�kk�d
INNER JOIN rendel�sek r ON rr.Rendel�sk�d = r.Rendel�sk�d
GROUP BY s.Sz�ll�t�k�d
ORDER BY Bev�tel;

-- -------------------------------------------------------------------------------------------------------------------

-- 3. �rja ki, mely term�k fogyott jobban a 4 �s 5-�s k�d� term�kn�l 1995. els� k�t negyed�v�ben!

SELECT rr.Term�kk�d, SUM(rr.Mennyis�g) AS �ssz FROM rendel�sek r
INNER JOIN rendel�sr�szletei rr ON r.Rendel�sk�d = rr.Rendel�sk�d
WHERE YEAR( r.Rendel�sD�tuma) = 1995  AND MONTH( r.Rendel�sD�tuma) BETWEEN 1 AND 6
GROUP BY rr.Term�kk�d
HAVING �ssz >ANY (
SELECT  
  SUM(rr.Mennyis�g)
FROM rendel�sr�szletei rr
INNER JOIN term�kek t
    ON rr.Term�kk�d = t.Term�kk�d
INNER JOIN rendel�sek r
  ON rr.Rendel�sk�d = r.Rendel�sk�d
WHERE (rr.Term�kk�d = 4 OR rr.Term�kk�d = 5) AND
  ( YEAR( r.Sz�ll�t�sD�tuma) = 1995 AND MONTH( r.Rendel�sD�tuma) BETWEEN 1 AND 6)
GROUP BY rr.Term�kk�d
);


-- --------------------------------------------------------------------------------------------------------------------


-- 4. Melyik a sl�gerterm�k, vagyis amib�l a legt�bbet adt�k el

SELECT t.Term�kk�d, t.Term�kn�v, SUM(rr.Mennyis�g) AS mennyis�g
 FROM rendel�sr�szletei rr
INNER JOIN term�kek t
  ON rr.Term�kk�d = t.Term�kk�d
GROUP BY t.Term�kk�d
ORDER BY mennyis�g DESC LIMIT 1;
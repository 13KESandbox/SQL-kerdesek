USE nwind13ke;
-- 1. Mennyit tett zsebre a tulaj (a cég eredménye eladási ár-raktári ár - költségek) 1995-ben,
--  ha az összes költséget adóparadicsomi körülmények között az összes fizetés + annak 10%-a fedezi?

SELECT
   
   SUM((rr.Egységár - t.Egységár)* (1- rr.Engedmény) * rr.Mennyiség)
     - SUM( a.Fizetés * 1.2) - SUM( a.Fizetés * 12) AS 'Nyereség ?'
  
  FROM termékek t
INNER JOIN rendelésrészletei rr ON t.Termékkód = rr.Termékkód
INNER JOIN rendelések r ON rr.Rendeléskód = r.Rendeléskód
INNER JOIN alkalmazottak a ON r.Alkalmazottkód = a.Alkalmazottkód
WHERE YEAR( r.RendelésDátuma) = 1995;

-- A raktáron levõ termékek egységára magasabb, mint az eladási ár,
--  ezért negatív a haszon(lehet, hogy pénzmosodára leltünk)
-- --------------------------------------------------------------------------------------


-- 2. Írja ki bevétel szerint növekvõ sorrendben, melyik fuvarozó mennyit keresett összesen!

SELECT
  s.Cégnév, SUM( r.SzállításiKöltség) AS Bevétel
  
  FROM szállítók s
INNER JOIN termékek t ON s.Szállítókód = t.Szállítókód
INNER JOIN rendelésrészletei rr ON t.Termékkód = rr.Termékkód
INNER JOIN rendelések r ON rr.Rendeléskód = r.Rendeléskód
GROUP BY s.Szállítókód
ORDER BY Bevétel;

-- -------------------------------------------------------------------------------------------------------------------

-- 3. Írja ki, mely termék fogyott jobban a 4 és 5-ös kódú terméknél 1995. elsõ két negyedévében!

SELECT rr.Termékkód, SUM(rr.Mennyiség) AS össz FROM rendelések r
INNER JOIN rendelésrészletei rr ON r.Rendeléskód = rr.Rendeléskód
WHERE YEAR( r.RendelésDátuma) = 1995  AND MONTH( r.RendelésDátuma) BETWEEN 1 AND 6
GROUP BY rr.Termékkód
HAVING össz >ANY (
SELECT  
  SUM(rr.Mennyiség)
FROM rendelésrészletei rr
INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
INNER JOIN rendelések r
  ON rr.Rendeléskód = r.Rendeléskód
WHERE (rr.Termékkód = 4 OR rr.Termékkód = 5) AND
  ( YEAR( r.SzállításDátuma) = 1995 AND MONTH( r.RendelésDátuma) BETWEEN 1 AND 6)
GROUP BY rr.Termékkód
);


-- --------------------------------------------------------------------------------------------------------------------


-- 4. Melyik a slágertermék, vagyis amibõl a legtöbbet adták el

SELECT t.Termékkód, t.Terméknév, SUM(rr.Mennyiség) AS mennyiség
 FROM rendelésrészletei rr
INNER JOIN termékek t
  ON rr.Termékkód = t.Termékkód
GROUP BY t.Termékkód
ORDER BY mennyiség DESC LIMIT 1;
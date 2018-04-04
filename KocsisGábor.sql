/* 4 kérdés 4 válasz */

/* 1. Melyek azok az italok amelyek A-val kezdődő városba lettek kiszállítva az Egyesült Államokba?  */
SELECT DISTINCT
  t.Terméknév
FROM rendelésrészletei rr
  INNER JOIN rendelések r
    ON rr.Rendeléskód = r.Rendeléskód
  INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
  INNER JOIN kategóriák k
    ON t.Kategóriakód = k.Kategóriakód
WHERE k.Kategóriakód = 1
AND r.Város LIKE 'A%'
AND r.Ország LIKE 'USA';

/* 2. Ki a legtöbb édességet fuvarozó cég? */
  SELECT
  f.Cégnév,
  SUM(rr.Mennyiség)
FROM rendelések r
  INNER JOIN fuvarozók f
    ON r.Fuvarozó = f.Fuvarozókód
  INNER JOIN rendelésrészletei rr
    ON rr.Rendeléskód = r.Rendeléskód
  INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
WHERE t.Kategóriakód = 3
GROUP BY f.Cégnév
  ORDER BY Mennyiség
  LIMIT 1;

/*  */


/* 4. Listázzon ki minden olyan rendelést ami Belkereskedelmi szervezőhöz köthető  */
  SELECT
  r.Rendeléskód
FROM rendelések r
  INNER JOIN alkalmazottak a 
    ON r.Alkalmazottkód = a.Alkalmazottkód
  INNER JOIN rendelésrészletei rr
    ON rr.Rendeléskód = r.Rendeléskód
WHERE r.Alkalmazottkód IN (SELECT
    a.Alkalmazottkód
  FROM alkalmazottak a
  WHERE a.Beosztás LIKE 'Belkereskedelmi szervező'
 )
 GROUP BY Rendeléskód





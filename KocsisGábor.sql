/* 4 kérdés 4 válasz */

/* 1. Melyek azok az italok amelyek A-val kezdődő városba lettek kiszállítva az Egyesült Államokba?  */
SELECT DISTINCT
  t.Terméknév
FROM rendelésrészletei rr
  INNER JOIN rendelések r
    ON rr.Rendeléskód = r.Rendeléskód
  INNER JOIN vevők v
    ON r.Vevőkód = v.Vevőkód
  INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
  INNER JOIN kategóriák k
    ON t.Kategóriakód = k.Kategóriakód
WHERE k.Kategóriakód = 1
AND v.Város LIKE 'A%'
AND v.Ország LIKE 'USA';

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


/*  */





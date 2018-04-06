/*nwind adatbázishoz 4db feladat készítése:*/
/*===========================================*/

/*1. Min. 4 táblás lekérdezés, WHERE záradék összetett logikai kifejezéssel, ORDER BY záradékkal
   Opciók: DISTINCT, LIMIT, YEAR(), CONCAT(), FORMAT()
   Operátorok: relációs, LIKE, NOT LIKE, BETWEEN*/

  /*Listázzuk ki azon vevők nevét (minden név csak egyszer szerepljen) akik 1994 és 1995 között olyan 
  termékeket vásároltak amik a jelen adatok szerint nincsenek raktáron.*/
SELECT DISTINCT
  v.Cégnév, t.Raktáron
FROM rendelésrészletei rr
  INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
  INNER JOIN rendelések r
    ON rr.Rendeléskód = r.Rendeléskód
  INNER JOIN vevők v
    ON r.Vevőkód = v.Vevőkód
WHERE r.RendelésDátuma BETWEEN '1994-08-03' AND '1995-12-31'
HAVING t.Raktáron = 0;
/*2. Lekérdezés csoportosítással: GROUP BY, WHERE, HAVING
   Táblák száma: 1-8
   Agregát függvények: COUNT(), AVG(), MIN(), MAX(), SUM()*/

  /*Listázzuk ki azon alkalmazottak nevét akik fizetése meghaladja a cégnél dolgozók átlag fizetését*/
SELECT
  a.Vezetéknév, a.Keresztnév 
FROM alkalmazottak a
  WHERE a.Fizetés > (SELECT
  AVG(a.Fizetés)
FROM alkalmazottak a);
/*3. Lekérdezés alkérdéssel, az alkérdés pontosan 1db értéket ad vissza*/
  

/*4. Lekérdezés alkérdéssel, az alkérdés több értéket ad vissza
   Operátorok: IN, NOT IN, ALL, ANY */


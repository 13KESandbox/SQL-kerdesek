nwind adatbázishoz 4db feladat készítése:
===========================================

/*1. Nézzük meg, hogy melyik alkalmazott mennyit keresett 1990 és 1995 között az édességeken
Ki volt a vevő, ki volt a fuvarozó és milyen édességből mennyit kaszált.*/

SELECT r1.Rendeléskód, v.Cégnév AS vevő, CONCAT(a.Megszólítás,' ', a.Vezetéknév,' ', a.Keresztnév) AS alkalmazott,
 f.Cégnév AS fuvarozó, t.Terméknév, ROUND(SUM((r.Egységár*r.Mennyiség)*(1-r.Engedmény)),2) AS jövedelem FROM 
rendelések r1
  INNER JOIN vevők v ON r1.Vevőkód = v.Vevőkód
  INNER JOIN alkalmazottak a ON r1.Alkalmazottkód = a.Alkalmazottkód
  INNER JOIN fuvarozók f ON r1.Fuvarozó = f.Fuvarozókód
  INNER JOIN rendelésrészletei r ON r1.Rendeléskód = r.Rendeléskód
  INNER JOIN termékek t ON r.Termékkód = t.Termékkód
  WHERE
  1=1
AND t.Kategóriakód=3
  AND YEAR(r1.RendelésDátuma) BETWEEN (1990) AND (1995)
GROUP BY r1.Rendeléskód, v.Cégnév, CONCAT(a.Megszólítás,' ', a.Vezetéknév,' ', a.Keresztnév),
 f.Cégnév, t.Terméknév
ORDER BY jövedelem
 ;


/*2. Melyik alkalmazott kereste a legtöbbet 1995ben? 
Az alkalmazott neve max 1 cellát foglalhat el és a jövedelme 2 tizedes jegyig kerekítve.*/

SELECT a.Alkalmazottkód, CONCAT(a.Megszólítás,' ', a.Vezetéknév,' ', a.Keresztnév) AS alkalmazott,
  ROUND(SUM((r1.Egységár*r1.Mennyiség)*(1-r1.Engedmény)),2) AS jövedelem, COUNT(r1.Rendeléskód)
FROM
  alkalmazottak a
INNER JOIN rendelések r ON a.Alkalmazottkód = r.Alkalmazottkód
INNER JOIN rendelésrészletei r1 ON r.Rendeléskód = r1.Rendeléskód
  WHERE
  YEAR(r.RendelésDátuma)='1995'

GROUP BY a.Alkalmazottkód, a.Megszólítás, a.Keresztnév, a.Vezetéknév
ORDER BY jövedelem DESC LIMIT 5
  ;



/*3. Átlagár feletti termékek*/

SELECT
t.Terméknév, ROUND(t.Egységár,2)
FROM termékek t
INNER JOIN kategóriák k
ON t.Kategóriakód = k.Kategóriakód
WHERE t.Egységár > 
(SELECT
AVG(t1.Egységár) AS Átlagár
FROM termékek t1 
INNER JOIN kategóriák k1
ON t1.Kategóriakód = k1.Kategóriakód)
ORDER BY 2
  ;

4. Kik rendeltek eddig édességet, ki

Határidő: 2018.03.29

Feltöltés: https://github.com/13KESandbox/SQL-kerdesek





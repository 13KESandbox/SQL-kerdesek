1. kérdésre:

	1. Milyen édességeket rendeltek 1995 elott?

SELECT
  termékek.Terméknév
FROM rendelésrészletei
  INNER JOIN rendelések
    ON rendelésrészletei.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN termékek
    ON rendelésrészletei.Termékkód = termékek.Termékkód
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
  WHERE YEAR(rendelések.RendelésDátuma) < 1995 AND kategóriák.Kategórianév = "Édességek"
  GROUP BY termékek.Terméknév

2. kérdésre:


	2. Átlagosan hány darabot rendeltek az egyes italokból?
	(az átlagok ketto tizedesre legyenek kerekítve és utána jelenjen meg a " db")

SELECT
  termékek.Terméknév,
  CONCAT(ROUND(AVG(rendelésrészletei.Mennyiség), 2), " db")
FROM termékek
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
  INNER JOIN rendelésrészletei
    ON rendelésrészletei.Termékkód = termékek.Termékkód
  WHERE kategóriák.Kategórianév LIKE "Italok"
  GROUP BY termékek.Terméknév

3. kérdésre


	3. Melyik fuszerbol rendeltek kevesebbet az átlagos mennyiségnél?

SELECT
  termékek.Terméknév
FROM termékek
  INNER JOIN rendelésrészletei
    ON termékek.Termékkód = rendelésrészletei.Termékkód
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
WHERE kategóriák.Kategórianév = 'Fuszerek'
AND rendelésrészletei.Mennyiség < (SELECT
    AVG(rendelésrészletei.Mennyiség) AS `Átlag mennyiség`
  FROM rendelésrészletei
    INNER JOIN termékek
      ON rendelésrészletei.Termékkód = termékek.Termékkód
    INNER JOIN kategóriák
      ON termékek.Kategóriakód = kategóriák.Kategóriakód
  WHERE kategóriák.Kategórianév = 'Fuszerek')
  GROUP BY termékek.Terméknév

4.kérdésre
	4. Melyikek azok a vevok akik nem rendeltek ugyan azon években mint az Alfreds Futterkiste?

SELECT
  vevok.Cégnév
FROM vevok
  INNER JOIN rendelések
    ON rendelések.Vevokód = vevok.Vevokód
  WHERE YEAR(rendelések.RendelésDátuma) NOT IN (SELECT
  YEAR(rendelések.RendelésDátuma)
FROM rendelések
  INNER JOIN vevok
    ON rendelések.Vevokód = vevok.Vevokód
  WHERE vevok.Cégnév = 'Alfreds Futterkiste'
  GROUP BY YEAR(rendelések.RendelésDátuma))
  GROUP BY vevok.Cégnév
	1. Melyik vevő cég es mikor rendelt először Filo Mix terméket?
	
  
SELECT
  vevők.Cégnév,
  rendelések.RendelésDátuma
FROM rendelések
  INNER JOIN rendelésrészletei
    ON rendelésrészletei.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN termékek
    ON rendelésrészletei.Termékkód = termékek.Termékkód
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
WHERE termékek.Terméknév LIKE "Filo Mix"
  ORDER BY rendelések.RendelésDátuma
  LIMIT 1



	2. Országonként hány vevőnek fuvarozott a United Package cég?

SELECT
  vevők.Ország,
  COUNT(vevők.Cégnév) AS `Vevők száma`
FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  INNER JOIN fuvarozók
    ON rendelések.Fuvarozó = fuvarozók.Fuvarozókód
WHERE fuvarozók.Cégnév LIKE "United Package"
GROUP BY vevők.Ország


	3. Melyik tengeri ételeknek magasabb az egységára az átlagosnál?

SELECT
  termékek.Terméknév
FROM termékek
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
  WHERE kategóriák.Kategórianév = 'Tengeri ételek' AND termékek.Egységár > 
(SELECT
  AVG(termékek.Egységár) AS Átlagár
FROM termékek
  INNER JOIN kategóriák
    ON termékek.Kategóriakód = kategóriák.Kategóriakód
WHERE kategóriák.Kategórianév = 'Tengeri ételek')

	4. Melyikek azok a vevők akik nem rendeltek ugyan azon években mint az Alfreds Futterkiste?

SELECT
  vevők.Cégnév
FROM vevők
  INNER JOIN rendelések
    ON rendelések.Vevőkód = vevők.Vevőkód
  WHERE YEAR(rendelések.RendelésDátuma) NOT IN (SELECT
  YEAR(rendelések.RendelésDátuma)
FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  WHERE vevők.Cégnév = 'Alfreds Futterkiste'
  GROUP BY YEAR(rendelések.RendelésDátuma))
  GROUP BY vevők.Cégnév
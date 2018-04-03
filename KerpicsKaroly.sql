/* 1. Melyik terméket rendelték letelőször és ki rendelte?*/

SELECT
  termékek.Terméknév,
  vevők.Cégnév
 FROM rendelésrészletei
  INNER JOIN rendelések
    ON rendelésrészletei.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN termékek
    ON rendelésrészletei.Termékkód = termékek.Termékkód
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  ORDER BY rendelések.RendelésDátuma
  LIMIT 1;

/* 2. Milyen termékeket és mennyit rendelt a Chop-suey Chinese cég?*/

SELECT
  termékek.Terméknév,
  SUM(rendelésrészletei.Mennyiség) AS `Összes mennyiség`
 FROM rendelésrészletei
  INNER JOIN rendelések
    ON rendelésrészletei.Rendeléskód = rendelések.Rendeléskód
  INNER JOIN termékek
    ON rendelésrészletei.Termékkód = termékek.Termékkód
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  WHERE vevők.Cégnév = 'Chop-suey Chinese';

/* 3. Mely cégek rendeltek korábban, mint a Let's Stop N Shop cég első rendelése?*/

SELECT
  vevők.Cégnév
 FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  WHERE rendelések.RendelésDátuma < (SELECT
  rendelések.RendelésDátuma
 FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  WHERE vevők.Cégnév = "Let's Stop N Shop"
  LIMIT 1)
  GROUP BY vevők.Cégnév;

/* 4. Melyikek azok a vevők akiknek nem szállítottak ugyan azon években mint az Chop-suey Chinese?*/

SELECT
  vevők.Cégnév
FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
  WHERE vevők.Cégnév NOT IN (SELECT
  vevők.Cégnév
FROM rendelések
  INNER JOIN vevők
    ON rendelések.Vevőkód = vevők.Vevőkód
WHERE YEAR(rendelések.SzállításDátuma) IN (SELECT
    YEAR(rendelések.SzállításDátuma) AS expr1
  FROM rendelések
    INNER JOIN vevők
      ON rendelések.Vevőkód = vevők.Vevőkód
  WHERE vevők.Cégnév = "Chop-suey Chinese"))
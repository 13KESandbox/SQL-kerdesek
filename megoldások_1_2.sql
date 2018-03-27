/* Feladatsor 1. */

/* 01.	Mely rendelések nincsenek kiszállítva? */
SELECT
  r.Rendeléskód
FROM rendelések r
  WHERE r.SzállításDátuma IS NULL;

/* 02.	Listázzuk ki azoknak a vevõknek a neveit (cégnév),
  akik határidõ után kaptak meg legalább egy rendelést! */
SELECT DISTINCT v.Cégnév
FROM rendelések r
  INNER JOIN vevõk v
    ON r.Vevõkód = v.Vevõkód
WHERE r.SzállításDátuma > r.Határidõ;


/* 03.	Listázza ki az 1000 Ft-nál olcsóbb italokat! */

/* 04.	Listázza ki a 1995-ös év rendeléseit! */
SELECT * FROM rendelések r
  WHERE YEAR(r.RendelésDátuma)=1995;

/* 05.	A Vevõ (Cégnév) 3. vagy negyedik betûje „R”-betû. */
SELECT v.Cégnév FROM vevõk v
  WHERE v.Cégnév LIKE '__R%' OR 
        v.Cégnév LIKE '___R%';


/* 06.	Határozzuk meg a kategóriánkénti kifutott termékek számát és
        átlagos egységárát!
        Az átlagos egységár legyen két tizedesjegyre kerekítve
        A darabszám mögött jelenjen meg a "db" mértékegység! */
SELECT
  k.Kategórianév,
  ROUND(AVG(t.Egységár),2) AS `Átlagos egységár`,
  CONCAT(COUNT(*), ' db') AS Darabszám
FROM termékek t
  INNER JOIN kategóriák k
    ON t.Kategóriakód = k.Kategóriakód
WHERE t.Kifutott IS TRUE
GROUP BY k.Kategórianév;


/* 07.	Határozza meg országonként és városonként a vevõk számát! */

/* 08.	Listázza ki csökkenõ sorrendben azt a 10 vevõt,
        akik a legtöbb pénzt hagyták a kasszában? */
SELECT
  v.Cégnév,
  FORMAT(SUM(rr.Egységár*rr.Mennyiség*(1-rr.Engedmény)), 0) AS Fizet
FROM rendelések r
  INNER JOIN vevõk v
    ON r.Vevõkód = v.Vevõkód
  INNER JOIN rendelésrészletei rr
    ON rr.Rendeléskód = r.Rendeléskód
  GROUP BY v.Cégnév
  ORDER BY SUM(rr.Egységár*rr.Mennyiség*(1-rr.Engedmény)) DESC
  LIMIT 10;

/* 09.	Határozza meg az évenkénti rendelések számát! */

/* 10.	Határozza meg az évenként eladott termékek számát! */

/* 11.	Üzletkötõnként határozza meg az össze engedmény értékét! */

/* 12.	Az üzletkötõk hányszor adtak engedményt? */

/* 13.	 Tíznél több terméket tartalmazó kategóriákban hány termék szerepel. */

/* 14.	A Fizetés mezõben azon üzletkötõk jövedelme,
        akiké meghaladja az "Igazgató" vagy "Alelnök" címmel 
        rendelkezõ minden alkalmazottét. */

/* 15.	A Rendelésösszeg: [Egységár] * [Mennyiség] számított mezõben
        az átlagos rendelésértéknél nagyobb összegû rendelések. */

/* 16.	Az Egységár mezõ azon termékei,
        amelyek egységára megegyezik az ánizsmagszörpével. */

/* 17.	Kik azok az üzletkötõk, akik legalább egy igazgatónál vagy alelnököknél 
        idõsebbek? */
SELECT
  a.Vezetéknév,
  a.Beosztás,
  a.SzületésiDátum
FROM alkalmazottak a
WHERE a.Beosztás = 'üzletkötõ'
AND a.SzületésiDátum < ANY (SELECT
    a.SzületésiDátum
  FROM alkalmazottak a
  WHERE a.Beosztás LIKE '%igazgató%'
  OR a.Beosztás LIKE '%alelnök%');

/* Feladatsor 2. */

/* 01. Add meg a kifutott termékek nevét és szállítóját! */
  SELECT
  t.Terméknév,
  sz.Cégnév
FROM termékek t
  INNER JOIN szállítók sz
    ON t.Szállítókód = sz.Szállítókód
WHERE t.Kifutott IS TRUE;

/* 02. Töröld az Alkalmazottak táblából a Gyakornok Beosztású rekordokat. */
DELETE
  FROM alkalmazottak
WHERE Beosztás = 'Gyakornok';

/* 03. Add meg a B és az M betûvel kezdõdõ városokból szállított termékek nevét és egységárát. */

/* 04. Add meg a raktáron lévõ termékek átlagos egységárát. */
SELECT
  AVG(t.Egységár) AS ÁtlagosEgységár
FROM termékek t
  WHERE t.Raktáron IS TRUE;

/* 05. Add meg a minimumkészlet alá csökkent nem kifutott termékek nevét és darabszámát terméknév szerinti sorrendben. */

/* 06. Add meg a 10 legnagyobb raktári összértékkel rendelkezõ termék nevét, beszállítóját, értékszerinti csökkenõ sorrendben. */

/* 07.Add meg az 1995 elsõ félévében született rendelések megrendelésszámát, megrendelõjét és az alkalmazott nevét, aki a megrendelést bonyolította. */

/* 08. Add meg annak a 3 alkalmazottnak a nevét, akik 1995-ben a legkevesebb rendeléseket bonyolította. */

/* 09. A következõ példa minden olyan rekord Felettes mezõjét 5-re állítja,
       amelynek jelenleg 2 az értéke. */

/* 10. Növelje minden olyan termék egységárát 10 százalékkal,
       amelyek a 8. számú szállítótól származnak, 
       és amelyekbõl van raktáron. */
UPDATE termékek
SET Egységár = Egységár * 1.1
WHERE Szállítókód = 8 AND Raktáron > 0;


/* 11. A következõ példa minden olyan termék egységárát csökkenti
       10 százalékkal, amely a Tokyo Traders nevû szállítótól származik,
       és amelybõl van raktáron.  */

UPDATE termékek t
  INNER JOIN szállítók sz
  ON t.Szállítókód = sz.Szállítókód
SET t.Egységár = t.Egységár * 0.9
WHERE t.Raktáron IS TRUE AND 
  sz.Cégnév='Tokyo Traders';

/* vagy */

UPDATE termékek
SET Egységár = Egységár * 0.9
WHERE Raktáron IS TRUE AND Szállítókód =
  (SELECT sz.Szállítókód FROM szállítók sz
   WHERE sz.Cégnév='Tokyo Traders');



/* 12. Add meg a termékek kategóriánkénti átlagos egységárát! */

/* 13.  Mely termékek fogytak az átlag feletti mennyiségben,
        az eredményt darabszám alapján növekvõ sorrendben jelenítse meg? 
        (a mennyiség mellett szerepeljen a db is)  */

SELECT  t.Terméknév, SUM(rr.Mennyiség) AS Fogyi
FROM rendelésrészletei rr
  INNER JOIN termékek t
    ON rr.Termékkód = t.Termékkód
  GROUP BY t.Termékkód
  HAVING Fogyi > 
(SELECT AVG(belsõ.Fogyás)
FROM
(
    SELECT SUM(Mennyiség) AS Fogyás
    FROM rendelésrészletei
    GROUP BY Termékkód
) as belsõ);

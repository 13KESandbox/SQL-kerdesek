/* Feladatsor 1. */

/* 01.	Mely rendel�sek nincsenek kisz�ll�tva? */
SELECT
  r.Rendel�sk�d
FROM rendel�sek r
  WHERE r.Sz�ll�t�sD�tuma IS NULL;

/* 02.	List�zzuk ki azoknak a vev�knek a neveit (c�gn�v),
  akik hat�rid� ut�n kaptak meg legal�bb egy rendel�st! */
SELECT DISTINCT v.C�gn�v
FROM rendel�sek r
  INNER JOIN vev�k v
    ON r.Vev�k�d = v.Vev�k�d
WHERE r.Sz�ll�t�sD�tuma > r.Hat�rid�;


/* 03.	List�zza ki az 1000 Ft-n�l olcs�bb italokat! */
SELECT
  t.Term�kn�v
FROM term�kek t
  INNER JOIN kateg�ri�k k
    ON t.Kateg�riak�d = k.Kateg�riak�d
WHERE k.Kateg�rian�v = 'Italok'
AND t.Egys�g�r < 1000;

/* 04.	List�zza ki a 1995-�s �v rendel�seit! */
SELECT * FROM rendel�sek r
  WHERE YEAR(r.Rendel�sD�tuma)=1995;

/* 05.	A Vev� (C�gn�v) 3. vagy negyedik bet�je �R�-bet�. */
SELECT v.C�gn�v FROM vev�k v
  WHERE v.C�gn�v LIKE '__R%' OR 
        v.C�gn�v LIKE '___R%';


/* 06.	Hat�rozzuk meg a kateg�ri�nk�nti kifutott term�kek sz�m�t �s
        �tlagos egys�g�r�t!
        Az �tlagos egys�g�r legyen k�t tizedesjegyre kerek�tve
        A darabsz�m m�g�tt jelenjen meg a "db" m�rt�kegys�g! */
SELECT
  k.Kateg�rian�v,
  ROUND(AVG(t.Egys�g�r),2) AS `�tlagos egys�g�r`,
  CONCAT(COUNT(*), ' db') AS Darabsz�m
FROM term�kek t
  INNER JOIN kateg�ri�k k
    ON t.Kateg�riak�d = k.Kateg�riak�d
WHERE t.Kifutott IS TRUE
GROUP BY k.Kateg�rian�v;


/* 07.	Hat�rozza meg orsz�gonk�nt �s v�rosonk�nt a vev�k sz�m�t! 
        Csak azok a v�rosok jelenjenek meg,
        ahol a vev�k sz�ma nagyobb, mint 1!
        A lista legyen vev�k sz�ma alapj�n cs�kken� rendben! */
SELECT
  v.Orsz�g,
  v.V�ros,
  COUNT(v.Vev�k�d) AS `Vev�k sz�ma`
FROM vev�k v
GROUP BY v.Orsz�g,
         v.V�ros
  HAVING `Vev�k sz�ma` > 1
  ORDER BY `Vev�k sz�ma` DESC;

/* 08.	List�zza ki cs�kken� sorrendben azt a 10 vev�t,
        akik a legt�bb p�nzt hagyt�k a kassz�ban? */
SELECT
  v.C�gn�v,
  FORMAT(SUM(rr.Egys�g�r*rr.Mennyis�g*(1-rr.Engedm�ny)), 0) AS Fizet
FROM rendel�sek r
  INNER JOIN vev�k v
    ON r.Vev�k�d = v.Vev�k�d
  INNER JOIN rendel�sr�szletei rr
    ON rr.Rendel�sk�d = r.Rendel�sk�d
  GROUP BY v.C�gn�v
  ORDER BY SUM(rr.Egys�g�r*rr.Mennyis�g*(1-rr.Engedm�ny)) DESC
  LIMIT 10;

/* 09.	Hat�rozza meg a p�ros �vekben az �venk�nti rendel�sek sz�m�t! */
SELECT
  YEAR(r.Rendel�sD�tuma) AS �v,
  COUNT(r.Rendel�sk�d)
FROM rendel�sek r
  WHERE YEAR(r.Rendel�sD�tuma) MOD 2 = 0 /* itt nem haszn�lhat� az �ln�v (�v) */
  GROUP BY �v;

/* 10.	Hat�rozza meg az �venk�nt eladott term�kek sz�m�t! */

/* 11.	�zletk�t�nk�nt hat�rozza meg az �ssze engedm�ny �rt�k�t! */

/* 12.	Az �zletk�t�k h�nyszor adtak engedm�nyt? */

/* 13.	 T�zn�l t�bb term�ket tartalmaz� kateg�ri�kban h�ny term�k szerepel. */

/* 14.	A Fizet�s mez�ben azon �zletk�t�k j�vedelme,
        akik� meghaladja az "Igazgat�" vagy "Aleln�k" c�mmel 
        rendelkez� minden alkalmazott�t. */

/* 15.	A Rendel�s�sszeg: [Egys�g�r] * [Mennyis�g] sz�m�tott mez�ben
        az �tlagos rendel�s�rt�kn�l nagyobb �sszeg� rendel�sek. */

/* 16.	Az Egys�g�r mez� azon term�kei,
        amelyek egys�g�ra megegyezik az �nizsmagsz�rp�vel. */

/* 17.	Kik azok az �zletk�t�k, akik legal�bb egy igazgat�n�l vagy aleln�k�kn�l 
        id�sebbek? */
SELECT
  a.Vezet�kn�v,
  a.Beoszt�s,
  a.Sz�let�siD�tum
FROM alkalmazottak a
WHERE a.Beoszt�s = '�zletk�t�'
AND a.Sz�let�siD�tum < ANY (SELECT
    a.Sz�let�siD�tum
  FROM alkalmazottak a
  WHERE a.Beoszt�s LIKE '%igazgat�%'
  OR a.Beoszt�s LIKE '%aleln�k%');

/* Feladatsor 2. */

/* 01. Add meg a kifutott term�kek nev�t �s sz�ll�t�j�t! */

/* 02. T�r�ld az Alkalmazottak t�bl�b�l a Gyakornok Beoszt�s� rekordokat. */

/* 03. Add meg a B �s az M bet�vel kezd�d� v�rosokb�l sz�ll�tott term�kek nev�t �s egys�g�r�t. */

/* 04. Add meg a rakt�ron l�v� term�kek �tlagos egys�g�r�t. */

/* 05. Add meg a minimumk�szlet al� cs�kkent nem kifutott term�kek nev�t �s darabsz�m�t term�kn�v szerinti sorrendben. */

/* 06. Add meg a 10 legnagyobb rakt�ri �ssz�rt�kkel rendelkez� term�k nev�t, besz�ll�t�j�t, �rt�kszerinti cs�kken� sorrendben. */

/* 07.Add meg az 1995 els� f�l�v�ben sz�letett rendel�sek megrendel�ssz�m�t, megrendel�j�t �s az alkalmazott nev�t, aki a megrendel�st bonyol�totta. */

/* 08. Add meg annak a 3 alkalmazottnak a nev�t, akik 1995-ben a legkevesebb rendel�seket bonyol�totta. */

/* 09. A k�vetkez� p�lda minden olyan rekord Felettes mez�j�t 5-re �ll�tja, amelynek jelenleg 2 az �rt�ke. */

/* 10. A k�vetkez� p�lda minden olyan term�k egys�g�r�t megn�veli 10 sz�zal�kkal, amely a 8. sz�m� sz�ll�t�t�l sz�rmazik, �s amelyb�l van rakt�ron. */

/* 11. A k�vetkez� p�lda minden olyan term�k egys�g�r�t cs�kkenti 10 sz�zal�kkal, amely a Tokyo Traders nev� sz�ll�t�t�l sz�rmazik, �s amelyb�l van rakt�ron.  */

/* 12. Add meg a term�kek kateg�ri�nk�nti �tlagos egys�g�r�t! */


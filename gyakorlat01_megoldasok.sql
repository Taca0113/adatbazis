/*
1. Listázzuk a <span style="color: #800000;">`kolcsonzes`</span> tábla következő oszlopait: ID, ki\_datum, vissza\_datum! 



  



a.  Az ID oszlop neve legyen Azonosító



b.  A ki\_datum oszlop neve legyen Kölcsönzés\_dátuma



c.  A vissza\_datum oszlop neve legyen Visszahozatal\_dátuma
*/

SELECT ID as 'Azonosító', 
       ki_datum as 'Kölcsönzés_dátuma', 
       vissza_datum as 'Visszahozatal_dátuma'
FROM kolcsonzesek

/*
2. Melyek azok a kölcsönzések, amelyek 2005.01.01 és 2007.01.01 között történtek?
*/

SELECT *
FROM kolcsonzesek
WHERE ki_datum BETWEEN '2005.01.01' AND '2007.01.01'

/*
3. Melyek azok a tagok, akiknek kedvenc stílusa a játék, és nevük a-ra végződik?



  



a.  Csak a tagok neve jelenjen meg, az oszlop neve Név legyen
*/

SELECT nev as 'Név'
FROM tagok
WHERE kedvencstilus='játék' AND nev LIKE '%a'

/*
4. Listázzuk egy oszlopban a tagok nevét, címét és kedvenc stílusát összefűzve! 



  



a.  A nevet, címet és a stílust kötőjellel válasszuk el



b.  A kötőjelek előtt és után legyen 1-1 szóköz



c.  Az oszlop neve legyen TAG



d.  Kinga keresztnevű tagok ne legyenek benne a listában
*/

SELECT nev +' - '+cim+' - '+ kedvencstilus AS 'TAG'
FROM tagok
WHERE nev NOT LIKE '%Kinga'

/*
5. Mennyi lenne a dvd-k nettó ára, ha 20%-kal csökkenne? 



  



a.  Csak a dvd-k címét és a csökkentett árat jelenítsük meg



b.  A csökkentett árat nevezzük el diszkont\_ar-nak
*/

SELECT id, 
       cim, 
       nettoar*0.8 AS 'diszkont_ar'
FROM dvd

/*
6. Melyek azok a kölcsönzések, ahol még nem hozták vissza a dvd-t?
*/

SELECT *
FROM kolcsonzesek
WHERE vissza_datum IS NULL

/*
7. Listázzuk azon diákok nevét és születési idejét, akik 1984-ben vagy 1985-ben születtek!  



  



a.  A születési dátum csak az évet, hónapot és a napot tartalmazza! 



b.  A születési dátum oszlopát nevezzük el 'Születési idő'-nek!
*/

SELECT Nev, 
       CAST(Szulido AS DATE) AS 'Születési idő'
FROM diak
WHERE YEAR(Szulido) in (1984, 1985)

/*
8. Készítsünk lekérdezést, amely a tanulók nevét és az ebből képzett felhasználói nevét tartalmazza. 



  



a.  A felhasználói név álljon a név első kettő, illetve utolsó kettő betűjének összefűzéséből!



b.  A listát szűrjük azon tanulókra, akik teljes neve - szóközzel együtt - legalább 10 betűs!
*/

SELECT Nev, 
       LEFT(Nev, 2) + RIGHT(Nev, 2) AS 'Felhasználói név'
FROM diak
WHERE LEN(Nev) >=10

/*
9. Készítsünk listát a diákok adatairól, ahol a diákok neve úgy jelenik meg, hogy először a keresztnév, majd a vezetéknév, közöttük szóközzel!  



a.  Ezen felül a születési idő három külön oszlopban jelenjen meg (év, hónap, nap). 



b.  Az oszlopokat nevezzük el értelemszerűen!
*/

SELECT DiakAz AS 'Azonosító',
       RIGHT(Nev, LEN(Nev)-CHARINDEX(' ',Nev))+' '+
            LEFT(Nev, CHARINDEX(' ',Nev)-1) AS 'Nev',
	   YEAR(Szulido) AS 'Születési év',
	   MONTH(Szulido) AS 'Születési hónap',
	   DAY(Szulido) AS 'Születési nap'
FROM diak

/*
10. Készítsünk listát a munkák azonosítójáról és megnevezéséről! Egy új oszlopban azt is jelenítsük meg, hogy melyik munka hetente mennyit fizet! 



a.  Az oszlop neve legyen Heti bér, az értéket kerekítsük 1000 forintra! 



b.  A listát szűrjük azon rekordokra, ahol a kerekített heti bér 10000 Ft felett van!
*/

SELECT munkaId,
       allas,
	   ROUND(oradij * oraszam * 5, -3) AS 'Heti bér'
FROM munka
WHERE ROUND(oradij * oraszam * 5, -3)> 10000


/*
11. A diákok számára differenciált béremelést terveznek: a középiskolások esetében 33%, egyéb esetben 17% mértékben. Készítsünk listát, amely tartalmazza a munkák azonosítóját, az állás nevét, az eredeti óradíjat és a tervezett emelt óradíjat.



  



a.  Az oszlopoknak adjuk nevet értelemszerűen!



b.  Az emelt óradíj összegét kerekítsük egészre! (Az esetlegesen megjelenő 0 tizedesjegyekkel ne foglalkozzunk)
*/

SELECT munkaid AS 'Munka azonosítája',
	   oradij AS 'Eredeti óradíj',
	   ROUND(oradij * IIF(kozepiskolas = 1, 1.33, 1.17), 0) 
       AS 'Emelt óradíj'
FROM munka

/*
12. A diákok számára próbaidőt írnak elő, amely a munka kezdetétől számítva 3 hónapig tart.    Jelenítsük meg a munka tábla adatait egy új oszloppal kiegészítve, amelyik a próbaidő    végének dátumát mutatja!  



  



a.  Az oszlop neve Próbaidő vége legyen! 



b.  A lista ne tartalmazza azokat a munkákat, ahol a diákok azonosítója nincs megadva!
*/

SELECT *,
       DATEADD(month, 3, datum) AS 'Próbaidő vége'
FROM   munka
WHERE  DiakAz IS NOT NULL

/*
13. Készítsünk listát a munkák azonosítóiról és a megnevezésükről! A megnevezés allas-óraszám formában jelenjen meg, pl: eladó-4. 



  



a.  Jelenítsük meg a dátumot is, de csak a évet és a hónapot, pl: 2003-07! 



b.  Ennek az oszlopnak 'Kezdés hónapja' legyen a neve! A listát szűrjük a nyári hónapokra!
*/

SELECT munkaId,
       allas + '-'+ CAST(oraszam AS varchar(1)) AS 'Megnevezés',
       LEFT(CAST(datum AS date), 7) AS 'Kezdés hónapja'
FROM munka
WHERE MONTH(datum) IN (6, 7, 8)

/*
14. Készítsünk listát a diákok adatairól, amely a Nev oszlop helyén a diák monogramját jeleníti meg (keresztnév, illetve vezetéknév első betűje összefűzve). 



a.  A listát szűrjük 1983.01.01 és 1987.06.01 között született diákokra!
*/

SELECT DiakAz,
       LEFT(Nev, 1)+LEFT(RIGHT(NEV, LEN(NEV)-CHARINDEX(' ',NEV)),1) AS 'Nev'
FROM diak
WHERE Szulido BETWEEN '1983.01.01' AND '1987.06.01'

/*
15. A diákok a munkakezdés évének utolsó napján bónuszt kapnak, amennyiben az adott évben legalább 6 hónapot dolgoznak. 



  



a.  Jelenítsük meg, hogy az egyes munkák adatait, egy új oszlopban az éves bónusz napját is 'Bónusz dátum' néven! 



b.  A lista csak a bónuszra jogosultak adatait tartalmazza!
*/

SELECT *,
       CAST(CAST(YEAR(datum) AS VARCHAR(4))+'-12-31' AS DATE) 
       AS 'Bónusz dátum'
FROM munka
WHERE DATEDIFF(month, datum, CAST(CAST(YEAR(datum) 
      AS VARCHAR(4))+'-12-31' AS DATE))>=6
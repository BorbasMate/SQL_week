USE production;

# --GROUP BY
/* 1. Jelen�tsd meg, h�ny term�k van az adatb�zisban aszerint csoportos�tva,
	hogy h�ny nap alatt lehet legy�rtani �ket (DaysToManufacture)! */

SELECT DaysToManufacture, COUNT(*) NumberOfProducts
FROM Product
GROUP BY DaysToManufacture;

/* 2. Jelen�tsd meg gy�rt�si id� �s sz�nek szerint csoportos�tva, hogy az egyes
	kateg�ri�kban h�ny term�k van, valamint mennyibe ker�l a legolcs�bb �s a legdr�g�bb! */

SELECT Color,
       DaysToManufacture,
       ProductSubcategoryID,
       COUNT(*)       NumberOfProductsInCategory,
       MAX(ListPrice) MostExpensive,
       MIN(ListPrice) Cheapest
FROM Product
GROUP BY DaysToManufacture, Color, ProductSubcategoryID;

/* 3. Jelen�tsd meg, hogy alkateg�ri�kra bontva (ProductSubcategory) h�ny term�k kaphat�
	�s mennyi az �tlagos �r alkateg�ri�nk�nt! */

SELECT ps.ProductSubcategoryID, ps.Name, COUNT(*) NumberOfProducts, AVG(ListPrice) AverageListPrice
FROM Product p
         JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.ProductSubcategoryID, ps.Name;

/* 4. Jelen�tsd meg, hogy f�kateg�ri�kra bontva (ProductCategory)
   h�ny term�k kaphat� �s mennyi az �tlagos �r f�kateg�ri�nk�nt! */

SELECT ProductCategory.Name, COUNT(*) NumberOfProducts, AVG(ListPrice) AvgListPrice
FROM Product
         JOIN ProductSubcategory ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
         JOIN ProductCategory ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
GROUP BY ProductCategory.Name;


/* 5. Jelen�tsd meg minden term�k nev�t, �s hogy mennyi az �sszes k�szlet szumm�ja bel�le
	(hint: ProductInventory)! */

SELECT p.Name, SUM(pi.Quantity) AS SumOfQty
FROM Product p
         LEFT JOIN ProductInventory pi ON p.ProductID = pi.ProductID
GROUP BY p.Name;


/* 6. Jelen�tsd meg minden term�k nev�t �s sz�n�t egy�tt 'n�v - sz�n' form�tumban,
	valamint a hozz� tartoz� lista�rat. Csak azokat a term�keket jelen�tsd meg,
	amiknek van sz�ne! */

SELECT concat(p.Name, ' - ', p.Color) NameANDColor, p.ListPrice
FROM Product p
WHERE Color != 'NULL';


/* 7. Jelen�tsd meg az egyes rakt�rhelyis�gek (Location) nev�t,
	a f�kateg�ri�k nev�t (ProductCategory),
	�s hogy az adott rakt�rban �s az adott f�kateg�ri�b�l h�ny fajta term�ket �rulunk. */

SELECT l.Name, pc.Name, COUNT(*) NumberOfProducts
FROM Product p
         JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
         JOIN ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
         JOIN ProductInventory pi ON p.ProductID = pi.ProductID
         JOIN Location l on l.LocationID = pi.LocationID
GROUP BY l.Name, pc.Name;



# --INSERT DELETE UPDATE
/* 1. Vegy�l fel egy �j f�kateg�ri�t (ProductCategory), aminek a neve legyen 'Komputers',
	az utols� m�dos�t�s ideje pedig 2011 janu�r 1, 0 �ra 0 perc 0 m�sodperc.
	A d�tum-id� megad�s�n�l haszn�ld az ISO form�tumot! */

INSERT INTO ProductCategory
    (Name, ModifiedDate)
VALUES ('Komputers', '2011-01-01');


/* 2. Vegy�l fel m�g k�t �j f�kateg�ri�t egy utas�t�sban, aminek
	a nevei legyenek 'Games' �s 'Frogs',
	az utols� m�dos�t�s ideje pedig 2011 janu�r 1, 0 �ra 0 perc 0 m�sodperc.
	A d�tum-id� megad�s�n�l haszn�ld az ISO form�tumot! */

INSERT INTO ProductCategory
    (Name, ModifiedDate)
VALUES ('Games', '2011-01-01'),
       ('Frogs', '2011-01-01');


/* 3. Vedd �szre, hogy elg�pelted a 'Computers' sz�t, �s m�g miel�tt b�rki �szrevenn�
	a dolgot, gyorsan jav�tsd ki a f�kateg�ria nev�t! */

UPDATE ProductCategory
SET Name = 'Computers'
WHERE Name = 'Komputers';

/* 4. Vegy�l fel k�t �j alkateg�ri�t (ProductSubcategory) egy utas�t�sban, amiknek
	a nevei legyenek 'Notebooks' �s 'Gaming PCs',
	�s tartozzanak a Computers f�kateg�ri�hoz!
	A m�dos�t�s d�tuma legyen az aktu�lis id�! */

INSERT INTO ProductSubcategory
    (Name, ProductCategoryID)
VALUES ('Notebooks', (SELECT pc.ProductCategoryID
                      FROM ProductCategory pc
                      WHERE pc.Name = 'Computers'
                      LIMIT 1)),
       ('Gaming PCs', (SELECT pc.ProductCategoryID
                       FROM ProductCategory pc
                       WHERE pc.Name = 'Computers'
                       LIMIT 1));

/* 5. Vegy�l fel egy �j alkateg�ri�t, aminek a neve legyen 'Strategy Games',
	f�kateg�ri�nak �ll�tsd be a 'Frogs' f�kateg�ri�t! */

INSERT INTO ProductSubcategory
    (Name, ProductCategoryID)
VALUES ('Strategy Games', (SELECT pc.ProductCategoryID
                           FROM ProductCategory pc
                           WHERE pc.Name = 'Frogs'
                           LIMIT 1));


/* 6. Vedd �szre, hogy a strat�giai j�t�kok nem b�k�k, �s jav�tsd a f�kateg�ri�j�t
	a 'Games' azonos�t�j�ra! */

UPDATE ProductSubcategory
SET ProductCategoryID = (SELECT pc.ProductCategoryID
                         FROM ProductCategory pc
                         WHERE pc.Name = 'Games'
                         LIMIT 1)
WHERE Name = 'Strategy Games';


/* 7. Vedd �szre, hogy nem is akarsz b�k�kat �rulni, �s t�r�ld a 'Frogs' f�kateg�ri�t! */

DELETE
FROM ProductCategory
WHERE Name = 'Frogs';


/* 8. Vedd �szre, hogy m�g a d�tumokat is elrontottad, �s m�dos�tsd
	a 'Computers' �s a 'Games' f�kateg�ri�k d�tum�t az aktu�lis id�pontra,
	egy utas�t�sban! */

UPDATE ProductCategory
SET ModifiedDate = current_timestamp
WHERE Name LIKE 'Computers'
   OR Name LIKE 'Games';

UPDATE ProductCategory
SET ModifiedDate = current_timestamp
WHERE Name IN ('Computers', 'Games');


# --MULTITABLE SELECT
/* 1. Jelen�tsd meg a term�kek �s a hozz�juk tartoz� alkateg�ria nev�t.
	Ha egy term�knek nincs alkateg�ri�ja, akkor kihagyhatod. */

SELECT p.Name, ps.Name
FROM Product p
         RIGHT JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID;


/* 2. Jelen�tsd meg a term�kek �s a hozz�juk tartoz� f�kateg�ria nev�t.
	Azokat a term�keket is jelen�tsd meg, amiknek nincs kateg�ri�ja.*/

SELECT p.Name, pc.Name
FROM Product p
         LEFT JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
         LEFT JOIN ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID;

/* 3. Jelen�tsd meg azon term�kek nev�t, amik a 'Bikes'
	vagy a 'Clothing' f�kateg�ri�ba tartoznak. */

SELECT p.Name, pc.Name
FROM Product p
         JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
         JOIN ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name IN ('Clothing', 'Bikes');


/* 4. Jelen�tsd meg a term�kek ID-j�t, nev�t �s alkateg�ri�j�nak nev�t, az alkateg�ria neve
	szerint n�vekv�, majd azon bel�l �r szerint cs�kken� sorrendben. */

SELECT p.ProductID, p.Name, ps.Name, p.ListPrice
FROM Product p
         JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
ORDER BY ps.Name, p.ListPrice DESC;

/* 5. Jelen�tsd meg azon rakt�rhelys�gek nev�t, ahol van legal�bb egy olyan term�k, amib�l
	t�bb, mint 500 darab van ott t�rolva. B�nusz: egy n�v csak egyszer legyen megjelen�tve.
	Hint: a Location �s a ProductInventory t�bl�kra lesz sz�ks�ged. */

SELECT l.Name
FROM Location l
         JOIN ProductInventory pi ON l.LocationID = pi.LocationID
WHERE pi.Quantity >= 500
GROUP BY l.Name;

SELECT DISTINCT l.Name
FROM Location l
         JOIN ProductInventory pi ON l.LocationID = pi.LocationID
WHERE pi.Quantity >= 500;

/* 6. Jelen�tsd meg a term�kek nev�t �s hogy milyen rakt�rhelyis�gben h�ny darabot t�rolunk
	bel�l�k,a darabsz�m szerint cs�kken�, a term�k szerint n�vekv�, majd a rakt�rhelyis�g
	neve szerint n�vekv� sorrendben. */

SELECT p.Name, l.Name, SUM(pi.Quantity) AS Sum
FROM Product p
         JOIN ProductInventory pi ON p.ProductID = pi.ProductID
         JOIN Location l ON pi.LocationID = l.LocationID
GROUP BY P.Name, l.Name
ORDER BY Sum DESC, p.Name, l.Name;

/* 7. Jelen�tsd meg a 20 legdr�g�bb term�k nev�t, a rakt�rhelyis�g nev�t, ahol t�roljuk
	�s a darabsz�mot, amit ott t�rolunk. */

SELECT p.Name, l.Name, pi.Quantity, p.ListPrice
FROM Product p
         JOIN ProductInventory pi ON p.ProductID = pi.ProductID
         JOIN Location l ON pi.LocationID = l.LocationID
ORDER BY p.ListPrice DESC
LIMIT 20;


/* 8. Jelen�tsd meg a rakt�rhelyis�g nev�t, a term�k nev�t, a t�rolt darabsz�mot
	�s az alkateg�ria nev�t a 20 legolcs�bb term�kr�l, amiknek az �ra
	legal�bb 1000 �s a 'Bikes' kateg�ri�ba tartoznak. */

SELECT l.Name, p.Name, pi.Quantity, ps.Name
FROM Product p
         JOIN ProductInventory pi ON p.ProductID = pi.ProductID
         JOIN Location l ON pi.LocationID = l.LocationID
         JOIN ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
         JOIN ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice >= 1000
  AND pc.Name = 'Bikes'
ORDER BY p.ListPrice
LIMIT 20;


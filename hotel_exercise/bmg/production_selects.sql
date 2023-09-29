USE production;


SELECT * FROM Product;

SELECT Name, Color, Size, ListPrice FROM Product;

SELECT * FROM Product
WHERE Color IN ('Silver', 'Red', 'Blue');

SELECT * FROM Product
WHERE Color = 'Silver'
   OR Color = 'Red'
   OR Color = 'Blue';

SELECT * FROM Product
WHERE name LIKE 'Touring%';

SELECT * FROM Product
WHERE name LIKE '%Touring%';

SELECT * FROM Product
WHERE SellStartDate >'2011-01-01 00:00:00';

SELECT * FROM Product
WHERE SellStartDate BETWEEN '2011-01-01 00:00:00' AND '2013-01-01 00:00:00';

SELECT Name ProductName, Color ProductColor, Size ProductSize FROM Product;

SELECT * FROM Product
WHERE Size LIKE 'NULL' AND Color LIKE 'NULL' ;

SELECT * FROM Product
WHERE SellStartDate >'2011-01-01 00:00:00' AND SellStartDate LIKE '_____05%';

SELECT name, monthname(SellStartDate) AS month FROM Product
WHERE SellStartDate > '2011-01-01 00:00:00'
HAVING month = 'May';

SELECT * FROM Product
WHERE SellStartDate > '2012-01-01 00:00:00'
  AND Color IN ('Red', 'Blue', 'Black')
  AND ListPrice BETWEEN 1000 AND 1400
  AND Name LIKE '%Touring%';

SELECT Name, ListPrice FROM Product
ORDER BY ListPrice ASC;

/* 1. Kérdezd le a teljes Production.Product táblát! /
/ 2. Kérdezd le a Name, Color, Size és ListPrice oszlopokat a Production.Product táblából! /
/ 3. Kérdezd le azokat a termékeket, amiknek a színe ezüst, piros vagy kék!
    Írd meg két féle képpen is a lekérdezést! /
/ 4. Kérdezd le azokat a termékeket, amiknek a neve a 'Touring' karaktersorral kezdődik! /
/ 5. Kérdezd le azokat a termékeket, amiknek a neve bárhol tartalmazza a 'Touring' karaktersort! /
/ 6. Kérdezd le azokat a termékeket, amiket 2011 január 1-e után kezdtünk el árusítani! /
/ 7. Kérdezd le azokat a termékeket, amiket 2011 január 1-e
    és 2013 január 1-e között kezdtünk el árusítani! /
/ 8. Kérdezd le az összes termék nevét, színét és méretét úgy, hogy az oszlopfejléceket
    nevezd át a ProductName, ProductColor és ProductSize értékekre! /
/ 9. Kérdezd le az összes olyan terméket, aminek sem a színét, sem a méretét nem ismerjük! /
/ 10. Kérdezd le az összes olyan terméket, amiket 2011-ben vagy bármelyik év májusában
    kezdtünk el árusítani! /
/ 11. Kérdezd le az összes olyan terméket, amit 2012-ben vagy azután kezdtünk el árusítani,
    a színe piros, kék vagy fekete,
    az ára 1000 és 1400 között van,
    és a nevük tartalmazza bárhol a 'Touring' karaktersort! */
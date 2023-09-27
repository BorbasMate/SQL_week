-- Kérdezzük le az összes olyan felhasználót, akiknek Budapesti címük van. Figyelj arra hogy a városnév rövidítve is szerepelhet!
SELECT *
FROM account
WHERE address like '%bp%'
   OR address like '%budapest%';

-- Kérdezzük le, hogy Budapesten hány darab hotel van összesen, típusonként!
SELECT hotel_type, count(id)
FROM hotel.hotel
WHERE city like 'Budapest'
group by hotel_type;

-- Kérdezzük le az összes olyan hotel nevét, amiben van egyágyas szoba

-- Kérdezzük le az összes felhasználó teljes nevét összefűzve (firstname, lastname) és a foglalásaik összértékét,

-- a foglalások értéke szerint csökkenő sorrendben, akkor is ha nincsen nekik

-- Jelenítsük meg minden szoba képének url címét és a hozzá tartozó hotelről készült képek számát

-- Kérdezzük le, hogy Pécsen hány darab hotel van összesen, típusonként!

-- Kérdezzük le az összes hotel nevét, a hozzá tartozók szobák nevét, és azok foglalásait.

-- A szobákat akkor is írassuk ki, ha nem tartozik hozzá foglalás.

-- Kérdezzük le azoknak a felhasználóknak a vezeték és keresztnevét, akikhez NEM tartozik foglalás.

-- Kérdezzük le azoknak a hoteleknek a nevét, amelyekhez legalább 5 hotel_feature tartozik.

-- Jelenítsük meg minden hotel nevét és a hozzájuk tartozó feature számát a hotel neve szerint csoportosítva. Azok a hotelek is jelenjenek meg, amelyekhez nincs feature rendelve!

-- Jelenítsük meg azoknak a hoteleknek a nevét és a hozzájuk tartozó szobák számát, amiknek legalább egy szobájuk van!

-- Azoknak a szobáknak, amikre van foglalás, jelenítsük meg a nevét, a foglalás kezdeti és vég dátumát!

-- Jelenítsük meg az összes olyan felhasználót és az aktiváló tokenjük létrehozási dátumát, akik 2020. Augusztus 4-e után regisztráltak!

-- Jelenítsük meg a szobák neveit és a hozzájuk tartozó feature-öket!

-- Jelenítsük meg az összes hotel nevét, és a kiadó szobáik összterületét terület szerint csökkenő sorrendben!

-- Jelenítsük meg az összes olyan hotel nevét, amiben van egyágyas szoba!

-- Jelenítsük meg az összes felhasználó nevét (username) és a foglalásaik összértékét, a foglalások értéke szerint csökkenő sorrendben!

-- Jelenítsük meg a nevét és a szobáinak típusát azoknak a hoteleknek, amiknek a neve K-val kezdődik!

-- (3 tábla kapcsolása) Jelenítsük meg a foglalások teljes árát, kezdeti és végdátumait a foglalást intéző felhasználó nevével!

-- Jelenítsük meg az összes aktív felhasználót és a felhasználóknak a foglalásukhoz fűzött megjegyzéseit!

-- (három tábla összekötése, de csak kettő megjelenítése) Jelenítsük meg minden hotel képének url címét és a hotelhez tartozó szobákról készült képek számát!

-- Jelenítsük meg azokat a felhasználókat, akiknek van hoteljük, és a hozzájuk tartozó hotel nevét!

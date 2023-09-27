-- Kérdezzük le az összes olyan felhasználót, akiknek Budapesti címük van. Figyelj arra hogy a városnév rövidítve is szerepelhet!

-- Kérdezzük le, hogy Budapesten hány darab hotel van összesen, típusonként!

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

create database hotel;

show databases ;

show tables;

use hotel;

SELECT * FROM hotel;

-- Kérdezzük le az összes olyan felhasználót, akiknek Budapesti címük van. Figyelj arra hogy a városnév rövidítve is szerepelhet!
SELECT a.username, a.address FROM hotel h RIGHT JOIN account a
                                                     ON h.id = a.hotel_id WHERE a.address LIKE '%BP%' OR a.address LIKE 'BUD%';

-- Kérdezzük le, hogy Budapesten hány darab hotel van összesen, típusonként!
SELECT hotel_type, COUNT(*)  FROM hotel WHERE city LIKE 'Bud%' GROUP BY hotel_type;

-- Kérdezzük le az összes olyan hotel nevét, amiben van egyágyas szoba
SELECT DISTINCT h.name, r.number_of_beds FROM hotel h JOIN room r ON h.id = r.hotel_id WHERE r.number_of_beds = 1;

-- Kérdezzük le az összes felhasználó teljes nevét összefűzve (firstname, lastname) és a foglalásaik összértékét,
SELECT concat(a.firstname, ' ', a.lastname) AS Fullname, SUM(b.room_price) AS Total FROM booking b LEFT JOIN account a
                                                                                                             ON b.guest = a.user_id GROUP BY a.user_id;

-- a foglalások értéke szerint csökkenő sorrendben, akkor is ha nincsen nekik
SELECT * FROM booking ORDER BY room_price DESC;

-- Jelenítsük meg minden szoba képének url címét és a hozzá tartozó hotelről készült képek számát
SELECT hotel_image_urls, (SELECT COUNT(*) FROM hotel_hotel_image_urls h2 WHERE h1.hotel_id = h2.hotel_id) AS Photos
FROM hotel_hotel_image_urls h1;

-- Kérdezzük le, hogy Pécsen hány darab hotel van összesen, típusonként!
SELECT city, hotel_type, COUNT(*) FROM hotel.hotel WHERE city LIKE 'Pécs' GROUP BY hotel_type, city;

-- Kérdezzük le az összes hotel nevét, a hozzá tartozók szobák nevét, és azok foglalásait.
SELECT h.name, r.room_name, rr.booking_id FROM hotel h
                                                   LEFT JOIN room r ON h.id = r.hotel_id
                                                   LEFT JOIN room_reservation rr ON r.id = rr.room_id
WHERE rr.booking_id IS NOT NULL;

-- A szobákat akkor is írassuk ki, ha nem tartozik hozzá foglalás.
SELECT h.name, r.room_name, rr.booking_id FROM hotel h
                                                   LEFT JOIN room r ON h.id = r.hotel_id
                                                   LEFT JOIN room_reservation rr ON r.id = rr.room_id;

-- Kérdezzük le azoknak a felhasználóknak a vezeték és keresztnevét, akikhez NEM tartozik foglalás.
SELECT a.lastname, a.firstname, b.id FROM account a
                                              LEFT JOIN booking b ON a.user_id = b.guest
WHERE b.guest IS NULL;

-- Kérdezzük le azoknak a hoteleknek a nevét, amelyekhez legalább 5 hotel_feature tartozik.
SELECT h.name, COUNT(hf.hotel_features) FROM hotel h
                                                 JOIN hotel_features hf ON h.id = hf.hotel_id
GROUP BY h.name
HAVING COUNT(hf.hotel_features) >= 5;

-- Jelenítsük meg minden hotel nevét és a hozzájuk tartozó feature számát a hotel neve szerint csoportosítva.
-- Azok a hotelek is jelenjenek meg, amelyekhez nincs feature rendelve!
SELECT  h.name, COUNT(hf.hotel_features) FROM hotel h
                                                  LEFT JOIN hotel_features hf ON h.id = hf.hotel_id
GROUP BY h.name;

-- Jelenítsük meg azoknak a hoteleknek a nevét és a hozzájuk tartozó szobák számát, amiknek legalább egy szobájuk van!
SELECT h.name, COUNT(r.id) FROM hotel h
                                    JOIN room r ON h.id = r.hotel_id
GROUP BY h.name;

-- Azoknak a szobáknak, amikre van foglalás, jelenítsük meg a nevét, a foglalás kezdeti és vég dátumát!
SELECT r.room_name, rr.start_date, rr.end_date FROM room r
                                                        JOIN room_reservation rr ON r.id = rr.room_id;

-- Jelenítsük meg az összes olyan felhasználót és az aktiváló tokenjük létrehozási dátumát,
-- akik 2020. Augusztus 4-e után regisztráltak!
SELECT a.lastname, a.firstname, ct.created_date FROM account a
                                                         JOIN confirmation_token ct ON a.user_id = ct.user_id
WHERE ct.created_date > '2020-08-05 00:00:00';

-- Jelenítsük meg a szobák neveit és a hozzájuk tartozó feature-öket!
# SELECT r.room_name, hf.hotel_features FROM room r
    #     JOIN hotel h ON r.hotel_id = h.id
      #     JOIN hotel_features hf ON h.id = hf.hotel_id;
SELECT r.id, r.room_name, rr.room_room_features FROM room r JOIN room_room_features rr;

-- Jelenítsük meg az összes hotel nevét, és a kiadó szobáik összterületét terület szerint csökkenő sorrendben!
SELECT h.name, SUM(r.room_area) FROM hotel h
                                         JOIN room r ON h.id = r.hotel_id
                                         LEFT JOIN room_reservation rr ON r.id = rr.room_id WHERE rr.room_id IS NULL
GROUP BY h.name
ORDER BY SUM(r.room_area) DESC;

-- Jelenítsük meg az összes olyan hotel nevét, amiben van egyágyas szoba!
SELECT DISTINCT h.name FROM hotel h
                                JOIN room r ON h.id = r.hotel_id
Where r.number_of_beds = 1;

-- Jelenítsük meg az összes felhasználó nevét (username) és a foglalásaik összértékét,
-- a foglalások értéke szerint csökkenő sorrendben!
SELECT a.username, SUM(b.room_price) FROM account a
                                              JOIN booking b ON a.user_id = b.guest
GROUP BY a.username
ORDER BY SUM(b.room_price) DESC;

-- Jelenítsük meg a nevét és a szobáinak típusát azoknak a hoteleknek, amiknek a neve K-val kezdődik!
SELECT h.name, r.room_type FROM hotel h
                                    JOIN room r ON h.id = r.hotel_id
WHERE h.name LIKE 'K%';

-- (3 tábla kapcsolása) Jelenítsük meg a foglalások teljes árát,
-- kezdeti és végdátumait a foglalást intéző felhasználó nevével!
SELECT b.id, SUM(b.room_price), rr.start_date, rr.end_date, concat(a.firstname, ' ', a.lastname)
FROM booking b
         JOIN room_reservation rr ON b.id = rr.booking_id
         JOIN account a ON b.guest = a.user_id
GROUP BY b.id, rr.start_date, rr.end_date;

-- Jelenítsük meg az összes aktív felhasználót és a felhasználóknak a foglalásukhoz fűzött megjegyzéseit!
SELECT b.id, a.lastname, a.firstname, b.remark FROM account a
                                                        JOIN booking b ON a.user_id = b.guest
WHERE a.is_enabled = 'true'

-- (három tábla összekötése, de csak kettő megjelenítése) Jelenítsük meg minden hotel képének url címét
-- és a hotelhez tartozó szobákról készült képek számát!
SELECT h.name, hhiu.hotel_image_urls,
       (SELECT COUNT(r.room_image_url) FROM hotel h2
                                                JOIN room r ON h.id = r.hotel_id WHERE h2.name = h.name GROUP BY h.id)
FROM hotel h
         JOIN hotel_hotel_image_urls hhiu ON h.id = hhiu.hotel_id;

-- Jelenítsük meg azokat a felhasználókat, akiknek van hoteljük, és a hozzájuk tartozó hotel nevét!
SELECT a.lastname, a.firstname, h.name FROM account a
                                                JOIN hotel h ON a.hotel_id = h.id;

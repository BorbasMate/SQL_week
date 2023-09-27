-- Kérdezzük le az összes olyan felhasználót, akiknek Budapesti címük van. Figyelj arra hogy a városnév rövidítve is szerepelhet!
SELECT * FROM account a WHERE address LIKE '%BP%' or address LIKE '%BUDAPEST%';

-- Kérdezzük le, hogy Budapesten hány darab hotel van összesen, típusonként!
SELECT h.hotel_type, count(*) FROM hotel h WHERE city='BUDAPEST' GROUP BY h.hotel_type;

-- Kérdezzük le az összes olyan hotel nevét, amiben van egyágyas szoba
SELECT hotel.name FROM hotel join room on hotel.id = room.hotel_id WHERE number_of_beds = 1;
SELECT hotel.name FROM hotel join room on hotel.id = room.hotel_id WHERE room_type = 'EGYAGYASSZOBA';

-- Kérdezzük le az összes felhasználó teljes nevét összefűzve (firstname, lastname) és a foglalásaik összértékét,
 -- a foglalások értéke szerint csökkenő sorrendben, akkor is ha nincsen nekik
SELECT CONCAT(a.firstname, ' ', a.lastname ) fullname, sum(b.room_price) value FROM account a
    join booking b on a.user_id = b.guest GROUP BY fullname ORDER BY value desc;

-- Jelenítsük meg minden szoba képének url címét és a hozzá tartozó hotelről készült képek számát
SELECT r.room_image_url, count(hhiu.hotel_image_urls) FROM room r
    join hotel h on h.id = r.hotel_id
    join hotel_hotel_image_urls hhiu on h.id = hhiu.hotel_id
GROUP BY r.room_image_url;
SELECT r.room_image_url, count(hhiu.hotel_image_urls) FROM room r
    join hotel_hotel_image_urls hhiu on r.hotel_id = hhiu.hotel_id
GROUP BY r.room_image_url;

-- Kérdezzük le, hogy Pécsen hány darab hotel van összesen, típusonként!
SELECT count(*), hotel_type FROM hotel WHERE city LIKE 'pécs' GROUP BY hotel_type;

-- Kérdezzük le az összes hotel nevét, a hozzá tartozók szobák nevét, és azok foglalásait.
-- A szobákat akkor is írassuk ki, ha nem tartozik hozzá foglalás.
SELECT h.name, r.room_name, rr.start_date, rr.end_date FROM hotel h
    left join room r on h.id = r.hotel_id
    left join room_reservation rr on r.id = rr.room_id;

-- Kérdezzük le azoknak a felhasználóknak a vezeték és keresztnevét, akikhez NEM tartozik foglalás.
SELECT a.firstname, a.lastname FROM account a left join booking b on a.user_id = b.guest WHERE b.id IS NULL;
SELECT a.firstname, a.lastname FROM account a left join booking b on a.user_id = b.guest WHERE b.date_of_booking IS NULL;

-- Kérdezzük le azoknak a hoteleknek a nevét, amelyekhez legalább 5 hotel_feature tartozik.
SELECT h.name FROM hotel h join hotel_features hf on h.id = hf.hotel_id GROUP BY h.name having count(hotel_features) > 4;
select h.name from hotel h join hotel_features hf on h.id = hf.hotel_id group by h.id having count(hf.hotel_id) >= 5;

-- Jelenítsük meg minden hotel nevét és a hozzájuk tartozó feature számát a hotel neve szerint csoportosítva.
-- Azok a hotelek is jelenjenek meg, amelyekhez nincs feature rendelve!

select h.name, count(hf.hotel_id)
from hotel h
         left join hotel_features hf on h.id = hf.hotel_id
group by h.name;

-- Jelenítsük meg azoknak a hoteleknek a nevét és a hozzájuk tartozó szobák számát, amiknek legalább egy szobájuk van!

select h.name, count(*)
from hotel h
         join room r on h.id = r.hotel_id
group by h.name;

-- Azoknak a szobáknak, amikre van foglalás, jelenítsük meg a nevét, a foglalás kezdeti és vég dátumát!

select r.room_name, rr.start_date, rr.end_date
from room r
         join room_reservation rr on r.id = rr.room_id;

-- Jelenítsük meg az összes olyan felhasználót és az aktiváló tokenjük létrehozási dátumát, akik 2020. Augusztus 4-e után regisztráltak!

select a.*, ct.created_date
from account a
         join confirmation_token ct on a.user_id = ct.user_id
where registration_date > '2020-08-04 00:00:00.000000';

-- Jelenítsük meg a szobák neveit és a hozzájuk tartozó feature-öket!

select r.room_name, rrf.room_room_features
from room r
         left join room_room_features rrf on r.id = rrf.room_id;

-- Jelenítsük meg az összes hotel nevét, és a kiadó szobáik összterületét terület szerint csökkenő sorrendben!

select h.name, sum(r.room_area) as sum
from hotel h
         join room r on h.id = r.hotel_id
group by h.name
order by sum desc;

-- Jelenítsük meg az összes olyan hotel nevét, amiben van egyágyas szoba!

select h.name
from hotel h
         left join room r on h.id = r.hotel_id
where number_of_beds = 1
group by h.name;

select distinct h.name
from hotel h
         join room r on h.id = r.hotel_id
where number_of_beds = 1;

-- Jelenítsük meg az összes felhasználó nevét (username) és a foglalásaik összértékét, a foglalások értéke szerint csökkenő sorrendben!

select a.username, sum(b.room_price) as total_spending
from account a
         join booking b on a.user_id = b.guest
group by a.username
order by total_spending desc;

-- Jelenítsük meg a nevét és a szobáinak típusát azoknak a hoteleknek, amiknek a neve K-val kezdődik!

select distinct h.name, r.room_type
from hotel h
         join room r on h.id = r.hotel_id
where h.name like 'k%';


-- (3 tábla kapcsolása) Jelenítsük meg a foglalások teljes árát, kezdeti és végdátumait a foglalást intéző felhasználó nevével!

SELECT SUM(room_price) AS totalprice, start_date, end_date, CONCAT(firstname, ' ', lastname) AS name
FROM booking
         JOIN room_reservation rr on booking.id = rr.booking_id
         JOIN account a on booking.guest = a.user_id
GROUP BY start_date, end_date, name
ORDER BY totalprice DESC;

-- Jelenítsük meg az összes aktív felhasználót és a felhasználóknak a foglalásukhoz fűzött megjegyzéseit!

select concat(a.firstname, ' ', a.lastname) as name, b.remark
from account a
         left join booking b on a.user_id = b.guest
where a.is_enabled = true;

-- (három tábla összekötése, de csak kettő megjelenítése) Jelenítsük meg minden hotel képének url címét
-- és a hotelhez tartozó szobákról készült képek számát!

select hhiu.hotel_image_urls, count(r.room_image_url) from hotel_hotel_image_urls hhiu join room r on hhiu.hotel_id = r.hotel_id group by hhiu.hotel_image_urls;

-- Jelenítsük meg azokat a felhasználókat, akiknek van hoteljük, és a hozzájuk tartozó hotel nevét!

select concat(firstname, ' ', lastname), h.name from account a join hotel h on a.hotel_id = h.id;

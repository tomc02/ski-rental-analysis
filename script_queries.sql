/* 1;1;8;Vypis lyzi serazen dle ceny*/
SELECT ski_id, brand, model, description, length, price
FROM ski
ORDER BY price DESC

/* 1;2;5;Vypis vypujcek serazen dle planovane delky vyp.*/
SELECT rental_id, date_from, date_to, rental_status, date_returned, customer_user_id, employee_user_id
FROM rental
ORDER BY (DATEDIFF(SECOND,date_from,date_to))

/* 1;3;5;Vypis vypujcek a k nim delka v hodinach*/
SELECT rental_id, DATEDIFF(HOUR,date_from,date_to) as duration_hours
FROM rental

/* 1;4;8;Vypis lyzi a k nim castku za tyden pujdeni*/
SELECT ski_id,brand,model, price*7 as week_price
FROM ski
ORDER BY week_price

/* 2;1;4;Vypis lyzi ktere maji v popisu, ze maji rocker*/
SELECT ski_id, brand, model, length, category, price, description, skier_experience
FROM ski
WHERE ski.description LIKE '%rocker%'

/* 2;2;4;Vypis dlouhych drahych lyzi nebo kratkych levnych*/
SELECT ski_id, brand, model, length, category, price, description, skier_experience
FROM ski
WHERE (length > 180 AND price > 600) OR (length < 170 AND price < 500)

/* 2;3;3;Vypis neaktivnich vypujcek*/
SELECT rental_id, date_from, date_to, rental_status, date_returned, customer_user_id, employee_user_id
FROM rental
WHERE rental_status NOT LIKE 'Aktivni'

/* 2;4;1;Vypis vypujcek s trvanim 1 den*/
SELECT rental_id, date_from, date_to, rental_status, date_returned, customer_user_id, employee_user_id
FROM rental
WHERE DATEDIFF(DAY,date_from,date_to) = 1

/* 3;1;2;Vypis vsech lyzi, ktere jsou aktualne pujcene*/
SELECT ski_id, brand, model, length, category, price, description, skier_experience
FROM ski
WHERE ski_id IN (
    SELECT ski_id
    FROM rental_ski
    JOIN rental r2 on rental_ski.rental_id = r2.rental_id
    WHERE rental_status = 'Aktivni'
    )

/* 3;2;2;Vypis vsech lyzi, ktere jsou aktualne pujcene*/
SELECT ski_id, brand, model, length, category, price, description, skier_experience
FROM ski
WHERE EXISTS (
    SELECT ski_id
    FROM rental_ski s
    JOIN rental r2 on s.rental_id = r2.rental_id
    WHERE rental_status = 'Aktivni' AND s.ski_id = ski.ski_id
    )

/* 3;3;2;Vypis vsech lyzi, ktere jsou aktualne pujcene*/
SELECT ski_id, brand, model, length, category, price, description, skier_experience
FROM ski
INTERSECT
SELECT s2.ski_id, brand, model, length, category, price, description, skier_experience
FROM rental_ski s
JOIN rental r2 on s.rental_id = r2.rental_id
JOIN ski s2 on s2.ski_id = s.ski_id
WHERE rental_status = 'Aktivni'

/* 3;4;2;Vypis vsech lyzi, ktere jsou aktualne pujcene*/
SELECT ski_id, brand, model, length, category, price, description, skier_experience
FROM ski
WHERE ski_id = ANY (
    SELECT ski_id
    FROM rental_ski s
    JOIN rental r2 on s.rental_id = r2.rental_id
    WHERE rental_status = 'Aktivni' AND s.ski_id = ski.ski_id
    )

/* 4;1;4;Vypis nejdelsich lyzi dane znacky a modelu*/
SELECT brand, model, MAX(length)
FROM ski
GROUP BY brand, model


/* 4;2;3;Vypis nejtezsich uzivatelu*/
SELECT user_id, role, first_name, last_name, email, password, address_town, address_street, address_postal_code, height, weight, user_ski_experience
FROM [user]
WHERE weight =
      (SELECT max(weight)
       FROM [user])


/* 4;3;3;Vypis nejnizsi ceny lyzi dane znacky*/
SELECT brand, MIN(price)
FROM ski
GROUP BY brand

/* 4;4;1;Vypis vysky nejvyssiho zakaznika*/
SELECT role, MAX(height)
FROM [user]
GROUP BY role
HAVING role = 'Zakaznik'

/* 5;1;2;Vypis zakazniku, kteri maji vypujcku v priprave*/
SELECT user_id, role, first_name, last_name, email, password, address_town, address_street, address_postal_code, height, weight, user_ski_experience
FROM [user]
JOIN rental r2 on [user].user_id = r2.customer_user_id
WHERE r2.rental_status = 'Pripravovana'

/* 5;2;2;Vypis zakazniku, kteri maji vypujcku v priprave*/
SELECT user_id, role, first_name, last_name, email, password, address_town, address_street, address_postal_code, height, weight, user_ski_experience
FROM [user]
WHERE user_id IN (
        SELECT customer_user_id
        FROM rental
        WHERE rental_status = 'Pripravovana'
    )

/* 5;3;2;Vypis poctu vypujcek podle mesta zakazniku*/
SELECT address_town, count(rental_id) AS pocet_vypujcek
FROM [user]
LEFT JOIN rental r2 on [user].user_id = r2.customer_user_id
GROUP BY  address_town

/* 5;4;2;Vypis zakazniku, kteri jsou vyssi nez 175 cm a k nim pocet jejich vypujcek*/
SELECT user_id, first_name, last_name, COUNT(rental_id) AS pocet_vypujcek
FROM [user]
LEFT JOIN rental r2 on [user].user_id = r2.customer_user_id
WHERE height > 175
GROUP BY user_id, first_name, last_name


/* 6;1;2;Vypis zakazniku, kteri maji vice vypujcek nez je prumerny pocet*/
SELECT u.user_id, u.first_name,u.last_name, COUNT(*) [pocet_vypujcek]
FROM [user] u
JOIN rental r2 on u.user_id = r2.customer_user_id
GROUP BY u.user_id,u.first_name,u.last_name
HAVING COUNT(*) >	ALL(
						SELECT AVG(t.pocet_vypujcek) [prumer]
						FROM
						(
							SELECT COUNT(*) [pocet_vypujcek]
							FROM [user] u2
							JOIN rental r3 on u2.user_id = r3.customer_user_id
							GROUP BY u2.user_id
						)t
					)

/* 6;2;1;Vypis lyzi, ktere si pujcili alespon 2 zakaznici naposledy*/
SELECT ski_id, brand, model
FROM (
    SELECT s.ski_id, s.brand, s.model
    FROM rental r1
    JOIN rental_ski rs on r1.rental_id = rs.rental_id
    JOIN ski s on s.ski_id = rs.ski_id
    WHERE r1.date_from = (
        SELECT MAX(r2.date_from)
        FROM rental r2
        WHERE r1.customer_user_id = r2.customer_user_id
        )
     ) t
GROUP BY ski_id, brand, model
HAVING COUNT(*) >= 2

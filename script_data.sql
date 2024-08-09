INSERT INTO ski (brand, model, length, category, price, description, skier_experience)
VALUES ('K2','Reckoner 122', 184, 'Freeride', 700, 'Freeride skis with huge rocker and 122 width under foot', 'Expert'),
       ('K2','Reckoner 122', 176, 'Freeride', 700, 'Freeride skis with huge rocker and 122 width under foot', 'Expert'),
       ('K2','Reckoner 112', 192, 'Freeride', 700, 'Freeride skis with huge rocker and 112 width under foot', 'Expert'),
       ('K2','Reckoner 112', 176, 'Freeride', 700, 'Freeride skis with huge rocker and 112 width under foot', 'Expert'),
       ('Fischer', 'RC4', 172, 'Slalom', 600, 'Slalom skis', 'Pokrocily'),
       ('Fischer', 'RC4', 165, 'Slalom', 600, 'Slalom skis', 'Pokrocily'),
       ('Atomic', 'Redster JR', 132, 'Childrens', 300, 'Childrens skis', 'Zacatecnik'),
       ('Atomic', 'Redster JR', 140, 'Childrens', 300, 'Childrens skis', 'Zacatecnik')

INSERT INTO [user] (role, first_name, last_name, email, password, address_town, address_street, address_postal_code)
VALUES ('Zamestnanec', 'Jan', 'Novak', 'jan.novak@vsb.cz', 'novak', 'Ostrava', 'Aleje', '725 28'),
       ('Zamestnanec', 'Miroslav', 'Novak', 'miroslav.novak@vsb.cz', 'novak', 'Ostrava', 'Aleje', '725 28')

INSERT INTO [user] (role, first_name, last_name, email, password, address_town, address_street, address_postal_code, weight, height, user_ski_experience)
VALUES ('Zakaznik', 'Jan', 'Novotny', 'jan.novotny@vsb.cz', 'novotny', 'Praha', 'Altajska', '100 00', 70, 180, 'Expert'),
       ('Zakaznik', 'Miroslav', 'Novotny', 'miroslav.novotny@vsb.cz', 'novotny', 'Praha', 'Altajska', '100 00', 80, 175, 'Pokrocily'),
       ('Zakaznik', 'Petr', 'Sikora', 'petr.sikora@vsb.cz', 'sikora', 'Praha', 'Altajska', '100 00', 80, 180, 'Pokrocily'),
       ('Zakaznik', 'Marek', 'Sikora', 'marek.sikora@vsb.cz', 'sikora', 'Praha', 'Altajska', '100 00', 80, 175, 'Expert'),
       ('Zakaznik', 'Petra', 'Sikorova', 'petra.sikorova@vsb.cz', 'sikorova', 'Praha', 'Altajska', '100 00', 55, 165, 'Zacatecnik')

INSERT INTO rental (date_from, date_to, rental_status, date_returned, customer_user_id, employee_user_id)
VALUES (GETDATE(),(GETDATE()+DAY(1)),'Pripravovana',NULL,4,1),
       ('2022-11-29 13:00:27.900','2022-12-30 13:00:27.900','Aktivni',NULL,5,2),
       ('2022-10-29 13:00:27.900','2022-10-30 13:00:27.900','Ukoncena','2022-10-30 10:00:27.900',6,1),
       ('2022-11-29 13:00:27.900','2022-12-25 13:00:27.900','Aktivni',NULL,6,1),
       (GETDATE(),(GETDATE()+DAY(20)),'Pripravovana',NULL,5,2)

INSERT INTO payment (type, payment_date, amount, rental_id)
VALUES ('Card','2022-10-30 10:00:27.900',1200,3)
INSERT INTO payment (type, payment_date, amount, rental_id)
VALUES ('Cash','2022-10-30 10:00:27.900',3000,3)
INSERT INTO payment (type, payment_date, amount, rental_id)
VALUES ('Cash','2022-10-30 10:00:27.900',3000,2)
INSERT INTO payment (type, payment_date, amount, rental_id)
VALUES ('Cash','2022-10-29 16:00:27.900',3000,4)
INSERT INTO payment (type, payment_date, amount, rental_id)
VALUES ('Cash',GETDATE(),3000,5)


INSERT INTO rental_ski (rental_id,ski_id)
VALUES (1,1),(2,2),(2,7),(3,5),(3,2),(4,2),(5,2)

INSERT INTO rental_history (modified_at, old_date_to, new_date_to, rental_rental_id, user_id)
VALUES (GETDATE(),'2022-12-02 14:00:27.900','2022-12-25 13:00:27.900',4,1),
       ('2022-10-29 14:00:27.900','2022-10-29 15:00:27.900','2022-10-30 13:00:27.900',3,2)





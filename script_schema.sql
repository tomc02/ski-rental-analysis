drop table if exists payment;
drop table if exists rental_history;
drop table if exists rental_ski;
drop table if exists ski;
drop table if exists rental;
drop table if exists [user];

CREATE TABLE ski (
    ski_id           INTEGER NOT NULL IDENTITY PRIMARY KEY,
    brand            VARCHAR(50) NOT NULL,
    model            VARCHAR(50) NOT NULL,
    length           INTEGER NOT NULL,
    category         VARCHAR(20) NOT NULL,
    price            DECIMAL NOT NULL,
    description      VARCHAR(200) NOT NULL,
    skier_experience VARCHAR(20) NOT NULL
);

CREATE TABLE "user" (
    user_id             INTEGER NOT NULL IDENTITY PRIMARY KEY,
    role                VARCHAR(20) NOT NULL,
    first_name          VARCHAR(70) NOT NULL,
    last_name           VARCHAR(70) NOT NULL,
    email               VARCHAR(100) NOT NULL,
    password            VARCHAR(50) NOT NULL,
    address_town        VARCHAR(40) NOT NULL,
    address_street      VARCHAR(40) NOT NULL,
    address_postal_code VARCHAR(10) NOT NULL,
    height              INTEGER,
    weight              INTEGER,
    user_ski_experience VARCHAR(20)
);
GO

CREATE TABLE rental (
    rental_id        INTEGER NOT NULL IDENTITY PRIMARY KEY,
    date_from        DATE NOT NULL,
    date_to          DATE NOT NULL,
    rental_status    VARCHAR(20) NOT NULL,
    date_returned    DATE,
    customer_user_id INTEGER NOT NULL,
    employee_user_id INTEGER NOT NULL
);

ALTER TABLE rental
    ADD CONSTRAINT rental_user_fk FOREIGN KEY ( customer_user_id )
        REFERENCES "User" ( user_id );

ALTER TABLE rental
    ADD CONSTRAINT rental_user_fkv2 FOREIGN KEY ( employee_user_id )
        REFERENCES "User" ( user_id );

GO

CREATE TABLE payment (
    payment_id   INTEGER NOT NULL IDENTITY PRIMARY KEY,
    type         VARCHAR(50) NOT NULL,
    payment_date DATE NOT NULL,
    amount       DECIMAL NOT NULL,
    rental_id    INTEGER NOT NULL
);

ALTER TABLE payment
    ADD CONSTRAINT payment_rental_fk FOREIGN KEY ( rental_id )
        REFERENCES rental ( rental_id );




CREATE TABLE rental_ski (
    rental_id INTEGER NOT NULL,
    ski_id    INTEGER NOT NULL,
);
ALTER TABLE rental_ski ADD CONSTRAINT rental_ski_pk PRIMARY KEY ( rental_id, ski_id );

ALTER TABLE rental_ski
    ADD CONSTRAINT rental_ski_rental_fk FOREIGN KEY ( rental_id )
        REFERENCES rental ( rental_id );

ALTER TABLE rental_ski
    ADD CONSTRAINT rental_ski_ski_fk FOREIGN KEY ( ski_id )
        REFERENCES ski ( ski_id );


CREATE TABLE rental_history (
    modified_at      DATE NOT NULL,
    old_date_to      DATE NOT NULL,
    new_date_to      DATE NOT NULL,
    rental_rental_id INTEGER NOT NULL,
    user_id          INTEGER NOT NULL
);

ALTER TABLE rental_history ADD CONSTRAINT rental_history_pk PRIMARY KEY ( modified_at );

ALTER TABLE rental_history
    ADD CONSTRAINT rental_history_rental_fk FOREIGN KEY ( rental_rental_id )
        REFERENCES rental ( rental_id );

ALTER TABLE rental_history
    ADD CONSTRAINT rental_history_user_fk FOREIGN KEY ( user_id )
        REFERENCES "User" ( user_id );

GO
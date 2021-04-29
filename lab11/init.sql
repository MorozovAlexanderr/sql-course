CREATE DATABASE IF NOT EXISTS car_enterprise;

USE car_enterprise;


-- Создание таблиц 

CREATE TABLE vehicles
(
    id INT PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    manufacture_date DATE NOT NULL,
    license_plate VARCHAR(10) UNIQUE NOT NULL,
    engine_number INT CHECK (engine_number > 0),
    color ENUM ('Black', 
                'White', 
                'Grey', 
                'Blue') NOT NULL
);

CREATE TABLE routes
(
    id INT PRIMARY KEY,
    length_km INT NOT NULL CHECK (length > 0),
    stops_number INT DEFAULT 0 NOT NULL
);

CREATE TABLE drivers
(
    id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL
);

CREATE TABLE trips
(
    id INT PRIMARY KEY,
    vehicle_id INT,
    driver_id INT,
    route_id INT,
    proceeds INT DEFAULT 0 NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles (id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES drivers (id) ON DELETE CASCADE,
    FOREIGN KEY (route_id) REFERENCES routs (id) ON DELETE CASCADE
);


-- Наполнение таблиц

INSERT INTO vehicles(model, manufacture_date, license_plate, engine_number, color)
VALUES ('Ford', '2005-12-05', 'ВА1234Л', 3452167, 'White'),
	   ('Mercedes Benz', '2010-03-20', 'ВА3467К', 5452832, 'Black'),
       ('Renault', '2017-10-12', 'ВА5612Н', 4538725, 'Grey'),
       ('Pejo', '2012-01-05', 'ВА9013Н', 9835182, 'Blue')

INSERT INTO routes(length, stops_number)
VALUES (17, 10),
	   (12, 5),
       (7, 3),
       (14, 7)

INSERT INTO drivers(full_name, birth_date)
VALUES ('Ivan Ivanon', '1990-05-20'),
	   ('Petr Petrov', '1985-12-15'),
       ('Ivan Petrov', '1992-07-02'),
       ('Petr Ivanov', '1976-11-17')

INSERT INTO trips(vehicle_id, driver_id, route_id, proceeds)
VALUES (1, 2, 1, 5000),
	   (2, 1, 4, 3500),
       (3, 3, 3, 2700),
       (4, 4, 2, 3000)
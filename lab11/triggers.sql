-- Суммарная длина всех рейсов не джолжна привышать 70 км

DELIMITER $$

CREATE PROCEDURE check_total_trips_length (IN route_id INT)
BEGIN
    SET @total_length = (SELECT SUM(r.length_km)
                           FROM trips AS t
                                JOIN routes AS r
                                ON t.route_id = r.id);
    SET @route_length = (SELECT length_km FROM routes WHERE id = route_id);
    IF (@total_length + @route_length > 70) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Суммарная длина всех рейсов не джолжна привышать 70 км';
    END IF;
END $$

CREATE 
    TRIGGER total_trips_length_bi BEFORE INSERT
    ON trips
    FOR EACH ROW
        CALL check_total_trips_length(NEW.route_id);
    $$
    
CREATE 
    TRIGGER total_trips_length_bu BEFORE UPDATE
    ON trips
    FOR EACH ROW
        CALL check_total_trips_length(NEW.route_id);
    $$


-- Количество рейсов не может быть меньше 5 и больше 10

DELIMITER $$

CREATE 
    TRIGGER trips_number_bi BEFORE INSERT
    ON themes
    FOR EACH ROW
        IF (SELECT COUNT(*) FROM trips) > 10 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Количество рейсов не может быть больше 10';
        END IF;
    $$
    
CREATE 
    TRIGGER trips_number_bd BEFORE DELETE
    ON themes
    FOR EACH ROW
        IF (SELECT COUNT(*) FROM trips) < 5 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Количество рейсов не может быть меньше 5';
        END IF;
    $$

DELIMITER ;


-- Число остановок не может быть больше длины маршрута

DELIMITER $$

CREATE PROCEDURE check_route (IN length INT, IN stops_number INT)
BEGIN
    IF (length < stops_number) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Не праивльное отношение длина/количество остановок';
    END IF;
END $$

CREATE 
    TRIGGER route_bi BEFORE INSERT
    ON routes
    FOR EACH ROW
        CALL check_route(NEW.length_km, NEW.stops_number)
    $$
    
CREATE 
    TRIGGER route_bu BEFORE UPDATE
    ON routes
    FOR EACH ROW
        CALL check_route(NEW.length_km, NEW.stops_number)
    $$

DELIMITER ;
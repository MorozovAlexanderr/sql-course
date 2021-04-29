-- Информация по всем рейсам

DELIMITER $$

CREATE PROCEDURE select_trips()
BEGIN
  SELECT v.model AS transport,
  	     d.full_name AS driver,
         r.length_km AS route_length,
         t.proceeds
    FROM trips AS t
    	   JOIN vehicles AS v
         ON t.vehicle_id = v.id
         JOIN routes AS r
         ON t.route_id = r.id
         JOIN drivers AS d
         ON t.driver_id = d.id
   ORDER BY transport;
END $$

CALL select_trips();


-- Список транспорта по определенному цвету

DELIMITER $$

CREATE PROCEDURE select_transport_by_color(IN t_color VARCHAR(10))
BEGIN 
  SELECT * FROM vehicles
   WHERE color = t_color;
END $$

CALL select_transport_by_color('Black');


-- Длина самого длинного маршрута

DELIMITER $$

CREATE PROCEDURE select_longest_route_length(OUT length INT)
BEGIN 
  SET length = (SELECT MAX(length_km) FROM routes); 
END $$

CALL select_longest_route_length(@length);
SELECT @length AS longest_route_length;


-- Общая длина всех маршрутов для каждого транспорта в рейсах 

DELIMITER $$

CREATE PROCEDURE select_transport_total_routes_length()
BEGIN 
  SELECT v.model AS transport,
         SUM(r.length_km) AS total_routes_length
    FROM trips AS t
         JOIN vehicles AS v
         ON t.vehicle_id = v.id
         JOIN routes AS r
         ON t.route_id = r.id
   GROUP BY transport;
END $$

CALL select_transport_total_routes_length()


-- Инкремент количества остановок на единицу для маршрутов в определенном диапозоне

DELIMITER $$

CREATE PROCEDURE update_stops_number(IN range_1 INT, IN range_2 INT)
BEGIN 
  UPDATE routes 
       SET stops_number = stops_number + 1 
     WHERE length_km BETWEEN range_1 AND range_2;
END $$

CALL update_stops_number(7, 10);


-- Удаления маршрутов у которых количество остановок больше чем длина маршрута

DELIMITER $$

CREATE PROCEDURE cur_for_routes()
BEGIN
      DECLARE done INT DEFAULT 0;
      DECLARE r_id, length, stops_number INT;
      DECLARE cur1 CURSOR FOR SELECT id, length_km, stops_number FROM routes;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      OPEN cur1;
REPEAT
    FETCH cur1 INTO r_id, length, stops_number;
    IF NOT done THEN
       IF length < stops_number THEN
          DELETE FROM routes WHERE id = r_id;
       END IF;
    END IF;
UNTIL done END REPEAT;
    CLOSE cur1;
END $$

CALL cur_for_routes();


-- Сумма всей выручки со всех рейсов

CREATE FUNCTION sum_proceeds ()
RETURNS DOUBLE
RETURN (SELECT SUM(proceeds) FROM trips);

SELECT sum_proceeds() AS sum_proceeds;


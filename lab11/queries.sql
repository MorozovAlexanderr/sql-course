-- Список транспорта с годом производства > 2009

SELECT model,
	     manufacture_date
  FROM vehicles
 WHERE YEAR(manufacture_date) > 2009
 ORDER BY model


-- Средняя длина и количество остановок всех маршрутов

SELECT AVG(length_km) AS average_length,
	     AVG(stops_number) AS average_stops_number
  FROM routes


-- Список водителей возраст которых от 20 до 35

SELECT full_name,
	   birth_date
  FROM drivers
 WHERE YEAR(CURDATE()) - YEAR(birth_date) BETWEEN 20 AND 35


-- Информация по каждому рейсу

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
 ORDER BY transport


-- Сумма доходов с рейсов для каждого транспорта

SELECT v.model,
	     SUM(t.proceeds) AS sum_proceeds
  FROM trips AS t
  	   JOIN vehicles AS v
       ON t.vehicle_id = v.id
 GROUP BY v.model
 ORDER BY sum_proceeds DESC


-- Средняя длина маршрута для каждого водителя

SELECT d.full_name AS driver,
	   AVG(r.length_km) AS average_route_length
  FROM trips AS t
  	   JOIN routes AS r
       ON t.route_id = r.id
       JOIN drivers AS d
       ON t.driver_id = d.id
 GROUP BY driver


-- Список рейсов для которых определен маршрут 

SELECT * FROM trips t 
 WHERE EXISTS (SELECT * FROM routes r WHERE r.id = t.route_id)


 Construye las siguientes consultas:

1- Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.
2- Listar todas las “rental” con los datos del “customer” dado un año y mes.
3- Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
4- Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.






/*1-Insertar, modificar y eliminar Customer*/


INSERT INTO customer
VALUES(
		600,
		2,
		'Daniel',
		'Harrison',
		'daniel.harrison@sakilacustomer.org',
		605,
		true,
		'2023-04-20',
		'2023-05-25 16:50:10.721',
		1
	);
	

UPDATE customer
SET last_update = NOW()
WHERE customer_id = 600;


DELETE FROM customer
WHERE customer_id = 600;


/*1-Insertar, modificar y eliminar Staff*/


INSERT INTO staff
VALUES(
		3,
		'Will',
		'Wright',
		11,
		'Will.Wright@sakilastaff.com',
		2,
		true,
		'Will',
		'will123456789',
		NOW(),
		NULL
	);
	

UPDATE staff
SET last_update = NOW()
WHERE staff_id = 3;



DELETE FROM staff
WHERE staff_id = 3;


/*1-Insertar, modificar y eliminar Actor*/


INSERT INTO actor
VALUES(
		201,
		'Colin',
		'Firth',
		NOW()
	) 1.3.2 Modificar Actor (
		Update de last_update
	)


UPDATE actor
SET last_update = NOW()
WHERE actor_id = 201 


DELETE FROM actor
WHERE actor_id = 201 




/*2-Listar todas las “ rental ” con los datos del “ customer ” dado un año y mes.(mayo de 2005)*/


SELECT customer.first_name AS "Nombre",
	customer.last_name AS "Apellido",
	rental.rental_date AS "Fecha de arriendo",
	customer.store_id AS "Serial de tienda",
	rental.staff_id AS "Serial staff",
	rental.return_date AS "Fecha de retorno",
	film.title AS "Pelicula"
FROM rental
	INNER JOIN customer ON customer.customer_id = rental.customer_id
	INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
	INNER JOIN film ON film.film_id = inventory.film_id
WHERE TO_CHAR(rental_date, 'YYYY-MM') = '2005-05' 3.Listar Número,
	Fecha (payment_date) y Total (amount) de todas las “ payment ”.
SELECT payment_id AS "Numero",
	TO_CHAR(payment_date, 'YYYY-MM-DD') AS "Fecha",
	amount AS "Total"
FROM payment 


/*3-Recuento mensual de payments.*/


SELECT COUNT(payment_id) AS "Numero",
	TO_CHAR(payment_date, 'YYYY-MM') AS "Fecha",
	SUM(amount) AS "Total"
FROM payment
GROUP BY TO_CHAR(payment_date, 'YYYY-MM')
ORDER BY TO_CHAR(payment_date, 'YYYY-MM') ASC 





/*4-Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.*/


SELECT *
FROM film
WHERE release_year = 2006
	AND rental_rate > 4.0
ORDER BY rental_rate DESC


/*5-Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si éstas pueden ser nulas, y su tipo de dato correspondiente.*/


SELECT t1.TABLE_NAME AS tabla_nombre,
	t1.COLUMN_NAME AS columna_nombre,
	t1.IS_NULLABLE AS columna_nulo,
	t1.DATA_TYPE AS columna_tipo_dato
FROM INFORMATION_SCHEMA.COLUMNS t1
	INNER JOIN PG_CLASS t2 ON (t2.RELNAME = t1.TABLE_NAME)
WHERE t1.TABLE_SCHEMA = 'public'
ORDER BY t1.TABLE_NAME;
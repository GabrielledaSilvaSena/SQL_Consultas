-- ENUNCIADO 21
-- ¿Cuál es la media de duración del alquiler de las películas?

SELECT 
    AVG(rental_duration) AS media_duracion_alquiler
FROM 
    film;

-- ENUNCIADO 22
-- Crea una columna con el nombre y apellidos de todos los actores y actrices

SELECT 
    CONCAT(first_name, last_name) AS nombre_completo
FROM 
    actor;


SELECT 
    CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM 
    actor
ORDER BY 
    last_name, first_name;


-- ENUNCIADO 23
-- Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente


SELECT 
    DATE(rental_date) AS fecha,
    COUNT(*) AS num_alquileres
FROM 
    rental
GROUP BY 
    DATE(rental_date)
ORDER BY 
    num_alquileres DESC;

-- ENUNCIADO 24
-- Encuentra las películas con una duración superior al promedio

SELECT 
    film_id,
    title,
    length AS duracion_minutos
FROM 
    film
WHERE 
    length > (
        SELECT AVG(length) 
        FROM film
    )
ORDER BY 
    length DESC;


-- ENUNCIADO 25
-- Averigua el número de alquileres registrados por mes


SELECT 
    YEAR(rental_date) AS año,
    MONTH(rental_date) AS mes,
    COUNT(*) AS num_alquileres
FROM 
    rental
GROUP BY 
    YEAR(rental_date), 
    MONTH(rental_date)
ORDER BY 
    año, mes;

-- ENUNCIADO 26
-- Encuentra el promedio, la desviación estándar y varianza del total pagado


SELECT 
    AVG(amount) AS promedio,
    STDDEV(amount) AS desviacion_estandar,
    VARIANCE(amount) AS varianza
FROM 
    payment;


-- ENUNCIADO 27
-- ¿Qué películas se alquilan por encima del precio medio?

SELECT 
    title,
    rental_rate
FROM 
    film
WHERE 
    rental_rate > AVG(rental_rate);


SELECT 
    title,
    rental_rate AS precio_alquiler
FROM 
    film
WHERE 
    rental_rate > (
        SELECT AVG(rental_rate)
        FROM film
    )
ORDER BY 
    rental_rate DESC;


-- ENUNCIADO 28
-- Muestra el id de los actores que hayan participado en más de 40 películas

SELECT 
    actor_id,
    COUNT(film_id) AS num_peliculas
FROM 
    film_actor
GROUP BY 
    actor_id
HAVING 
    COUNT(film_id) > 40
ORDER BY 
    num_peliculas DESC;


-- ENUNCIADO 29
-- Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible

SELECT 
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS cantidad_disponible
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
ORDER BY 
    f.title;


SELECT 
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS cantidad_disponible
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    f.title;

-- ENUNCIADO 30
-- Obtener los actores y el número de películas en las que ha actuado

SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS num_peliculas
FROM 
    actor a
LEFT JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
    a.actor_id, a.first_name, a.last_name
ORDER BY 
    num_peliculas DESC, a.last_name
    
    
    -- ENUNCIADO 31
-- Obtener todas las películas y mostrar los actores que han actuado en ellas, 
-- incluso si algunas películas no tienen actores asociados
    
SELECT 
    film_id,
    title,
    first_name,
    last_name
FROM 
    film f
LEFT JOIN 
    film_actor fa ON f.film_id = fa.film_id
LEFT JOIN 
    actor a ON fa.actor_id = a.actor_id
ORDER BY 
    title;
    
    
    -- ENUNCIADO 32
-- Obtener todos los actores y mostrar las películas en las que han actuado,
-- incluso si algunos actores no han actuado en ninguna película

SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    f.title
FROM 
    actor a
LEFT JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN 
    film f ON fa.film_id = f.film_id
ORDER BY 
    a.last_name, f.title;


-- ENUNCIADO 33
-- Obtener todas las películas que tenemos y todos los registros de alquiler

SELECT 
    f.film_id,
    f.title,
    r.rental_id,
    r.rental_date
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id
ORDER BY 
    f.title, r.rental_date;

-- ENUNCIADO 34
-- Encuentra los 5 clientes que más dinero se hayan gastado con nosotros

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_gastado
FROM 
    customer c
INNER JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_gastado DESC
LIMIT 5;

-- ENUNCIADO 35
-- Selecciona todos los actores cuyo primer nombre es 'Johnny'

SELECT 
    actor_id,
    first_name,
    last_name
FROM 
    actor
WHERE 
    first_name = 'Johnny'
ORDER BY 
    last_name;


-- ENUNCIADO 36
-- Renombra la columna "first_name" como Nombre y "last_name" como Apellido

SELECT 
    actor_id,
    first_name AS Nombre,
    last_name AS Apellido
FROM 
    actor
ORDER BY 
    Apellido;


-- ENUNCIADO 37
-- Encuentra el ID del actor más bajo y más alto en la tabla actor

SELECT 
    MIN(actor_id) AS id_minimo,
    MAX(actor_id) AS id_maximo
FROM 
    actor;


-- ENUNCIADO 38
-- Cuenta cuántos actores hay en la tabla "actor"

SELECT 
    COUNT(*) AS total_actores
FROM 
    actor;

-- ENUNCIADO 39
-- Selecciona todos los actores y ordénalos por apellido en orden ascendente

SELECT 
    actor_id,
    first_name,
    last_name
FROM 
    actor
ORDER BY 
    last_name ASC;

-- ENUNCIADO 40
-- Selecciona las primeras 5 películas de la tabla "film"

SELECT 
    film_id,
    title,
    release_year,
    length
FROM 
    film
LIMIT 5;
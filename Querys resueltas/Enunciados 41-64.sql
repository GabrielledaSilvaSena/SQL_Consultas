-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
--     mismo nombre. ¿Cuál es el nombre más repetido?

SELECT 
    first_name AS nombre,
    COUNT(*) AS cantidad_actores
FROM 
    actor
GROUP BY 
    first_name
ORDER BY 
    cantidad_actores DESC;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los
--     realizaron.

SELECT 
    r.rental_id,
    r.rental_date,
    c.first_name AS nombre_cliente,
    c.last_name AS apellido_cliente
FROM 
    rental r
INNER JOIN 
    customer c ON r.customer_id = c.customer_id
ORDER BY 
    r.rental_date DESC;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
--     aquellos que no tienen alquileres.
SELECT 
    c.customer_id,
    c.first_name AS nombre_cliente,
    c.last_name AS apellido_cliente,
    r.rental_id,
    r.rental_date
FROM 
    customer c
LEFT JOIN 
    rental r ON c.customer_id = r.customer_id
ORDER BY 
    c.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category.
--     ¿Aporta valor esta consulta? ¿Por qué?

SELECT 
    f.title AS titulo_pelicula,
    c.name AS nombre_categoria
FROM 
    film f
CROSS JOIN 
    category c;


Esta consulta no aporta mucho valor porque hace todas las 
combinaciones posibles entre películas y categorías. Cada película sale 
con todas las categorías aunque no pertenezca a ellas. Sería mejor usar 
INNER JOIN con la tabla film_category para ver las relaciones reales


-- 45. Encuentra los actores que han participado en películas de la categoría
--     'Action'.

SELECT 
    a.first_name AS nombre,
    a.last_name AS apellido
FROM 
    actor a
INNER JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN 
    film_category fc ON fa.film_id = fc.film_id
INNER JOIN 
    category c ON fc.category_id = c.category_id
WHERE 
    c.name = 'Action'
ORDER BY 
    a.last_name;


-- 46. Encuentra todos los actores que no han participado en películas.

SELECT 
    a.actor_id,
    a.first_name AS nombre,
    a.last_name AS apellido
FROM 
    actor a
LEFT JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
WHERE 
    fa.film_id IS NULL
ORDER BY 
    a.last_name;


-- 47. Selecciona el nombre de los actores y la cantidad de películas en las
--     que han participado.

SELECT 
    a.first_name AS nombre,
    a.last_name AS apellido,
    COUNT(fa.film_id) AS numero_peliculas
FROM 
    actor a
LEFT JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
    a.actor_id,
    a.first_name,
    a.last_name
ORDER BY 
    numero_peliculas DESC;

-- 48. Crea una vista llamada "actor_num_peliculas" que muestre los nombres
--     de los actores y el número de películas en las que han participado.

SELECT 
    a.actor_id,
    a.first_name AS nombre,
    a.last_name AS apellido,
    COUNT(fa.film_id) AS numero_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY numero_peliculas DESC;




-- 49. Calcula el número total de alquileres realizados por cada cliente.

SELECT 
    c.customer_id,
    c.first_name AS nombre,
    c.last_name AS apellido,
    COUNT(r.rental_id) AS total_alquileres
FROM 
    customer c
LEFT JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY 
    total_alquileres DESC;


-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT 
    SUM(f.length) AS duracion_total_minutos,
    COUNT(f.film_id) AS numero_peliculas
FROM 
    film f
INNER JOIN 
    film_category fc ON f.film_id = fc.film_id
INNER JOIN 
    category c ON fc.category_id = c.category_id
WHERE 
    c.name = 'Action';

-- 51. Crea una tabla temporal llamada "cliente_rentas_temporal" para
--     almacenar el total de alquileres por cliente.


CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT 
    c.customer_id,
    c.first_name AS nombre,
    c.last_name AS apellido,
    COUNT(r.rental_id) AS total_alquileres
FROM 
    customer c
LEFT JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name;


-- 52. Crea una tabla temporal llamada "peliculas_alquiladas" que almacene
--     las películas que han sido alquiladas al menos 10 veces.


CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT 
    f.film_id,
    f.title AS titulo,
    COUNT(r.rental_id) AS total_alquileres
FROM 
    film f
INNER JOIN 
    inventory i ON f.film_id = i.film_id
INNER JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id,
    f.title
HAVING 
    COUNT(r.rental_id) >= 10;


-- 53. Encuentra el título de las películas que han sido alquiladas por el
--     cliente con el nombre 'Tammy Sanders' y que aún no se han devuelto.
--     Ordena los resultados alfabéticamente por título de película.

SELECT DISTINCT
    f.title AS titulo_pelicula,
    r.rental_date AS fecha_alquiler
FROM 
    film f
INNER JOIN 
    inventory i ON f.film_id = i.film_id
INNER JOIN 
    rental r ON i.inventory_id = r.inventory_id
INNER JOIN 
    customer c ON r.customer_id = c.customer_id
WHERE 
    c.first_name = 'Tammy'
    AND c.last_name = 'Sanders'
    AND r.return_date IS NULL
ORDER BY 
    f.title;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una
--     película que pertenece a la categoría 'Sci-Fi'.
--     Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT
    a.first_name AS nombre,
    a.last_name AS apellido
FROM 
    actor a
INNER JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN 
    film_category fc ON fa.film_id = fc.film_id
INNER JOIN 
    category c ON fc.category_id = c.category_id
WHERE 
    c.name = 'Sci-Fi'
ORDER BY 
    a.last_name,
    a.first_name;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en
--     películas que se alquilaron después de que la película 'Spartacus
--     Cheaper' se alquilara por primera vez.
--     Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT
    a.first_name AS nombre,
    a.last_name AS apellido
FROM 
    actor a
INNER JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN 
    inventory i ON fa.film_id = i.film_id
INNER JOIN 
    rental r ON i.inventory_id = r.inventory_id
WHERE 
    r.rental_date > COALESCE((
        SELECT MIN(r2.rental_date)
        FROM rental r2
        INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
        INNER JOIN film f2 ON i2.film_id = f2.film_id
        WHERE f2.title = 'Spartacus Cheaper'
    ), '1900-01-01')  -- Valor por defecto si la película no existe o no tiene alquileres
ORDER BY 
    a.last_name,
    a.first_name;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en
--     ninguna película de la categoría 'Music'.

SELECT 
    a.first_name AS nombre,
    a.last_name AS apellido
FROM 
    actor a
WHERE 
    a.actor_id NOT IN (
        SELECT DISTINCT fa.actor_id
        FROM film_actor fa
        INNER JOIN film_category fc ON fa.film_id = fc.film_id
        INNER JOIN category c ON fc.category_id = c.category_id
        WHERE c.name = 'Music'
    )
ORDER BY 
    a.last_name;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por
--     más de 8 días.


SELECT DISTINCT
    f.title AS titulo_pelicula,
    MAX(DATEDIFF(r.return_date, r.rental_date)) AS max_dias_alquiler
FROM 
    film f
INNER JOIN 
    inventory i ON f.film_id = i.film_id
INNER JOIN 
    rental r ON i.inventory_id = r.inventory_id
WHERE 
    r.return_date IS NOT NULL  -- Solo películas devueltas
    AND DATEDIFF(r.return_date, r.rental_date) > 8
GROUP BY 
    f.film_id,
    f.title
ORDER BY 
    max_dias_alquiler DESC,
    f.title;


-- 58. Encuentra el título de todas las películas que son de la misma
--     categoría que 'Animation'.
SELECT 
    f.title AS titulo_pelicula
FROM 
    film f
INNER JOIN 
    film_category fc ON f.film_id = fc.film_id
INNER JOIN 
    category c ON fc.category_id = c.category_id
WHERE 
    c.name = 'Animation'
ORDER BY 
    f.title;


-- 59. Encuentra los nombres de las películas que tienen la misma duración
--     que la película con el título 'Dancing Fever'.
--     Ordena los resultados alfabéticamente por título de película.

SELECT 
    f.title AS titulo_pelicula,
    f.length AS duracion_minutos
FROM 
    film f
WHERE 
    f.length = (
        SELECT length
        FROM film
        WHERE title = 'Dancing Fever'
    )
    AND f.title != 'Dancing Fever'
ORDER BY 
    f.title;


--60. Encuentra los nombres de los clientes que han alquilado al menos 7
--     películas distintas.
--     Ordena los resultados alfabéticamente por apellido.
SELECT 
    c.customer_id,
    c.first_name AS nombre,
    c.last_name AS apellido,
    COUNT(DISTINCT i.film_id) AS peliculas_distintas
FROM 
    customer c
INNER JOIN 
    rental r ON c.customer_id = r.customer_id
INNER JOIN 
    inventory i ON r.inventory_id = i.inventory_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
HAVING 
    COUNT(DISTINCT i.film_id) >= 7
ORDER BY 
    c.last_name,
    c.first_name;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y
--     muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT 
    c.name AS categoria,
    COUNT(r.rental_id) AS total_alquileres
FROM 
    category c
INNER JOIN 
    film_category fc ON c.category_id = fc.category_id
INNER JOIN 
    film f ON fc.film_id = f.film_id
INNER JOIN 
    inventory i ON f.film_id = i.film_id
INNER JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name
ORDER BY 
    total_alquileres DESC;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT 
    c.name AS categoria,
    COUNT(f.film_id) AS numero_peliculas
FROM 
    category c
INNER JOIN 
    film_category fc ON c.category_id = fc.category_id
INNER JOIN 
    film f ON fc.film_id = f.film_id
WHERE 
    f.release_year = 2006
GROUP BY 
    c.name
ORDER BY 
    numero_peliculas DESC;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
--     que tenemos.

SELECT 
    s.staff_id,
    s.first_name AS nombre_trabajador,
    s.last_name AS apellido_trabajador,
    st.store_id
FROM 
    staff s
CROSS JOIN 
    store st
ORDER BY 
    s.staff_id;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
--     muestra el ID del cliente, su nombre y apellido junto con la cantidad
--     de películas alquiladas.
SELECT 
    c.customer_id,
    c.first_name AS nombre,
    c.last_name AS apellido,
    COUNT(r.rental_id) AS total_alquileres,
    COUNT(DISTINCT i.film_id) AS peliculas_distintas
FROM 
    customer c
LEFT JOIN 
    rental r ON c.customer_id = r.customer_id
LEFT JOIN 
    inventory i ON r.inventory_id = i.inventory_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY 
    total_alquileres DESC,
    c.last_name;


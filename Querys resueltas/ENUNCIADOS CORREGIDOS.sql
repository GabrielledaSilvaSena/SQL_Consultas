- ==========================================
-- EJERCICIO 6 - CORREGIDO
-- ==========================================
-- Encuentra el nombre y apellido de los actores que tengan 'Allen' en su apellido
-- He utilizado LIKE con comodines % para buscar 'Allen' en cualquier posición del apellido

SELECT 
    first_name AS nombre,
    last_name AS apellido
FROM 
    actor
WHERE 
    last_name LIKE '%Allen%';


-- ==========================================
-- EJERCICIO 22 - CORREGIDO
-- ==========================================
-- Crea una columna con el nombre y apellidos de todos los actores y actrices
-- He añadido un espacio ' ' entre first_name y last_name para que no queden pegados

SELECT 
    CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM 
    actor
ORDER BY 
    nombre_completo;


-- ==========================================
-- EJERCICIO 27 - CORREGIDO
-- ==========================================
-- ¿Qué películas se alquilan por encima del precio medio?
-- He usado una subconsulta para calcular el promedio, ya que AVG() no puede ir directamente en WHERE

SELECT 
    f.title AS titulo,
    f.rental_rate AS precio_alquiler
FROM 
    film f
WHERE 
    f.rental_rate > (
        SELECT AVG(rental_rate)
        FROM film
    )
ORDER BY 
    f.rental_rate DESC;


-- ==========================================
-- EJERCICIO 29 - CORREGIDO
-- ==========================================
-- Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
-- He añadido GROUP BY porque al usar COUNT() es obligatorio agrupar por las columnas no agregadas

SELECT 
    f.film_id,
    f.title AS titulo,
    COUNT(i.inventory_id) AS cantidad_disponible
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    f.title;


-- ==========================================
-- EJERCICIO 57 - CORREGIDO 
-- ==========================================
-- Encuentra el título de todas las películas que fueron alquiladas por más de 8 días
-- He usado la resta directa de fechas, que es la forma nativa de PostgreSQL

SELECT DISTINCT 
    f.title AS titulo
FROM 
    film f
INNER JOIN 
    inventory i ON f.film_id = i.film_id
INNER JOIN 
    rental r ON i.inventory_id = r.inventory_id
WHERE 
    (r.return_date - r.rental_date) > INTERVAL '8 days'
ORDER BY 
    f.title;


-- ==========================================
-- EJERCICIO 63 - CORREGIDO
-- ==========================================
-- Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos

SELECT 
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS nombre_trabajador,
    st.store_id,
    st.manager_staff_id
FROM 
    staff s
CROSS JOIN 
    store st;

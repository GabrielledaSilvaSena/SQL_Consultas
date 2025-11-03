# **Proyecto SQL - Base de Datos de Películas**
## **Sobre este proyecto**
Aquí está mi proyecto de SQL donde he resuelto 64 consultas sobre una base de datos de alquiler de películas. Ha sido un camino largo pero he aprendido bastante durante el proceso.
Básicamente es un ejercicio para practicar SQL desde lo más básico (hacer un SELECT) hasta cosas más complejas como subconsultas, vistas y tablas temporales. La base de datos simula un sistema de alquiler de películas con películas, actores, clientes, alquileres y todas sus relaciones.
### **¿Qué he aprendido?**
Durante este proyecto he trabajado con:

- DBeaver: La herramienta que uso para conectarme a la base de datos
- Consultas básicas: SELECT, WHERE, ORDER BY y filtros
- JOINS: Para conectar tablas (todavía me lío a veces con cuál usar)
- Funciones de agregación: Sumas, promedios, contar registros
- Subconsultas: Queries dentro de queries
- Vistas y tablas temporales: Para cuando las consultas se complican mucho

### **Estructura Repo**
```plaintext
proyecto-sql/
├── README.md                                # Documentación del proyecto
│
├── sql/
│   ├── Enunciados_1-20.sql                  # Consultas básicas (nivel 1)
│   ├── Enunciados_21-40.sql                 # Consultas intermedias (nivel 2)
│   └── Enunciados_41-64.sql                 # Consultas avanzadas (nivel 3)
│   └──Proyecto_diagrama.png
└── docs/
    └── EnunciadoDataProject_SQL.pdf         # Enunciados de las 64 consultas
```
### **La Base de Datos**
Es una base de datos de una tienda de alquiler de películas. Simula un sistema completo de videoclub con todo lo necesario para gestionar el negocio:

#### Las tablas principales son:

- film: El catálogo de películas
- actor: Los actores y actrices
- customer: Los clientes
- rental: Los alquileres que se han hecho
- payment: Los pagos
- category: Categorías de películas (Acción, Comedia, etc.)
- inventory: El inventario de cada tienda
- Y algunas más para relacionar todo

La base de datos incluye relaciones entre tablas mediante claves foráneas, lo que permite hacer consultas complejas con JOINS.

Herramientas utilizadas:

- DBeaver: Para visualizar la base de datos y ejecutar las queries
- SQL: PostgreSQL/MySQL (funciona con ambos)
- Visual Studio Code: Para control de versiones y tener todo en GitHub

### **Las 64 consultas (divididas en 3 archivos):**

#### **Enunciados 1-20: Nivel básico**

Aquí están las consultas fundamentales. Aprendí a:
 - Hacer SELECT y filtrar con WHERE
 - Ordenar resultados
- Usar COUNT, SUM, AVG y otras funciones de agregación
- GROUP BY para agrupar datos
- Mi primer JOIN (momento importante en el aprendizaje)


#### **Enunciados 21-40: Nivel intermedio**
Aquí ya entran los JOINS de verdad y las agregaciones más complejas.

  - LEFT JOIN para incluir datos aunque no haya coincidencias
  - Subconsultas en el WHERE
   - Estadísticas: promedio, desviación estándar, varianza
    - Renombrar columnas y trabajar con fechas

Consultas que me costaron:

La #27: Películas con precio de alquiler por encima del promedio (primera subconsulta seria)
La #29: LEFT JOIN para ver inventario (entender cuándo usar LEFT vs INNER)

#### **Enunciados 41-64: Nivel avanzado**
Las consultas complejas. Aquí tuve que pensar de verdad.

- Subconsultas correlacionadas
- Crear VISTAS (enunciado 48)
- Crear TABLAS TEMPORALES (enunciados 51 y 52)
- CROSS JOIN y analizar su utilidad
- Consultas con 4-5 JOINS anidados

#### **Las más difíciles:**

- La #55: Actores que actuaron en películas alquiladas después de que 'Spartacus Cheaper' se alquilara por primera vez (esto fue un verdadero reto)
- La #56: Actores que NO han actuado en películas de categoría 'Music' (los NOT IN requieren concentración)
- La #57: Películas alquiladas por más de 8 días (trabajar con fechas y DATEDIFF)

### **Buenas prácticas aplicadas**

Comentarios: Cada consulta tiene su número y enunciado como comentario para no perderme
Identación: Intenté que todo se vea ordenado y legible
Nombres claros: Uso alias descriptivos tipo nombre_cliente en vez de solo n
ORDER BY: Casi siempre ordeno los resultados para que se vean mejor
Selección específica: Intento pedir solo las columnas que necesito en lugar de usar SELECT *

## **Aprendizajes clave**

- LEFT JOIN vs INNER JOIN: Al principio usaba INNER JOIN para todo. Ahora entiendo que LEFT JOIN es crucial cuando quieres ver TODOS los registros de una tabla, aunque no tengan coincidencias en la otra.
- Las subconsultas son útiles: Al principio las evitaba, pero luego me di cuenta de que a veces son más claras que hacer múltiples JOINs.
- ORDER BY mejora la legibilidad: Siempre ordenar los resultados hace que todo sea más fácil de revisar y entender.
- Los alias facilitan el código: En vez de customer.first_name cada vez, usar c.first_name hace el código más limpio y legible.
- Comentar es importante: Cuando vuelves a una consulta semanas después, los comentarios son fundamentales para recordar qué hace cada parte.
- COALESCE maneja NULL: Útil para manejar valores NULL sin que la consulta falle.

## **Requisitos cumplidos**

- Consultas con una tabla
- Consultas con múltiples tablas (JOINS)
- Subconsultas
- Vistas (consulta 48)
- Tablas temporales (consultas 51-52)
- Buenas prácticas (comentarios, identación, etc.)
- Todas las 64 consultas resueltas

## **Retos enfrentados**

Entender cuándo usar cada tipo de JOIN: Esto requirió práctica y varios intentos
Subconsultas correlacionadas: Requieren concentración para entender el flujo de datos
Trabajar con fechas: DATEDIFF, DATE() y otras funciones de fecha según el SGBD
La consulta 55: Esta consulta en particular presentó un reto considerable por su complejidad
-- AVANCE 3 Consulta con funciones de agregación

USE FastFoodDB


-- Preguntas para Consultas

-- 1. Total ventas globales: ¿Cuál es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) AS TotalVentas
FROM Ordenes;

-- 2. ¿Cuál es el precio promedio de los productos dentro de cada categoría?

SELECT CategoriaID, CAST(AVG (PRECIO) AS DECIMAL (10,2)) AS PromedioPrecio
FROM Productos
GROUP BY CategoriaID
ORDER BY PromedioPrecio DESC;

-- 3. ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?

SELECT SucursalID, MAX(TotalCompra) MaximaCompra, MIN(TotalCompra) MinimaCompra
FROM Ordenes
GROUP BY SucursalID
ORDER BY MaximaCompra DESC;

-- 4. ¿Cuál es el mayor número de kilómetros recorridos para una entrega?

SELECT MAX(KilometrosRecorrer) MaximoKilometros
FROM Ordenes;

-- 5. ¿Cuál es la cantidad promedio de productos por orden?

SELECT OrdenID, AVG (Cantidad) PromedioCantidad
FROM DetalleOrden
GROUP BY OrdenID;

-- 6. ¿Cuál es el total de ventas por cada tipo de pago?

SELECT TipoPagoId, SUM (TotalCompra) TotalVentas
FROM Ordenes
GROUP BY TipoPagoId
ORDER BY TotalVentas DESC;

-- 7. ¿Cuál sucursal tiene la venta promedio más alta?

SELECT TOP 1 SucursalID, CAST(AVG (TotalCompra) AS DECIMAL (10,2)) PromedioMasAlto
FROM Ordenes
GROUP BY SucursalID
ORDER BY PromedioMasAlto DESC;


-- 8 ¿Cuáles son las sucursales que han generado ventas por orden por encima de $50?

SELECT SucursalID, 
	SUM(TotalCompra) AS TotalVentas
	FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) >50
ORDER BY TotalVentas DESC;

--9 ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?

(SELECT 'Antes del 1 de julio de 2023' Periodo,
	CAST (AVG (TotalCompra) AS DECIMAL (10,2)) TotalVenta
FROM ORDENES
WHERE FechaOrdenTomada < '2023-07-01')
UNION
(SELECT 'Despues del 1 de julio de 2023',
	CAST (AVG (TotalCompra) AS DECIMAL (10,2)) TotalVenta
FROM ORDENES
WHERE FechaOrdenTomada > '2023-07-01')


/* 10. ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor 
cantidad de ventas, cuál es el valor promedio de estas ventas, y cuál ha sido la
venta máxima alcanzada? */

SELECT HorarioVenta,
	COUNT (*) CantidadVentas,
	CAST (AVG (TotalCompra) AS DECIMAL (10,2)) PromedioVentas,
	CAST (MAX (TotalCompra) AS DECIMAL (10,2)) MaximoVentas
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY MaximoVentas DESC
-- AVANCE 3 Consulta con funciones de agregaci�n

USE FastFoodDB


-- Preguntas para Consultas

-- 1. Total ventas globales: �Cu�l es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) AS TotalVentas
FROM Ordenes;

-- 2. �Cu�l es el precio promedio de los productos dentro de cada categor�a?

SELECT CategoriaID, CAST(AVG (PRECIO) AS DECIMAL (10,2)) AS PromedioPrecio
FROM Productos
GROUP BY CategoriaID
ORDER BY PromedioPrecio DESC;

-- 3. �Cu�l es el valor de la orden m�nima y m�xima por cada sucursal?

SELECT SucursalID, MAX(TotalCompra) MaximaCompra, MIN(TotalCompra) MinimaCompra
FROM Ordenes
GROUP BY SucursalID
ORDER BY MaximaCompra DESC;

-- 4. �Cu�l es el mayor n�mero de kil�metros recorridos para una entrega?

SELECT MAX(KilometrosRecorrer) MaximoKilometros
FROM Ordenes;

-- 5. �Cu�l es la cantidad promedio de productos por orden?

SELECT OrdenID, AVG (Cantidad) PromedioCantidad
FROM DetalleOrden
GROUP BY OrdenID;

-- 6. �Cu�l es el total de ventas por cada tipo de pago?

SELECT TipoPagoId, SUM (TotalCompra) TotalVentas
FROM Ordenes
GROUP BY TipoPagoId
ORDER BY TotalVentas DESC;

-- 7. �Cu�l sucursal tiene la venta promedio m�s alta?

SELECT TOP 1 SucursalID, CAST(AVG (TotalCompra) AS DECIMAL (10,2)) PromedioMasAlto
FROM Ordenes
GROUP BY SucursalID
ORDER BY PromedioMasAlto DESC;


-- 8 �Cu�les son las sucursales que han generado ventas por orden por encima de $50?

SELECT SucursalID, 
	SUM(TotalCompra) AS TotalVentas
	FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) >50
ORDER BY TotalVentas DESC;

--9 �C�mo se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?

(SELECT 'Antes del 1 de julio de 2023' Periodo,
	CAST (AVG (TotalCompra) AS DECIMAL (10,2)) TotalVenta
FROM ORDENES
WHERE FechaOrdenTomada < '2023-07-01')
UNION
(SELECT 'Despues del 1 de julio de 2023',
	CAST (AVG (TotalCompra) AS DECIMAL (10,2)) TotalVenta
FROM ORDENES
WHERE FechaOrdenTomada > '2023-07-01')


/* 10. �Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor 
cantidad de ventas, cu�l es el valor promedio de estas ventas, y cu�l ha sido la
venta m�xima alcanzada? */

SELECT HorarioVenta,
	COUNT (*) CantidadVentas,
	CAST (AVG (TotalCompra) AS DECIMAL (10,2)) PromedioVentas,
	CAST (MAX (TotalCompra) AS DECIMAL (10,2)) MaximoVentas
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY MaximoVentas DESC
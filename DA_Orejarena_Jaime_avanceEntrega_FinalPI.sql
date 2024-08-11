-- Informe entrega Final

USE FastFoodDB

/* 1. Eficiencia de los mensajeros: �Cu�l es el tiempo promedio desde el despacho 
hasta la entrega de los pedidos por los mensajeros? */

SELECT		AVG (DATEDIFF (MINUTE, FechaDespacho, FechaOrdenEntrega)) TiempoPromedioDespacho
FROM		Ordenes
WHERE		MensajeroID IS NOT NULL;

/* 2. An�lisis de Ventas por Origen de Orden: �Qu� canal de ventas genera m�s ingresos? */

SELECT		TOP 1 OO.Nombre Canal, SUM (O.TotalCompra) totalVenta
FROM		Ordenes O
INNER JOIN 
			Origen OO ON (O.OrigenID = OO.OrigenID)
GROUP BY	OO.Nombre
ORDER BY	totalVenta DESC;

/* 3. Productividad de los Empleados: �Cu�l es el volumen de ventas promedio gestionado 
por empleado? */

SELECT		E.Nombre Empleado, CAST (SUM (TotalCompra) AS DECIMAL (10,2)) VolumenVentaPromedio
FROM		Ordenes O
LEFT JOIN 
			Empleados E ON (O.EmpleadoID = E.EmpleadoID)
GROUP BY	E.Nombre
ORDER BY	VolumenVentaPromedio DESC;

/* 4. An�lisis de Demanda por Horario y D�a: �C�mo var�a la demanda de productos a lo largo 
del d�a? */

SELECT		O.HorarioVenta Hora, P.Nombre Producto, SUM(DO.Cantidad) Demanda
FROM		Ordenes O
INNER JOIN	
			DetalleOrden DO ON (O.OrdenID = DO.OrdenID)
INNER JOIN		
			Productos P ON (DO.ProductoID = P.ProductoID)
GROUP BY	O.HorarioVenta, P.Nombre
ORDER BY	Hora, Demanda DESC;


/* 5. Comparaci�n de Ventas Mensuales: �C�mo se comparan las ventas mensuales de este a�o 
con el a�o anterior?*/

SELECT		YEAR(FechaOrdenTomada) 'A�O', MONTH(FechaOrdenTomada) MES, SUM(TotalCompra) VENTA
FROM Ordenes
WHERE		YEAR(FechaOrdenTomada) >= 2023 AND YEAR(FechaOrdenTomada) <= 2024
GROUP BY	YEAR(FechaOrdenTomada), MONTH(FechaOrdenTomada)
ORDER BY	VENTA DESC;

/* 6. An�lisis de Fidelidad del Cliente: �Qu� porcentaje de clientes son recurrentes versus 
nuevos clientes cada mes? */

SELECT C.Nombre Client, COUNT(*) NumeroOrdenes
FROM Ordenes O
INNER JOIN 
		Clientes C ON (O.ClienteID = C.ClienteID)
GROUP BY C.Nombre
ORDER BY NumeroOrdenes DESC;


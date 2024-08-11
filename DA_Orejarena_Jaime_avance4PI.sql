-- Avance 4 Consultas con M�ltiples Tablas y JOINs

USE FastFoodDB


/* 1. Listar todos los productos y sus categor�as, �C�mo puedo obtener una lista de 
todos los productos junto con sus categor�as?*/

SELECT	C.Nombre NombreCategoria, P.Nombre NombreProductos
FROM	Productos P
INNER JOIN 
		Categorias C ON (P.CategoriaID = C.CategoriaID);


/* 2. Obtener empleados y su sucursal asignada �C�mo puedo saber a qu� sucursal est� 
asignado cada empleado?*/

SELECT	E.Nombre Empleado, S.Nombre Sucursal
FROM	Empleados E
LEFT JOIN 
		Sucursales S ON (E.SucursalID = S.SucursalID);


/* 3. Identificar productos sin categor�a asignada Pregunta: �Existen productos que no 
tienen una categor�a asignada?*/

SELECT	P.Nombre AS Producto, C.CategoriaID Categoria
FROM	Productos P
LEFT JOIN 
		Categorias C ON (C.CategoriaID = P.CategoriaID)
WHERE C.CategoriaID IS NULL;


/* 4. Detalle completo de �rdenesPregunta: �C�mo puedo obtener un detalle completo de las �rdenes
, incluyendo cliente, empleado que tom� la orden, y el mensajero que la entreg�?*/

SELECT	O.OrdenID, C.Nombre AS Cliente, E.Nombre Empleado, M.Nombre Mensajero
FROM	Ordenes O
LEFT JOIN 
		Clientes C ON (O.ClienteID = C.ClienteID)
LEFT JOIN 
		Empleados E ON (O.EmpleadoID = E.EmpleadoID)
LEFT JOIN 
		Mensajeros M ON (O.MensajeroID = M.MensajeroID); 


/* 5. Productos vendidos por sucursal Pregunta: �Cu�ntos productos de cada tipo se han vendido en 
cada sucursal?*/

SELECT	S.Nombre Sucursal, P.Nombre Producto, SUM(DO.Cantidad) ProductosVendidos
FROM	Ordenes O
INNER JOIN 
		DetalleOrden DO ON (DO.OrdenID = O.OrdenID)
INNER JOIN 
		Productos P ON (P.ProductoID = DO.ProductoID)
INNER JOIN 
		Sucursales S ON (S.SucursalID = O.SucursalID)
GROUP BY S.Nombre, P.Nombre;


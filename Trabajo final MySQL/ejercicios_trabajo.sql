-- 1- Cantidad de clientes y vendedores que tiene el negocio.
select 	(select count(*) from clientes) cantidad_clientes,
		(select count(*) from vendedores) cantidad_vendedores;        

-- 2- Listar los clientes que tienen un email registrado, ordenado por apellido y nombre.
select		*
from		clientes
where		email is not null
order by	apellido, nombre;

-- 3- Listar nombre y apellido, tanto de clientes como de vendedores, cuya dirección de email sea de Gmail.
select c.nombre, c.apellido
from	clientes c
where	email like '%gmail%'
UNION
select  v.nombre, v.apellido
from	vendedores v
where	email like '%gmail%';

-- 4- Listar los clientes cuyo apellido contenga al menos una letra 'e' y que termine con 'z'.
select 	apellido
from	clientes
where apellido like '%e%z';

-- 5- Listar los vendedores cuya última letra del nombre sea una 'a' y tenga 5 letras en total.
select 	nombre
from	vendedores
where	nombre like '____a';

-- 6- Listar los artículos cuyo nombre esté compuesto por más de 2 palabras.
select 	*
from	articulos
where	producto like '%_ _% _%';

-- 7- Listar la cantidad de fac turas que hubo por fecha de facturación.
select 		fecha, count(*) cantidad_facturas
from		facturas
group by 	fecha;
 
-- 8- Informar la suma total de las ventas del negocio por mes, ordenadas de mayor a menor.
select 		month(fecha) mes, sum(monto) suma_total
from		facturas
group by	month(fecha)
order by 	suma_total desc;

-- 9- Informar la cantidad de facturas de cada cliente.
select 		c.nombre, c.id_cliente, count(*) cantidad_facturas
from		clientes c
join		facturas f
on			c.id_cliente = f.id_cliente
GROUP by	c.id_cliente;

-- 10- Informar quiénes compraron el primer día de ventas.
select 	nombre, apellido, f.fecha
from	clientes c
join	facturas f
on		f.id_cliente = c.id_cliente
where	fecha = (select	min(fecha)
				from	facturas);

-- 11- Listar los clientes a los que no se les haya hecho alguna factura.
select 		c.nombre, c.id_cliente
from		clientes c
left join	facturas f
on			c.id_cliente = f.id_cliente
where		f.id_cliente is null;

-- 12- Listar qué clientes (id_cliente, nombre, apellido) compraron remeras.
select 	c.id_cliente, c.nombre, c.apellido, producto
from 	clientes c
join	facturas f
on		f.id_cliente = c.id_cliente
join	ventas v
on		v.numero = f.numero
join	articulos a
on		a.codigo = v.codigo
where	producto like '%remera%';

-- 13- Listar los artículos que aún no fueron vendidos.	 
select a.producto, a.codigo 
from ventas v
right join articulos a
on a.codigo = v.codigo
where cantidad is null;

-- 14- Informar cuántas unidades se vendieron de cada artículo.
select 	producto, sum(cantidad) cantidad_ventas
from	articulos a
join	ventas v
on		v.codigo = a.codigo
group by producto;	

-- 15- Listar el o los artículos que tengan la mayor cantidad de stock, siendo la mayor cantidad un único valor máximo.
select		producto, stock
from		articulos 
where		stock = (select max(stock) from articulos);

-- 16- Agregar los campos precio_costo y precio_venta del tipo double a la tabla artículos.
alter table articulos
add 		precio_costo double unsigned,
add			precio_venta double unsigned;

-- 17- Agregar un campo del tipo decimal, llamado sueldo_empleado, a la tabla vendedores. EL mismo tendrá un valor inicial para todos de 450.010,00
alter table	vendedores add sueldo_empleado decimal default 450010;

-- 18- Actualizar todos los stock_minimo y stock_maximo a 100 y 500 respectivamente.
update articulos set stock_minimo = 100, stock_maximo = 500;

-- 19- Eliminar los productos que no se hayan vendido nunca.
delete  
from 	articulos 
where 	codigo 
in 		(select	codigo 
		from 	(select		a.codigo
				from 		ventas v
				right join 	articulos a
				on 			a.codigo = v.codigo
				where 		v.cantidad is null)sub
);

-- 20 Clientes que compraron más de 5 artículos distintos.
select  c.nombre, c.apellido, count(distinct v.codigo) compras
from	ventas v 
join	facturas f
on		f.numero = v.numero
join	clientes c
on		c.id_cliente = f.id_cliente
group by nombre, apellido
having	compras >= 5


-- Crear la base de datos biblioteca de acuerdo al siguiente esquema:
create database biblioteca;
use biblioteca;
-- -------------    -------------------     -------------     
-- - libros    -    - prestamos       -     - socios    -    
-- -------------    -------------------     -------------     
-- - codigo PK -    - documento   PK FK -     - documento  PK -
-- - titulo    -    - codigo_libro PK FK -     - nombre    -
-- - autor     -    - fecha_prestamo   -       - domicilio -
-- -------------    - fecha_devolucion -     -------------
--                  -------------------        
        
create table libros(
	codigo int auto_increment ,
    titulo varchar(100) not null,
    autor varchar(100) not null,
    primary key(codigo)
    );
    drop table socios;
    create table prestamos(
		documento char(8) not null,
        codigo_libro int not null,
        fecha_prestamo datetime not null,
        fecha_devolucion datetime,
        primary key(documento, codigo_libro)
    );
    create table socios(
		documento char(8) not null,
        nombre varchar(100) not null,
        domicilio varchar(100) not null,
        primary key (documento)
        );
drop table fabricantes;
 show tables;
 
 alter table 			prestamos
 add constraint	FK_prestamos_libros
 foreign key 		(codigo_libro)
 references 			libros(codigo);
 
 alter table 			prestamos
 add constraint 	FK_documento_socios
 foreign key 		(documento)
 references  		socios(documento)
 ;
-- insertar 15 registros en cada tabla
INSERT INTO libros (titulo, autor) VALUES
('Cien años de soledad', 'Gabriel García Márquez'),
('1984', 'George Orwell'),
('Don Quijote de la Mancha', 'Miguel de Cervantes'),
('El Principito', 'Antoine de Saint-Exupéry'),
('Rayuela', 'Julio Cortázar'),
('Crimen y Castigo', 'Fiódor Dostoyevski'),
('El Aleph', 'Jorge Luis Borges'),
('La Metamorfosis', 'Franz Kafka'),
('Orgullo y Prejuicio', 'Jane Austen'),
('El Gran Gatsby', 'F. Scott Fitzgerald'),
('Matar a un ruiseñor', 'Harper Lee'),
('El Señor de los Anillos', 'J.R.R. Tolkien'),
('El viejo y el mar', 'Ernest Hemingway'),
('Ulises', 'James Joyce'),
('Drácula', 'Bram Stoker');

-- PRESTAMOS 
INSERT INTO prestamos (documento, codigo_libro, fecha_prestamo, fecha_devolucion) VALUES
('12345678', 1, '2024-11-01 10:00:00', NULL), -- Pendiente de devolución
('87654321', 2, '2024-10-20 14:30:00', '2024-11-03 12:00:00'),
('56781234', 3, '2024-11-05 11:00:00', NULL), -- Pendiente de devolución
('43218765', 4, '2024-10-25 09:45:00', '2024-11-07 10:30:00'),
('78901234', 5, '2024-11-08 13:20:00', NULL), -- Pendiente de devolución
('34567890', 6, '2024-10-15 15:00:00', '2024-11-01 17:00:00'),
('23456789', 7, '2024-11-02 10:15:00', '2024-11-09 09:30:00'),
('67890123', 8, '2024-10-30 16:40:00', NULL), -- Pendiente de devolución
('89012345', 9, '2024-10-18 14:00:00', '2024-11-05 18:00:00'),
('45678901', 10, '2024-11-06 12:00:00', '2024-11-09 14:30:00'),
('11223344', 11, '2024-11-03 08:20:00', NULL), -- Pendiente de devolución
('22334455', 12, '2024-10-28 10:45:00', '2024-11-08 13:50:00'),
('44556677', 14, '2024-10-22 17:30:00', '2024-11-06 11:15:00'),
('55667788', 15, '2024-11-07 10:20:00', NULL), -- Pendiente de devolución
('99001122', 19, '2024-11-03 13:15:00', NULL); -- Pendiente de devolución


-- SOCIOS

INSERT INTO socios (documento, nombre, domicilio) VALUES
('12345678', 'Juan Pérez', 'Calle Falsa 123'),
('87654321', 'María López', 'Avenida Siempreviva 456'),
('56781234', 'Carlos García', 'Boulevard del Sol 789'),
('43218765', 'Ana Martínez', 'Camino de los Vientos 321'),
('78901234', 'Lucía Gómez', 'Paseo del Río 654'),
('34567890', 'Diego Fernández', 'Calle Arce 987'),
('23456789', 'Sofía Ramírez', 'Avenida Libertador 321'),
('67890123', 'Pedro Sánchez', 'Ruta Nacional 8'),
('89012345', 'Laura Méndez', 'Plaza de los Sueños 111'),
('45678901', 'Tomás Vázquez', 'Camino Real 222'),
('11223344', 'Victoria Ortiz', 'Barrio Los Pinos 333'),
('22334455', 'Martín Silva', 'Callejón del Viento 444'),
('33445566', 'Daniela Acosta', 'Esquina Dorada 555'),
('44556677', 'Esteban Herrera', 'Parque Central 666'),
('55667788', 'Paula Ruiz', 'Sendero del Lago 777');

-- luego responder:
-- 1- qué libros (codigo, titulo, autor) se le prestaron a cada socio?

select 	l.codigo, l.titulo, l.autor
from		libros l
join			prestamos p
on			l.codigo = p.codigo_libro
join			socios s
on			p.documento = s.documento;

-- 2- Listar los socios (documento, nombre, domicilio) a los que se les prestaron libros de Java

select  s.documento, s.nombre, s.domicilio
from 	socios s
join		prestamos p
on 		s.documento = p.documento
join 	libros l
on		p.codigo_libro =  l.codigo
where	titulo = 'Java';

-- 3- Listar de libros (codigo,titulo,autor) que no fueron devueltos 

select 	l.codigo, l.titulo, l.autor
from 		libros l
join			prestamos p
on			p.codigo_libro = l.codigo
join			socios s
on			p.documento = s.documento
where	fecha_devolucion is null;

-- 4- Lista de socios (documento, nombre, domicilio) que tienen libros sin devolver

select 	s.documento, s.nombre, s.domicilio
from 		socios s
join			prestamos p
on			s.documento = p.documento
join			libros l
on			l.codigo = p.codigo_libro
where	p.fecha_devolucion is null	;

-- 5- Lista de socios (documento, nombre, domicilio) que tienen libros sin devolver y cuáles son esos libros

select	 s.documento, s.nombre, s.domicilio, l.titulo
from		socios s
join			prestamos p
on			p.documento = s.documento
join			libros l
on			l.codigo = p.codigo_libro
where	p.fecha_devolucion is null;

-- 6- cantidad de libros sin devolver

select count(*) cantidad_libros_sin_devolver
from	socios s 
join	prestamos p
on		p.documento = s.documento
join	libros l
on 		l.codigo = p.codigo_libro
where	p.fecha_devolucion is null;

-- 7. Lista de libros que fueron prestados el día de hoy.

select 	l.titulo, l.autor
from 	libros l
join	prestamos p
on 		p.codigo_libro = l.codigo
join	socios s
on		s.documento = p.documento
where	fecha_prestamo = curtime();

-- 8- Cantidad de libros que se prestaron este mes

select	count(*) libros_prestados
from 	libros l
join 	prestamos p
on		p.codigo_libro = l.codigo
join	socios s
on		s.documento = p.documento
where	month(fecha_prestamo) = month(curdate());

-- 9- Cantidad de socios que tomaron libros prestados este mes
select 	count(*) cantidad_socios
from	libros l
join 	prestamos p
on		p.codigo_libro = l.codigo
join	socios s
on		s.documento = p.documento
where	month(fecha_prestamo) = month(curdate());
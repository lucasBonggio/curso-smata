
drop database if exists negocio_indumentaria;

create database negocio_indumentaria;

use negocio_indumentaria;

create table clientes(
	id_cliente int auto_increment,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    dni char(8) not null,
    tel_celular varchar(10),
    email varchar(50),
    primary key(id_cliente)
);

create table vendedores(
	legajo int auto_increment,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    dni char(8) not null,
    tel_celular varchar(10),
    email varchar(50),
    primary key(legajo)
);

create table articulos(
	codigo int auto_increment,
    producto varchar(100) not null,
    color varchar(50) not null,
    stock int not null,
    stock_minimo int not null,
    stock_maximo int not null,
    primary key(codigo)
);

create table facturas(
	letra char(1),
    numero int auto_increment,
    fecha date not null,
    monto double not null,
    id_cliente int not null,
    legajo_vendedor int not null,
    primary key(numero, letra)
);

create table ventas(
	letra char(1),
    numero int,
    codigo int,
    cantidad int not null,
    primary key(letra, numero, codigo)
);

alter table 	facturas
add constraint 	FK_facturas_clientes
foreign key		(id_cliente)
references		clientes(id_cliente);

alter table 	facturas
add constraint	FK_facturas_vendedores
foreign key		(legajo_vendedor)
references		vendedores(legajo);

alter table		ventas
add constraint	FK_ventas_facturas
foreign key		(numero, letra)
references		facturas(numero, letra);

alter table 	ventas
add constraint	FK_ventas_articulos
foreign key		(codigo)
references		articulos(codigo);


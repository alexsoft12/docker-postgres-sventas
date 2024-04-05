-- Crear base de datos
create database sventas;

-- Conectar a la base de datos
\c sventas;

-- Crear tablas
create table clientes
(
	id int primary key,
	dni varchar(8) not null unique,
	nombre varchar(45) not null,
	apellido varchar(45),
	telefono varchar(11),
	email varchar(45)
);

create table empleado
(
	id int primary key,
	dni varchar(8), 
	nombre varchar(45) not null, 
	apellido varchar(45), 
	telefono varchar(11),
	direccion varchar(150) not null,
	email varchar(45) not null
);
	
create table marcas
(
	id int primary key,	 
	nombre varchar(45) not null
);

create table producto
(
	id int primary key,	
	nombre varchar(45) not null, 
	precio decimal(20,6) default 0,
	fecha_produccion date,
	fecha_vencimiento date	
);

create table ventas
(
	id int primary key,	
	cliente_id int not null, 
	empleado_id int not null,
	fecha date default current_date,
	hora time default current_time,
	monto_total decimal(20,6) not null,
	descuento_total decimal(20,6)
);

create table detalle_ventas
(
	id int primary key,	
	producto_id int not null, 
	venta_id int not null,
	cantidad decimal(20,6) not null,
    precio_venta decimal(20,6) not null,
);

-- crear relaciones entre tablas
alter table ventas 
	add constraint ventas_clientes_id 
	foreign key (cliente_id) 
	references clientes (id)
	on delete no action
    on update no action;

-- alter table ventas drop CONSTRAINT  ventas_clientes_id; para borrar relaciones.

alter table ventas 
	add constraint ventas_empleado_id 
	foreign key (empleado_id) 
	references empleado (id)
on delete no action
    on update no action;

alter table detalle_ventas 
	add constraint detalle_ventas_producto_id 
	foreign key (producto_id) 
	references producto (id)
	on delete no action
    on update no action;

alter table detalle_ventas 
	add constraint detalle_ventas_venta_id 
	foreign key (venta_id) 
	references ventas (id)
	on delete no action
    on update no action;

alter table marcas add column producto_id int;  -- agregar nuevas columnas si te olvidas :) 

alter table marcas 
	add constraint marcas_producto_id 
	foreign key (producto_id) 
	references producto (id)
	on delete no action
    on update no action;

-- Cambiar tipos y restricciones a columnas
alter table empleado
alter column direccion type varchar(200),
alter column  direccion drop not null,	
alter column email type varchar(45), 
alter column  email drop not null	;

-- establecer not null y unique
alter table empleado
alter column dni set not null;

alter table empleado add constraint empleado_unique_dni unique (dni);



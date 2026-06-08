if exists (select name from sys.databases where name = 'EmpresaSQL')
begin 
	drop database EmpresaSQL
end
go

create database EmpresaSQL
go

use EmpresaSQL
go

create table TDepartamento(
	nDepartamentoID int identity(1,1) constraint pk_nDepartamentoID primary key,
	cNombreDepartamento nvarchar(50) not null constraint uk_cNombreDepartamento unique
);
go

create table TCargo(
	nCargoID int identity(1,1) constraint pk_nCargoID primary key,
	cNombreCargo nvarchar(50) not null constraint uk_cNombreCargo unique
);
go

create table TEmpleado(
	nEmpleadoID int identity(1,1) constraint pk_nEmpleadoID primary key,
	cNif nvarchar(15) not null constraint uk_cNif unique,
	cNombre nvarchar(50),
	cApellido nvarchar(50),
	nDepartamentoID int,
	nCargoID int,
	dFechaContratacion datetime constraint df_dFechaContratacion default getdate(),
	nSalario int constraint ck_nSalario check(nSalario > 300),

	constraint fk_TEmpleado_TDepartamento foreign key (nDepartamentoID) references TDepartamento(nDepartamentoID),
	constraint fk_TEmpleado_TCargo foreign key (nCargoID) references TCargo(nCargoID)
);
go

create table TProyecto(
	nProyectoID int identity(1,1) constraint pk_nProyectoID primary key,
	nombreProyecto nvarchar(60) not null,
	FechaInicio datetime not null,
	FechaFinalizacion datetime
);
go
	
alter table TEmpleado add cEmail nvarchar(60) unique not null
go

alter table TEmpleado add cTelefono nvarchar(8)
go

alter table TEmpleado alter column cNombre nvarchar(100)
go

alter table TEmpleado alter column cApellido nvarchar(100)
go


alter table TEmpleado add cEmail nvarchar(60) unique not null
go

alter table TEmpleado add cTelefono nvarchar(8)
go

alter table TEmpleado alter column cNombre nvarchar(100)
go

alter table TEmpleado alter column cApellido nvarchar(100)
go

alter table TEmpleado add CDireccion nvarchar(70)
go

alter table TEmpleado add nEdad int null
go

alter table TEmpleado add constraint ck_TEmpleado_nEdad check (nEdad between 18 and 65)
go

alter table TEmpleado add cCorreo nvarchar(100) null
go
alter table TEmpleado add constraint uk_TEmpleado_cCorreo unique (cCorreo)
go

alter table TEmpleado add bActivo bit constraint df_TEmpleado_bActivo default 1
go

alter table TEmpleado add cDireccion nvarchar(max) null
go
alter table TEmpleado drop column cDireccion
go

alter table TEmpleado add telefono int null
go
alter table TEmpleado alter column telefono varchar(20) null
go

alter table TEmpleado add cGenero char(1) null
go

alter table TEmpleado add constraint ck_TEmpleado_cGenero check (cGenero in ('M', 'F'))
go

alter table TEmpleado add dFechaNacimiento date null
go

create table TSucursal(
	nSucursalID int identity(1,1) constraint pk_TSucursalID primary key,
	cNombreSucursal nvarchar(100) not null constraint uk_cNombreSucursal unique,
	cCiudad nvarchar(50) not null,
	bActivo bit constraint df_TSucursal_bActivo default 1
);
go


insert into TDepartamento (cNombreDepartamento) values 
('Recursos Humanos'),
('Tecnología'),
('Finanzas'),
('Operaciones'),
('Mercadeo');
go

insert into TCargo (cNombreCargo) values 
('Gerente'),
('Analista'),
('Desarrollador'),
('Coordinador'),
('Asistente');
go

insert into TEmpleado (cNif, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cCorreo, cGenero, dFechaNacimiento) values 
('1111', 'Carlos', 'Mendoza', 2, 3, 1200, 35, 'carlos.mendoza@empresa.com', 'M', '1991-04-12'),
('2222', 'Ana', 'Silva', 1, 1, 2500, 33, 'ana.silva@empresa.com', 'F', '1993-08-25'),
('3333', 'Jorge', 'Reyes', 3, 2, 950, 37, 'jorge.reyes@empresa.com', 'M', '1988-11-05'),
('4444', 'Elena', 'Gómez', 2, 3, 1100, 30, 'elena.gomez@empresa.com', 'F', '1995-02-14'),
('5555', 'Luis', 'Torres', 4, 4, 800, 40, 'luis.torres@empresa.com', 'M', '1985-06-30'),
('6666', 'Sofía', 'Castro', 5, 2, 900, 32, 'sofia.castro@empresa.com', 'F', '1993-10-18'),
('7777', 'Pedro', 'Martínez', 3, 1, 2300, 45, 'pedro.martinez@empresa.com', 'M', '1980-03-22'),
('8888', 'Lucía', 'Morales', 2, 5, 500, 31, 'lucia.morales@empresa.com', 'F', '1994-12-01'),
('9999', 'Diego', 'Ortiz', 4, 2, 850, 38, 'diego.ortiz@empresa.com', 'M', '1987-07-09'),
('0000', 'María', 'Espinoza', 1, 5, 450, 34, 'maria.espinoza@empresa.com', 'F', '1991-09-15');
go

insert into TProyecto (nombreProyecto, FechaInicio, FechaFinalizacion) values 
('Migración en la Nube', '2026-01-15', '2026-06-30'),
('Reestructuración Salarial', '2026-03-01', null),
('Campaña Expansión 2026', '2026-05-01', '2026-12-31');
go

create table TEmpleadoProyecto(
	nEmpleadoID int,
	nProyectoID int,
	constraint pk_TEmpleadoProyecto primary key (nEmpleadoID, nProyectoID),
	constraint fk_TEmpleadoProyecto_Empleado foreign key (nEmpleadoID) references TEmpleado(nEmpleadoID),
	constraint fk_TEmpleadoProyecto_Proyecto foreign key (nProyectoID) references TProyecto(nProyectoID)
);
go

insert into TEmpleadoProyecto (nEmpleadoID, nProyectoID) values 
(1, 1),
(4, 1),
(2, 2),
(6, 3);
go

insert into TEmpleado (cNif, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cCorreo, cGenero, dFechaNacimiento) values 
('1234', 'Roberto', 'Briones', 2, 3, 1300, 29, 'roberto.briones@empresa.com', 'M', '1997-01-20');
go

insert into TEmpleado (cNif, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cCorreo, cGenero, dFechaNacimiento) values 
('5678', 'Laura', 'Chávez', 5, 4, 850, 27, 'laura.chavez@empresa.com', 'F', '1998-11-12');
go

insert into TEmpleado (cNif, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cCorreo, cGenero, dFechaNacimiento) values 
('9012', 'Ricardo', 'Gutiérrez', 4, 2, 900, 42, 'ricardo.gutierrez@empresa.com', 'M', '1984-05-05');
go

insert into TDepartamento (cNombreDepartamento) values 
('Logística'),
('Auditoría Interna'),
('Seguridad');
go

insert into TEmpleado (cNif, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cCorreo, cGenero, dFechaNacimiento) values 
('0001', 'Frustrado', 'Error', 2, 3, -500, 25, 'error.salario@empresa.com', 'M', '2001-01-01');
go

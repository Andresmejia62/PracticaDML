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



create database SailingMaster
go

use SailingMaster
go

create table Usuario(
	ID int primary key identity,
	username varchar(20) not null,
	password varchar(max) not null,
	descrip varchar(50) not null,
	email varchar(max),
	activo bit not null default 1,
	tip_usuario tinyint not null,
	fec_camb datetime not null default getdate(),
	co_us_in varchar(20) not null,
	fe_us_in datetime not null,
	co_us_mo varchar(20) not null,
	fe_us_mo datetime not null
)

/*
items con default

- activo
- fec_camb
*/
DROP DATABASE IF EXISTS sgo_trasisa;

CREATE DATABASE sgo_trasisa;

USE sgo_trasisa;

CREATE TABLE UnidadMedida(
	idUnidadMedida			TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreUnidadMedida		VARCHAR(10)			NOT NULL,
	AbreviacionUnidadMedida	VARCHAR(5)			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Producto(
	idProducto				INTEGER				NOT NULL				PRIMARY KEY				AUTO_INCREMENT,
	CodigoProducto			VARCHAR(25)			NOT NULL,
	NombreProducto			VARCHAR(25)			NOT NULL,
	idUnidadMedida			TINYINT				NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL,
	INDEX (idUnidadMedida),
    FOREIGN KEY (idUnidadMedida)
            REFERENCES UnidadMedida(idUnidadMedida)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Puesto(
	idPuesto				TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombrePuesto			VARCHAR(50)			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Rol(
	idRol					TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreRol				VARCHAR(25)			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Usuario(
	idUsuario				TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreUsuario			VARCHAR(35)			NOT NULL,
	ApellidoUsuario			VARCHAR(35)			NOT NULL,
	idPuesto				TINYINT 			NOT NULL,
	CorreoUsuario			VARCHAR(100)		NOT NULL,
	ContraseniaUsuario		VARCHAR(20)			NOT NULL,
	idClienteUsuario		TEXT				NOT NULL,
	LlaveSecretaUsuario		TEXT				NOT NULL,
	idRol					TINYINT 			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL,
	INDEX (idPuesto),
    FOREIGN KEY (idPuesto)
            REFERENCES Puesto(idPuesto)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    INDEX (idRol),
    FOREIGN KEY (idRol)
            REFERENCES Rol(idRol)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;
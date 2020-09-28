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

CREATE TABLE Estado(
	idEstado				TINYINT				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreEstado			VARCHAR(10)			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Producto(
	idProducto				INTEGER				NOT NULL				PRIMARY KEY				AUTO_INCREMENT,
	CodigoProducto			VARCHAR(25)			NOT NULL,
	NombreProducto			VARCHAR(25)			NOT NULL,
	idUnidadMedida			TINYINT				NOT NULL,
	EstadoProducto			BOOLEAN				NOT NULL,
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
	EstadoPuesto			BOOLEAN				NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Rol(
	idRol					TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreRol				VARCHAR(25)			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE users(
	idUsuario				TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreUsuario			VARCHAR(35)			NOT NULL,
	ApellidoUsuario			VARCHAR(35)			NOT NULL,
	idPuesto				TINYINT 			NOT NULL,
	email					VARCHAR(100)		NOT NULL,
	email_verified_at		TIMESTAMP			NULL,
	password 				VARCHAR(191)		NOT NULL,
	remember_token			VARCHAR(100)		NULL,
	idRol					TINYINT 			NOT NULL,
	EstadoUsuario			BOOLEAN				NOT NULL,
	current_team_id			BIGINT(20)			NULL,
	profile_photo_path		TEXT				NULL,
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

CREATE TABLE Area(
	idArea					TINYINT				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreArea				VARCHAR(25)			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE NombreActividad(
	idNombreActividad		TINYINT				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	NombreActividad			VARCHAR(25)			NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoActividad(
	idListadoActividad		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	idArea					TINYINT				NOT NULL,
	idNombreActividad		TINYINT				NOT NULL,
	FechaCreacionActividad	DATE				NOT NULL,
	FechaConclusionActividad	DATE			NOT NULL,
	EstadoActividad			BOOLEAN				NOT NULL,
	idUsuario				TINYINT				NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL,
	INDEX (idUsuario),
    FOREIGN KEY (idUsuario)
            REFERENCES users(idUsuario)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoMaterial(
	idListadoMaterial		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	idListadoActividad		INTEGER				NOT NULL,
	idProducto				INTEGER				NOT NULL,
	CantidadProducto		FLOAT				NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL,
	INDEX (idListadoActividad),
    FOREIGN KEY (idListadoActividad)
            REFERENCES ListadoActividad(idListadoActividad)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
	INDEX (idProducto),
    FOREIGN KEY (idProducto)
            REFERENCES Producto(idProducto)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Inventario(
	idInventario			INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	idProducto				INTEGER				NOT NULL,
	CantidadExistencia		DECIMAL				NOT NULL,
	CantidadMinima			DECIMAL				NOT NULL,
	CantidadMaxima			DECIMAL				NOT NULL,
	INDEX (idProducto),
    FOREIGN KEY (idProducto)
            REFERENCES Producto(idProducto)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

INSERT INTO Estado ('idEstado', 'NombreEstado', 'created_at', 'updated_at')
			VALUES (NULL, 'Activo', NULL, NULL);
		
INSERT INTO Estado ('idEstado', 'NombreEstado', 'created_at', 'updated_at')
			VALUES (NULL, 'Inactivo', NULL, NULL);
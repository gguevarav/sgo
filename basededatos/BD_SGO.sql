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

CREATE TABLE Inventario(
    idInventario			INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    idProducto				INTEGER				NOT NULL,
    CantidadExistencia		DECIMAL				NOT NULL,
    RegistradoPor           TINYINT             NOT NULL,
    created_at				TIMESTAMP			NULL,
    updated_at				TIMESTAMP			NULL,
    INDEX (idProducto),
    FOREIGN KEY (idProducto)
       REFERENCES Producto(idProducto)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,
    INDEX (RegistradoPor),
    FOREIGN KEY (RegistradoPor)
       REFERENCES users(idUsuario)
       ON DELETE CASCADE
       ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE MinimosMaximos(
   idMinimosMaximos        INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
   idProducto              INTEGER				NOT NULL,
   CantidadMinima			DECIMAL				NOT NULL,
   CantidadMaxima			DECIMAL				NOT NULL,
   created_at				TIMESTAMP			NULL,
   updated_at				TIMESTAMP			NULL,
   INDEX (idProducto),
   FOREIGN KEY (idProducto)
       REFERENCES Producto(idProducto)
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

CREATE TABLE Caldera(
    idCaldera               TINYINT				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NombreCaldera           VARCHAR(20)         NOT NULL,
    created_at				TIMESTAMP			NULL,
    updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE AreaCaldera(
    idAreaCaldera           TINYINT				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NombreAreaCaldera       VARCHAR(15)         NOT NULL,
    created_at				TIMESTAMP			NULL,
    updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE AreaPretratamiento(
    idAreaPretratamiento    TINYINT				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NombreAreaPretratamiento    VARCHAR(10)         NOT NULL,
    created_at				TIMESTAMP			NULL,
    updated_at				TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoActividadCaldera(
    idListadoActividadCaldera		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
	idArea					TINYINT				NOT NULL,
	idCaldera               TINYINT             NOT NULL,
	idAreaCaldera           TINYINT             NOT NULL,
	idNombreActividad		TINYINT				NOT NULL,
	FechaCreacionActividad	DATETIME				NOT NULL,
	FechaConclusionActividad	DATETIME			NOT NULL,
	EstadoActividad			TINYINT				NOT NULL,
	CreadoPor			    TINYINT				NOT NULL,
	RealizadoPor            TINYINT             NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL,
    INDEX (idArea),
    FOREIGN KEY (idArea)
        REFERENCES Area(idArea)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (idCaldera),
    FOREIGN KEY (idCaldera)
        REFERENCES Caldera(idCaldera)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (idAreaCaldera),
    FOREIGN KEY (idAreaCaldera)
        REFERENCES AreaCaldera(idAreaCaldera)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (idNombreActividad),
    FOREIGN KEY (idNombreActividad)
        REFERENCES NombreActividad(idNombreActividad)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (EstadoActividad),
    FOREIGN KEY (EstadoActividad)
        REFERENCES Estado(idEstado)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
	INDEX (CreadoPor),
    FOREIGN KEY (CreadoPor)
            REFERENCES users(idUsuario)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    INDEX (RealizadoPor),
    FOREIGN KEY (RealizadoPor)
        REFERENCES users(idUsuario)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoMaterialActividadCaldera(
	idListadoMaterialActividadCaldera		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    idListadoActividadCaldera		INTEGER				NOT NULL,
	idProducto				INTEGER				NOT NULL,
	CantidadProducto		FLOAT				NOT NULL,
	created_at				TIMESTAMP			NULL,
	updated_at				TIMESTAMP			NULL,
	INDEX (idListadoActividadCaldera),
    FOREIGN KEY (idListadoActividadCaldera)
            REFERENCES ListadoActividadCaldera(idListadoActividadCaldera)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
	INDEX (idProducto),
    FOREIGN KEY (idProducto)
            REFERENCES Producto(idProducto)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoActividadPretratamiento(
    idListadoActividadPretratamiento		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    idArea					TINYINT				NOT NULL,
    idAreaPretratamiento           TINYINT             NOT NULL,
    idNombreActividad		TINYINT				NOT NULL,
    FechaCreacionActividad	DATETIME				NOT NULL,
    FechaConclusionActividad	DATETIME			NOT NULL,
    EstadoActividad			TINYINT				NOT NULL,
    CreadoPor			    TINYINT				NULL,
    RealizadoPor            TINYINT             NULL,
    created_at				TIMESTAMP			NULL,
    updated_at				TIMESTAMP			NULL,
    INDEX (idArea),
    FOREIGN KEY (idArea)
        REFERENCES Area(idArea)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (idAreaPretratamiento),
    FOREIGN KEY (idAreaPretratamiento)
        REFERENCES AreaPretratamiento(idAreaPretratamiento)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (idNombreActividad),
    FOREIGN KEY (idNombreActividad)
        REFERENCES NombreActividad(idNombreActividad)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (EstadoActividad),
    FOREIGN KEY (EstadoActividad)
        REFERENCES Estado(idEstado)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (CreadoPor),
    FOREIGN KEY (CreadoPor)
        REFERENCES users(idUsuario)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (RealizadoPor),
    FOREIGN KEY (RealizadoPor)
        REFERENCES users(idUsuario)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoMaterialActividadPretratamiento(
    idListadoMaterialActividadPretratamiento		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    idListadoActividadPretratamiento		INTEGER				NOT NULL,
    idProducto				INTEGER				NOT NULL,
    CantidadProducto		FLOAT				NOT NULL,
    created_at				TIMESTAMP			NULL,
    updated_at				TIMESTAMP			NULL,
    INDEX (idListadoActividadPretratamiento),
    FOREIGN KEY (idListadoActividadPretratamiento)
        REFERENCES ListadoActividadPretratamiento(idListadoActividadPretratamiento)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    INDEX (idProducto),
    FOREIGN KEY (idProducto)
        REFERENCES Producto(idProducto)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoActividadTorreEnfriamiento(
   idListadoActividadTorreEnfriamiento		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
   idArea					TINYINT				NOT NULL,
   idNombreActividad		TINYINT				NOT NULL,
   FechaCreacionActividad	DATETIME				NOT NULL,
   FechaConclusionActividad	DATETIME			NOT NULL,
   EstadoActividad			TINYINT				NOT NULL,
   CreadoPor			    TINYINT				NOT NULL,
   RealizadoPor             TINYINT             NULL,
   created_at				TIMESTAMP			NULL,
   updated_at				TIMESTAMP			NULL,
   INDEX (idArea),
   FOREIGN KEY (idArea)
       REFERENCES Area(idArea)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,
   INDEX (idNombreActividad),
   FOREIGN KEY (idNombreActividad)
       REFERENCES NombreActividad(idNombreActividad)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,
   INDEX (EstadoActividad),
   FOREIGN KEY (EstadoActividad)
       REFERENCES Estado(idEstado)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,
   INDEX (CreadoPor),
   FOREIGN KEY (CreadoPor)
       REFERENCES users(idUsuario)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,
   INDEX (RealizadoPor),
   FOREIGN KEY (RealizadoPor)
       REFERENCES users(idUsuario)
       ON DELETE CASCADE
       ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE ListadoMaterialActividadTorreEnfriamiento(
   idListadoMaterialActividadTorreEnfriamiento		INTEGER				NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
   idListadoActividadTorreEnfriamiento		INTEGER				NOT NULL,
   idProducto				INTEGER				NOT NULL,
   CantidadProducto		FLOAT				NOT NULL,
   created_at				TIMESTAMP			NULL,
   updated_at				TIMESTAMP			NULL,
   INDEX (idListadoActividadTorreEnfriamiento),
   FOREIGN KEY (idListadoActividadTorreEnfriamiento)
       REFERENCES ListadoActividadTorreEnfriamiento(idListadoActividadTorreEnfriamiento)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,
   INDEX (idProducto),
   FOREIGN KEY (idProducto)
       REFERENCES Producto(idProducto)
       ON DELETE CASCADE
       ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

-- Estados
INSERT INTO Estado (idEstado, NombreEstado, created_at, updated_at)
			VALUES (NULL, 'Activo', NULL, NULL),
			       (NULL, 'Inactivo', NULL, NULL),
                   (NULL, 'En proceso', NULL, NULL),
                   (NULL, 'Cerrado', NULL, NULL);

-- Puesto
INSERT INTO Puesto (idPuesto, NombrePuesto, EstadoPuesto,
                      created_at, updated_at)
            VALUES (NULL, 'Administrador', 1, NULL, NULL);

-- Rol
INSERT INTO Rol (idRol, NombreRol, created_at, updated_at)
         VALUES (NULL, 'Administrador', NULL, NULL);

-- Usuario
INSERT INTO users (idUsuario, NombreUsuario, ApellidoUsuario,
                   idPuesto, email, email_verified_at, password,
                   remember_token, idRol, EstadoUsuario, current_team_id,
                   profile_photo_path, created_at, updated_at)
           VALUES (NULL, 'administrador', 'administrador', 1, 'admin@admin.com',
                   NULL, 'admin12345', NULL, 1, 1, NULL, NULL, NULL, NULL);

-- UnidadesMedida
INSERT INTO UnidadMedida (idUnidadMedida, NombreUnidadMedida,
                          AbreviacionUnidadMedida, created_at, updated_at)
                  VALUES (NULL, 'Libra', 'Lb', NULL, NULL),
                         (NULL, 'Kilogramo', 'Kg', NULL, NULL),
                         (NULL, 'Litro', 'Lt', NULL, NULL);

-- Productos
INSERT INTO Producto (idProducto, CodigoProducto, NombreProducto,
                      idUnidadMedida, EstadoProducto, created_at, updated_at)
              VALUES (NULL, '01001', 'Producto 1', 1, 1, NULL, NULL),
                     (NULL, '01002', 'Producto 2', 2, 1, NULL, NULL),
                     (NULL, '01003', 'Producto 3', 3, 1, NULL, NULL);

-- NombreActividades
INSERT INTO NombreActividad (NombreActividad, created_at, updated_at)
                      VALUES('Preparación de bach', null, null),
                            ('Dosificación normal', null, null),
                            ('Dosificación extra', null, null),
                            ('Regeneración', null, null),
                            ('Mantenimiento', null, null);

-- Areas
INSERT INTO Area (idArea, NombreArea, created_at, updated_at)
          VALUES (NULL, 'Caldera', NULL, NULL),
                 (NULL, 'Pretratamiento', NULL, NULL) ,
                 (NULL, 'Torre de Enfriamiento', NULL, NULL);

-- Calderas
INSERT INTO Caldera (idCaldera, NombreCaldera, created_at, updated_at)
             VALUES (NULL, 'Caldera 1', NULL, NULL),
                    (NULL, 'Caldera 2', NULL, NULL),
                    (NULL, 'Caldera 3', NULL, NULL);

-- Area Caldera
INSERT INTO AreaCaldera (idAreaCaldera, NombreAreaCaldera, created_at, updated_at)
VALUES (NULL, 'Alimentación', NULL, NULL),
       (NULL, 'Domo', NULL, NULL),
       (NULL, 'Vapores', NULL, NULL);


-- AreaPretratamiento
INSERT INTO AreaPretratamiento(idAreaPretratamiento, NombreAreaPretratamiento, created_at, updated_at)
                       VALUES (NULL, 'Cation', NULL, NULL),
                              (NULL, 'Tanque DM', NULL, NULL),
                              (NULL, 'Suavizador', NULL, NULL);

-- Inserts para poder ver la informmación
INSERT INTO ListadoActividadCaldera(idArea, idCaldera, idAreaCaldera, idNombreActividad,
                                    FechaCreacionActividad, FechaConclusionActividad,
                                    EstadoActividad, CreadoPor, RealizadoPor, created_at, updated_at)
                            VALUES (1, 1, 1, 1, '2020-10-10', '2020-10-10', 1, 1, 1, null, null),
                                   (1, 2, 3, 3, '2020-10-10', '2020-10-10', 1, 1, 1, null, null),
                                   (1, 3, 2, 5, '2020-10-10', '2020-10-10', 1, 1, 1, null, null);

-- Inserción de listado de actividades de Pretratamiento
INSERT INTO ListadoActividadPretratamiento(idArea, idAreaPretratamiento, idNombreActividad,
                                           FechaCreacionActividad, FechaConclusionActividad,
                                           EstadoActividad, CreadoPor, RealizadoPor, created_at, updated_at)
                                   VALUES (2, 2, 4,'2020-10-10', '2020-10-10', 1, 1, 1, null, null),
                                          (2, 2, 4,'2020-10-10', '2020-10-10', 1, 1, 1, null, null),
                                          (2, 3, 1,'2020-10-10', '2020-10-10', 1, 1, 1, null, null);

-- Inserción de listado de actividades de Torre de enfriamiento
INSERT INTO ListadoActividadTorreEnfriamiento(idArea, idNombreActividad, FechaCreacionActividad,
                                              FechaConclusionActividad, EstadoActividad, CreadoPor,
                                              RealizadoPor, created_at, updated_at)
                                   VALUES (3, 3, '2020-10-10', '2020-10-10', 1, 1, 1, null, null),
                                          (3, 5, '2020-10-10', '2020-10-10', 1, 1, 1, null, null),
                                          (3, 1, '2020-10-10', '2020-10-10', 1, 1, 1, null, null);

-- Inserción de listado de materiales actividades caldera
INSERT INTO ListadoMaterialActividadCaldera (idListadoActividadCaldera, idProducto,
                                             CantidadProducto, created_at, updated_at)
                                     VALUES (1, 2, 12.5, null, null),
                                            (3, 1, 20, null, null),
                                            (2, 3, 4, null, null),
                                            (3, 1, 16, null, null),
                                            (1, 3, 9, null, null),
                                            (2, 2, 2, null, null),
                                            (1, 3, 10, null, null);
-- Inseción de listado de materiales de actividades de Pretratamiento
INSERT INTO ListadoMaterialActividadPretratamiento (idListadoActividadPretratamiento, idProducto,
                                                    CantidadProducto, created_at, updated_at)
                                            VALUES (3, 1, 16, null, null),
                                                   (1, 3, 3, null, null),
                                                   (2, 1, 5, null, null),
                                                   (1, 3, 3, null, null),
                                                   (3, 1, 13, null, null),
                                                   (2, 3, 28, null, null);

-- Inseción de listado de materiales de actividades de torre de enfriamiento
INSERT INTO ListadoMaterialActividadTorreEnfriamiento (idListadoActividadTorreEnfriamiento, idProducto,
                                                    CantidadProducto, created_at, updated_at)
                                                VALUES (3, 3, 4, null, null),
                                                       (1, 2, 2, null, null),
                                                       (2, 1, 7, null, null),
                                                       (1, 2, 8, null, null),
                                                       (3, 1, 12, null, null),
                                                       (2, 3, 45, null, null);

-- Ver listadoActividadesCaldera
SELECT LAC.idListadoActividadCaldera,
       A.NombreArea,
       C.NombreCaldera,
       AC.NombreAreaCaldera,
       NA.NombreActividad,
       CONCAT(US.NombreUsuario, ' ', US.ApellidoUsuario) AS RealizadoPor,
       CONCAT(US.NombreUsuario, ' ', US.ApellidoUsuario) AS CreadoPor,
       E.NombreEstado,
       LAC.FechaCreacionActividad,
       LAC.FechaConclusionActividad
FROM ListadoActividadCaldera As LAC
         INNER JOIN Area A
                    ON LAC.idArea = A.idArea
         INNER JOIN Caldera C
                    ON LAC.idCaldera = C.idCaldera
         INNER JOIN AreaCaldera AC
                    ON LAC.idAreaCaldera = AC.idAreaCaldera
         INNER JOIN NombreActividad NA
                    ON LAC.idNombreActividad = NA.idNombreActividad
         INNER JOIN users US
                    ON LAC.CreadoPor = US.idUsuario
         INNER JOIN users US2
                    ON LAC.RealizadoPor = US2.idUsuario
         INNER JOIN Estado E
                    ON LAC.EstadoActividad = E.idEstado;

-- Ver listado de materiales actividades caldera
SELECT LMAC.idListadoMaterialActividadCaldera,
       P.CodigoProducto,
       P.NombreProducto,
       LMAC.CantidadProducto
FROM ListadoMaterialActividadCaldera As LMAC
         INNER JOIN Producto P
                    ON LMAC.idProducto = P.idProducto
         WHERE idListadoActividadCaldera = 2;

-- Ver listadoActividadesPretratamiento
SELECT LAP.idListadoActividadPretratamiento,
       A.NombreArea,
       AP.NombreAreaPretratamiento,
       NA.NombreActividad,
       CONCAT(US.NombreUsuario, ' ', US.ApellidoUsuario) AS RealizadoPor,
       CONCAT(US2.NombreUsuario, ' ', US2.ApellidoUsuario) AS CreadoPor,
       E.NombreEstado,
       LAP.FechaCreacionActividad,
       LAP.FechaConclusionActividad
FROM ListadoActividadPretratamiento As LAP
         INNER JOIN Area A
                    ON LAP.idArea = A.idArea
         INNER JOIN AreaPretratamiento AP
                    ON LAP.idAreaPretratamiento = AP.idAreaPretratamiento
         INNER JOIN NombreActividad NA
                    ON LAP.idNombreActividad = NA.idNombreActividad
         INNER JOIN users US
                    ON LAP.CreadoPor = US.idUsuario
         INNER JOIN users US2
                    ON LAP.RealizadoPor = US2.idUsuario
         INNER JOIN Estado E
                    ON LAP.EstadoActividad = E.idEstado;

-- Ver listado de materiales actividades caldera
SELECT LMAP.idListadoMaterialActividadPretratamiento,
       P.CodigoProducto,
       P.NombreProducto,
       LMAP.CantidadProducto
FROM ListadoMaterialActividadPretratamiento As LMAP
         INNER JOIN Producto P
                    ON LMAP.idProducto = P.idProducto
WHERE idListadoActividadPretratamiento = 2;

-- Ver listadoActividadesTorreEnfriamiento
SELECT LATE.idListadoActividadTorreEnfriamiento,
       A.NombreArea,
       NA.NombreActividad,
       CONCAT(US.NombreUsuario, ' ', US.ApellidoUsuario) AS RealizadoPor,
       CONCAT(US2.NombreUsuario, ' ', US2.ApellidoUsuario) AS CreadoPor,
       E.NombreEstado,
       LATE.FechaCreacionActividad,
       LATE.FechaConclusionActividad
FROM ListadoActividadTorreEnfriamiento As LATE
         INNER JOIN Area A
                    ON LATE.idArea = A.idArea
         INNER JOIN NombreActividad NA
                    ON LATE.idNombreActividad = NA.idNombreActividad
         INNER JOIN users US
                    ON LATE.CreadoPor = US.idUsuario
         INNER JOIN users US2
                    ON LATE.RealizadoPor = US2.idUsuario
         INNER JOIN Estado E
                    ON LATE.EstadoActividad = E.idEstado
        WHERE LATE.idListadoActividadTorreEnfriamiento = 2;

-- Ver listado de materiales actividades caldera
SELECT LMATE.idListadoMaterialActividadTorreEnfriamiento,
       P.CodigoProducto,
       P.NombreProducto,
       LMATE.CantidadProducto
FROM ListadoMaterialActividadTorreEnfriamiento As LMATE
         INNER JOIN Producto P
                    ON LMATE.idProducto = P.idProducto
WHERE idListadoActividadTorreEnfriamiento = 2;


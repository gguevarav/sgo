/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Area` (
  `idArea` tinyint(4) NOT NULL AUTO_INCREMENT,
  `NombreArea` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idArea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Estado` (
  `idEstado` tinyint(4) NOT NULL AUTO_INCREMENT,
  `NombreEstado` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Inventario` (
  `idInventario` int(11) NOT NULL AUTO_INCREMENT,
  `idProducto` int(11) NOT NULL,
  `CantidadExistencia` decimal(10,0) NOT NULL,
  `CantidadMinima` decimal(10,0) NOT NULL,
  `CantidadMaxima` decimal(10,0) NOT NULL,
  PRIMARY KEY (`idInventario`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `Inventario_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `Producto` (`idProducto`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ListadoActividad` (
  `idListadoActividad` int(11) NOT NULL AUTO_INCREMENT,
  `idArea` tinyint(4) NOT NULL,
  `idNombreActividad` tinyint(4) NOT NULL,
  `FechaCreacionActividad` date NOT NULL,
  `FechaConclusionActividad` date NOT NULL,
  `EstadoActividad` tinyint(1) NOT NULL,
  `idUsuario` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idListadoActividad`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `ListadoActividad_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ListadoMaterial` (
  `idListadoMaterial` int(11) NOT NULL AUTO_INCREMENT,
  `idListadoActividad` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `CantidadProducto` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idListadoMaterial`),
  KEY `idListadoActividad` (`idListadoActividad`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `ListadoMaterial_ibfk_1` FOREIGN KEY (`idListadoActividad`) REFERENCES `ListadoActividad` (`idListadoActividad`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `ListadoMaterial_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `Producto` (`idProducto`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NombreActividad` (
  `idNombreActividad` tinyint(4) NOT NULL AUTO_INCREMENT,
  `NombreActividad` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idNombreActividad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Producto` (
  `idProducto` int(11) NOT NULL AUTO_INCREMENT,
  `CodigoProducto` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `NombreProducto` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `idUnidadMedida` tinyint(4) NOT NULL,
  `EstadoProducto` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `idUnidadMedida` (`idUnidadMedida`),
  CONSTRAINT `Producto_ibfk_1` FOREIGN KEY (`idUnidadMedida`) REFERENCES `UnidadMedida` (`idUnidadMedida`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Puesto` (
  `idPuesto` tinyint(4) NOT NULL AUTO_INCREMENT,
  `NombrePuesto` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `EstadoPuesto` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idPuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rol` (
  `idRol` tinyint(4) NOT NULL AUTO_INCREMENT,
  `NombreRol` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UnidadMedida` (
  `idUnidadMedida` tinyint(4) NOT NULL AUTO_INCREMENT,
  `NombreUnidadMedida` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `AbreviacionUnidadMedida` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUnidadMedida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `idUsuario` tinyint(4) NOT NULL AUTO_INCREMENT,
  `NombreUsuario` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `ApellidoUsuario` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `idPuesto` tinyint(4) NOT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `password` text COLLATE utf8_spanish_ci NOT NULL,
  `idRol` tinyint(4) NOT NULL,
  `EstadoUsuario` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `remember_token` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `idPuesto` (`idPuesto`),
  KEY `idRol` (`idRol`),
  CONSTRAINT `Usuario_ibfk_1` FOREIGN KEY (`idPuesto`) REFERENCES `Puesto` (`idPuesto`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `Usuario_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `Rol` (`idRol`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


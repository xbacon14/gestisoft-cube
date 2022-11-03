/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.6.47-log : Database - gestisoft_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`gestisoft_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `gestisoft_db`;

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `ID_CLIENTE` int(11) NOT NULL AUTO_INCREMENT,
  `ESTADO` tinyint(4) NOT NULL DEFAULT '1',
  `NOMBRE` varchar(80) NOT NULL,
  `CI_RUC` varchar(30) DEFAULT NULL,
  `EMAIL` varchar(80) DEFAULT NULL,
  `CELULAR` varchar(20) DEFAULT NULL,
  `LINEA_BAJA` varchar(20) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `OBSERVACION` varchar(255) DEFAULT NULL,
  `FECHA_ALTA` datetime NOT NULL,
  PRIMARY KEY (`ID_CLIENTE`),
  UNIQUE KEY `UNIQUE` (`CI_RUC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cliente` */

/*Table structure for table `configuracion` */

DROP TABLE IF EXISTS `configuracion`;

CREATE TABLE `configuracion` (
  `CONFIGURACION_EFECTUADA` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `configuracion` */

insert  into `configuracion`(`CONFIGURACION_EFECTUADA`) values (0);

/*Table structure for table `datos_empresa` */

DROP TABLE IF EXISTS `datos_empresa`;

CREATE TABLE `datos_empresa` (
  `ID_DATOS_EMPRESA` int(1) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(80) NOT NULL,
  `RUC` varchar(30) DEFAULT NULL,
  `CELULAR` int(11) DEFAULT NULL,
  `LINEA_BAJA` int(11) DEFAULT NULL,
  `EMAIL` varchar(80) DEFAULT NULL,
  `CIUDAD` varchar(30) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `OBSERVACION` varchar(255) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `BO_CONFIGURACION_EFECTUADA` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_DATOS_EMPRESA`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `datos_empresa` */

insert  into `datos_empresa`(`ID_DATOS_EMPRESA`,`NOMBRE`,`RUC`,`CELULAR`,`LINEA_BAJA`,`EMAIL`,`CIUDAD`,`DIRECCION`,`OBSERVACION`,`FECHA_REGISTRO`,`BO_CONFIGURACION_EFECTUADA`) values (1,'CUBE DESARROLLO','5243358-7',NULL,NULL,NULL,NULL,NULL,NULL,'2022-11-03 15:18:51',1);

/*Table structure for table `producto` */

DROP TABLE IF EXISTS `producto`;

CREATE TABLE `producto` (
  `ID_PRODUCTO` int(11) NOT NULL AUTO_INCREMENT,
  `ESTADO` tinyint(4) NOT NULL DEFAULT '1',
  `NOMBRE` varchar(80) NOT NULL,
  `CANTIDAD` decimal(20,3) DEFAULT NULL,
  `PRECIO_VENTA` decimal(20,3) DEFAULT NULL,
  `UNIDAD_MEDIDA` varchar(30) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `EXISTENCIA` decimal(20,3) DEFAULT NULL,
  `OBSERVACION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `producto` */

/*Table structure for table `vendedor` */

DROP TABLE IF EXISTS `vendedor`;

CREATE TABLE `vendedor` (
  `ID_VENDEDOR` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(80) NOT NULL,
  `CI` varbinary(15) NOT NULL,
  `CELULAR` varchar(20) DEFAULT NULL,
  `LINEA_BAJA` varchar(20) DEFAULT NULL,
  `CIUDAD` varchar(30) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `OBSERVACION` varchar(255) DEFAULT NULL,
  `FECHA_ALTA` datetime NOT NULL,
  `ESTADO` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID_VENDEDOR`),
  UNIQUE KEY `ci` (`CI`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `vendedor` */

/*Table structure for table `venta` */

DROP TABLE IF EXISTS `venta`;

CREATE TABLE `venta` (
  `ID_VENTA` int(11) NOT NULL AUTO_INCREMENT,
  `CHOFER` varchar(50) DEFAULT NULL,
  `DOC_NRO` varchar(50) DEFAULT NULL,
  `FECHA` datetime NOT NULL,
  `OBSERVACION` varchar(100) DEFAULT NULL,
  `TOTAL` decimal(20,3) DEFAULT NULL,
  `VEHICULO` varchar(30) NOT NULL,
  `ESTADO` tinyint(4) DEFAULT '1',
  `ID_VENDEDOR` int(11) NOT NULL,
  `ID_CLIENTE` int(11) NOT NULL,
  PRIMARY KEY (`ID_VENTA`),
  KEY `VENTA_FK_VENDEDOR` (`ID_VENDEDOR`),
  KEY `VENTA_FK_CLIENTE` (`ID_CLIENTE`),
  CONSTRAINT `VENTA_FK_CLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`),
  CONSTRAINT `VENTA_FK_VENDEDOR` FOREIGN KEY (`ID_VENDEDOR`) REFERENCES `vendedor` (`ID_VENDEDOR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `venta` */

/*Table structure for table `venta_detalle` */

DROP TABLE IF EXISTS `venta_detalle`;

CREATE TABLE `venta_detalle` (
  `ID_VENTA_DETALLE` int(11) NOT NULL AUTO_INCREMENT,
  `CANTIDAD` double NOT NULL,
  `PRECIO` int(11) NOT NULL,
  `ID_VENTA` int(11) NOT NULL,
  `ID_PRODUCTO` int(11) NOT NULL,
  PRIMARY KEY (`ID_VENTA_DETALLE`),
  KEY `VENTA_DETALLE_FK_VENTA` (`ID_VENTA`),
  KEY `VENTA_DETALLE_FK_PRODUCTO` (`ID_PRODUCTO`),
  CONSTRAINT `VENTA_DETALLE_FK_PRODUCTO` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `producto` (`ID_PRODUCTO`),
  CONSTRAINT `VENTA_DETALLE_FK_VENTA` FOREIGN KEY (`ID_VENTA`) REFERENCES `venta` (`ID_VENTA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `venta_detalle` */

/* Procedure structure for procedure `truncate_tables` */

/*!50003 DROP PROCEDURE IF EXISTS  `truncate_tables` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `truncate_tables`()
BEGIN
  SET FOREIGN_KEY_CHECKS = 0 ;
  TRUNCATE TABLE `gestisoft_db`.`datos_empresa` ;
  TRUNCATE TABLE `gestisoft_db`.`venta_detalle` ;
  TRUNCATE TABLE `gestisoft_db`.`producto` ;
  TRUNCATE TABLE `gestisoft_db`.`cliente` ;
  TRUNCATE TABLE `gestisoft_db`.`vendedor` ;
  TRUNCATE TABLE `gestisoft_db`.`venta` ;
  SET FOREIGN_KEY_CHECKS = 1;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

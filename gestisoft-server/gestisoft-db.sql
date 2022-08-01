/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.7.36-log : Database - gestisoft_db
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
  `NUMERO_CELULAR` varchar(20) DEFAULT NULL,
  `NUMERO_LINEA_BAJA` varchar(20) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `OBSERVACION` varchar(255) DEFAULT NULL,
  `FECHA_ALTA` datetime NOT NULL,
  PRIMARY KEY (`ID_CLIENTE`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `cliente` */

insert  into `cliente`(`ID_CLIENTE`,`ESTADO`,`NOMBRE`,`CI_RUC`,`EMAIL`,`NUMERO_CELULAR`,`NUMERO_LINEA_BAJA`,`DIRECCION`,`OBSERVACION`,`FECHA_ALTA`) values (1,1,'ITALO ANTONIO GOLIN','5243358','italo.galeano123@gmail.com','+595981383068','046243196','CALLE SAN MIGUEL 912','FRENTE A CASA DE LAS OFERTAS','2022-07-31 21:47:00');

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
  PRIMARY KEY (`ID_DATOS_EMPRESA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `datos_empresa` */

/*Table structure for table `producto` */

DROP TABLE IF EXISTS `producto`;

CREATE TABLE `producto` (
  `ID_PRODUCTO` int(11) NOT NULL AUTO_INCREMENT,
  `ESTADO` tinyint(4) NOT NULL DEFAULT '1',
  `NOMBRE` varchar(80) NOT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  `PRECIO_VENTA` int(11) DEFAULT NULL,
  `UNIDAD_MEDIDA` varchar(30) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `EXISTENCIA` double DEFAULT NULL,
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
  `CELULAR` int(11) DEFAULT NULL,
  `LINEA_BAJA` int(11) DEFAULT NULL,
  `CIUDAD` varchar(30) DEFAULT NULL,
  `DIRECCION` varchar(255) DEFAULT NULL,
  `OBSERVACION` varchar(255) DEFAULT NULL,
  `FECHA_ALTA` datetime NOT NULL,
  PRIMARY KEY (`ID_VENDEDOR`),
  UNIQUE KEY `ci` (`CI`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `vendedor` */

/*Table structure for table `venta` */

DROP TABLE IF EXISTS `venta`;

CREATE TABLE `venta` (
  `ID_VENTA` int(11) NOT NULL AUTO_INCREMENT,
  `CHOFER` varchar(50) DEFAULT NULL,
  `FECHA` datetime NOT NULL,
  `OBSERVACION` varchar(100) DEFAULT NULL,
  `TOTAL` int(11) DEFAULT NULL,
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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

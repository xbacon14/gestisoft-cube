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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `cliente` */

insert  into `cliente`(`ID_CLIENTE`,`ESTADO`,`NOMBRE`,`CI_RUC`,`EMAIL`,`CELULAR`,`LINEA_BAJA`,`DIRECCION`,`OBSERVACION`,`FECHA_ALTA`) values (1,1,'ZXCZX','123123','italo.galeano123@gmail.com','+595981383068','046243196','CALLE SAN MIGUEL 912','FRENTE A CASA DE LAS OFERTAS','2022-07-31 21:47:00'),(2,1,'ADADAD','4564547','italo.galeano123@gmail.com','0981383068','046243196','CALLE SAN MIGUEL 912 C/ AV PARAGUAY','FRENTE A CASA DE LAS OFERTAS','2022-08-05 00:50:56'),(3,1,'JORGE','5243358','italo.galeano123@gmail.com','0981383068','046243196','CALLE SAN MIGUEL 912 C/ AV PARAGUAY','FRENTE A CASA DE LAS OFERTAS','2022-08-05 00:50:56'),(4,1,'Fulano ccp','645898498','adasas@gmail.com','0984165665','','','','2022-08-10 01:57:24');

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
  `CANTIDAD` decimal(20,3) DEFAULT NULL,
  `PRECIO_VENTA` decimal(20,3) DEFAULT NULL,
  `UNIDAD_MEDIDA` varchar(30) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `EXISTENCIA` decimal(20,3) DEFAULT NULL,
  `OBSERVACION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCTO`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `producto` */

insert  into `producto`(`ID_PRODUCTO`,`ESTADO`,`NOMBRE`,`CANTIDAD`,`PRECIO_VENTA`,`UNIDAD_MEDIDA`,`FECHA_REGISTRO`,`EXISTENCIA`,`OBSERVACION`) values (1,1,'ARENA LAVADA TIPO 1',2000.000,5000.000,'METROS CUADRADOS','2022-08-05 00:54:47',10000.000,'TIPO I'),(2,1,'Arena tipo blanca',40000.000,30000.000,'Metros cúbicos','2022-08-22 00:55:04',0.000,'Ultrafina'),(3,1,'arena tipo IV',121212.000,50000.000,'METROS CÚBICOS','2022-08-22 01:09:37',0.000,'ULTRA FINA'),(5,1,'PIEDRA TRITURADA TIPO III',200000.000,4000.000,'METROS CÚBICOS','2022-08-23 20:33:05',0.000,'PARA ESTACIONAMIENTO');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `vendedor` */

insert  into `vendedor`(`ID_VENDEDOR`,`NOMBRE`,`CI`,`CELULAR`,`LINEA_BAJA`,`CIUDAD`,`DIRECCION`,`OBSERVACION`,`FECHA_ALTA`,`ESTADO`) values (1,'ITALO GOLIN','5243358','+595981383068','046243196','SALTO DEL GUAIRÁ','CALLE SAN MIGUEL 912','FRENTE A CASA DE LAS OFERTAS','2022-08-11 22:37:50',1);

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `venta` */

insert  into `venta`(`ID_VENTA`,`CHOFER`,`DOC_NRO`,`FECHA`,`OBSERVACION`,`TOTAL`,`VEHICULO`,`ESTADO`,`ID_VENDEDOR`,`ID_CLIENTE`) values (1,'GUILLERMO','001-001-000001','2022-08-26 03:47:39','entregar en la casa del vecino',5000.000,'SCANIA 360',1,1,4),(2,'JORGE',NULL,'2022-09-27 01:54:31','Frente a la municipalidad',66000.000,'SCANIA FORD',0,1,4),(3,'Guillermo','001-001-0003241','2022-09-27 01:57:31','Frente a la muni',182000.000,'Ford f1000',0,1,4),(4,'asdasd','','2022-09-27 02:06:09','asdasda',660000.000,'asdasd',1,1,1),(5,'JORGE','001-001-00056565','2022-10-06 22:02:45','Alguna descripcion',14000000.000,'MASKAROV',1,1,2),(6,'asdasd','001-001-0005648','2022-10-06 22:06:13','asdasdasd',454920.000,'2sadasd',1,1,2),(7,'qqweqdas','001-001-0005859','2022-10-06 22:34:31','asdasdasd',2255000.000,'1asdasdas',1,1,2),(8,'12312asdasd','001-001-0005659','2022-10-06 22:38:13','asdasdasd',5000.000,'12121212',1,1,4),(9,'asdasdasdad','001-001-0004654','2022-10-06 22:40:22','asdasdasda',2500000.000,'asdasdasdasd',1,1,1),(10,'asdasdadad','001-001-00012123','2022-10-06 22:43:05','adssasdasdasd',17250000.000,'asdadsasdasd',1,1,1),(11,'aasdasasdasd','001-001-0001231','2022-10-06 22:44:42','sdasdasdasd',92000.000,'asdasdasdasd',1,1,2),(12,'dadadadad','001-001-0001231231','2022-10-06 22:46:22','addadaadad',1155000.000,'daadadada',1,1,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

/*Data for the table `venta_detalle` */

insert  into `venta_detalle`(`ID_VENTA_DETALLE`,`CANTIDAD`,`PRECIO`,`ID_VENTA`,`ID_PRODUCTO`) values (1,2000,5000,1,2),(2,2000,5000,2,2),(7,1,5000,2,1),(8,2,30000,2,2),(9,1,5000,2,1),(10,2,30000,2,2),(15,1,5000,2,1),(16,2,30000,2,2),(17,1,5000,2,1),(18,2,30000,2,2),(19,1,5000,2,1),(20,2,30000,2,2),(21,1,5000,2,1),(22,2,30000,2,2),(23,1,5000,2,1),(24,2,30000,2,2),(25,1,6000,2,1),(26,1,60000,2,3),(27,1,5000,2,1),(28,1,50000,2,1),(29,2,8000,2,5),(30,1,50000,3,2),(31,3,44000,3,5),(32,12,55000,4,1),(33,400,30000,5,2),(34,500,4000,5,5),(35,15,30000,6,2),(36,123,40,6,2),(37,1,5000,7,1),(38,45,50000,7,3),(39,1,5000,8,1),(40,50,50000,9,3),(41,345,50000,10,3),(42,23,4000,11,5),(43,231,5000,12,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

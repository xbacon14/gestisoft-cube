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
  `CI_RUC` varchar(16) DEFAULT NULL,
  `CORREO_ELECTRONICO` varchar(80) DEFAULT NULL,
  `NUMERO_CELULAR` varchar(20) DEFAULT NULL,
  `NUMERO_LINEA_BAJA` varchar(20) DEFAULT NULL,
  `DIRECCION` varchar(80) DEFAULT NULL,
  `OBSERVACION` varchar(80) DEFAULT NULL,
  `FECHA_ALTA` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_CLIENTE`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `cliente` */

insert  into `cliente`(`ID_CLIENTE`,`ESTADO`,`NOMBRE`,`CI_RUC`,`CORREO_ELECTRONICO`,`NUMERO_CELULAR`,`NUMERO_LINEA_BAJA`,`DIRECCION`,`OBSERVACION`,`FECHA_ALTA`) values (1,1,'ITALO ANTONIO GOLIN','5243358','italo.galeano123@gmail.com','+595981383068','046243196','CALLE SAN MIGUEL 912','FRENTE A CASA DE LAS OFERTAS','2022-07-31 21:47:00');

/*Table structure for table `persona` */

DROP TABLE IF EXISTS `persona`;

CREATE TABLE `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_apellido` varchar(50) NOT NULL,
  `ci_ruc` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ci` (`ci_ruc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `persona` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

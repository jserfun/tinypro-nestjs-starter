--
-- Create database tinypro_nestjs
--

CREATE DATABASE `tinypro_nestjs` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

------------------------------------------------------------------------------------

use tinypro_nestjs;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

START TRANSACTION;

--
-- Table structure for table `i18`
--

DROP TABLE IF EXISTS `i18`;

CREATE TABLE `i18` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `langId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ee6c070b91e32eae04e541e5844` (`langId`),
  CONSTRAINT `FK_ee6c070b91e32eae04e541e5844` FOREIGN KEY (`langId`) REFERENCES `lang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `i18`
--

LOCK TABLES `i18` WRITE;

UNLOCK TABLES;

--
-- Table structure for table `lang`
--

DROP TABLE IF EXISTS `lang`;


CREATE TABLE `lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lang`
--

LOCK TABLES `lang` WRITE;

INSERT INTO `lang` VALUES (1,'enUS'),(2,'zhCN');

UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `order` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `menuType` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `component` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;

INSERT INTO `menu` VALUES (1,'Board',1,NULL,'normal','IconApplication','board/index','board','menu.board'),(2,'Home',1,1,'normal','','board/home/index','home','menu.home'),(3,'Work',2,1,'normal','','board/work/index','work','menu.work'),(4,'List',2,NULL,'normal','IconFiles','list/index','list','menu.list'),(5,'Table',1,4,'normal','','list/search-table/index','table','menu.list.searchTable'),(6,'Form',3,NULL,'normal','IconSetting','form/index','form','menu.form'),(7,'Base',1,6,'normal','','form/base/index','base','menu.form.base'),(8,'Step',2,6,'normal','','form/step/index','step','menu.form.step'),(9,'Profile',4,NULL,'normal','IconFiletext','profile/index','profile','menu.profile'),(10,'Detail',1,9,'normal','','profile/detail/index','detail','menu.profile.detail'),(11,'Result',5,NULL,'normal','IconSuccessful','result/index','result','menu.result'),(12,'Success',1,11,'normal','','result/success/index','success','menu.result.success'),(13,'Error',2,11,'normal','','result/error/index','error','menu.result.error'),(14,'Exception',6,NULL,'normal','IconCueL','exception/index','exception','menu.exception'),(15,'403',1,14,'normal','','exception/403/index','403','menu.exception.403'),(16,'404',2,14,'normal','','exception/404/index','404','menu.exception.404'),(17,'500',1,14,'normal','','exception/500/index','500','menu.exception.500'),(18,'User',7,NULL,'normal','IconUser','user/index','user','menu.user'),(19,'Info',1,18,'normal','','user/info/index','info','menu.user.info'),(20,'Cloud',8,NULL,'normal','IconDownloadCloud','cloud/index','cloud','menu.cloud'),(21,'Hello',1,20,'normal','','cloud/hello/index','hello','menu.cloud.hello'),(22,'Contracts',2,20,'normal','','cloud/contracts/index','contracts','menu.cloud.contracts'),(23,'MenuPage',9,NULL,'normal','IconApp','menu/index','menuPage','menu.menuPage'),(24,'SecondMenu',1,23,'normal','','menu/index','secondMenu','menu.menuPage.second'),(25,'ThirdMenu',1,24,'normal','','menu/demo/index','thirdMenu','menu.menuPage.third'),(26,'SystemManager',10,NULL,'normal','IconTotal','menu/index','','menu.systemManager'),(27,'AllMenu',1,26,'admin','IconGrade','menu/info/index','menu/allMenu','menu.menu.info'),(28,'AllPermission',1,26,'admin','IconFolderOpened','permission/info/index','permission/allPermission','menu.permission.info'),(29,'AllRole',1,26,'admin','IconActivation','role/info/index','role/allRole','menu.role.info'),(30,'AllInfo',1,26,'admin','IconGroup','userManager/info/index','userManager/allInfo','menu.userManager.info'),(31,'Local',14,26,'','IconFlag','locale/index','locale','menu.i18n');

UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;


CREATE TABLE `permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `desc` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;

INSERT INTO `permission` VALUES (1,'super permission','*'),(2,'','user::add'),(3,'','role::remove'),(4,'','role::update'),(5,'','user::remove'),(6,'','permission::get'),(7,'','permission::update'),(8,'','role::query'),(9,'','user::update'),(10,'','menu::add'),(11,'','permission::add'),(12,'','user::query'),(13,'','user::password::force-update'),(14,'','permission::remove'),(15,'','menu::update'),(16,'','menu::remove'),(17,'','role::add'),(18,'','i18n::update'),(19,'','i18n::add'),(20,'','i18n::remove'),(21,'','lang::add'),(22,'','menu::query'),(23,'','lang::remove'),(24,'','i18n::query'),(25,'','lang::update'),(26,'','lang::query');

UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;

INSERT INTO `role` VALUES (1,'admin');

UNLOCK TABLES;

--
-- Table structure for table `role_menu`
--

DROP TABLE IF EXISTS `role_menu`;


CREATE TABLE `role_menu` (
  `roleId` int NOT NULL,
  `menuId` int NOT NULL,
  PRIMARY KEY (`roleId`,`menuId`),
  KEY `IDX_4a57845f090fb832eeac3e3486` (`roleId`),
  KEY `IDX_ed7dbf72cc845b0c9150a67851` (`menuId`),
  CONSTRAINT `FK_4a57845f090fb832eeac3e34860` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ed7dbf72cc845b0c9150a678512` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_menu`
--

LOCK TABLES `role_menu` WRITE;

INSERT INTO `role_menu` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29),(1,30),(1,31);

UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
  `roleId` int NOT NULL,
  `permissionId` int NOT NULL,
  PRIMARY KEY (`roleId`,`permissionId`),
  KEY `IDX_e3130a39c1e4a740d044e68573` (`roleId`),
  KEY `IDX_72e80be86cab0e93e67ed1a7a9` (`permissionId`),
  CONSTRAINT `FK_72e80be86cab0e93e67ed1a7a9a` FOREIGN KEY (`permissionId`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_e3130a39c1e4a740d044e685730` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;

INSERT INTO `role_permission` VALUES (1,1);

UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `department` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `employeeType` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `probationStart` timestamp NULL DEFAULT NULL,
  `probationEnd` timestamp NULL DEFAULT NULL,
  `probationDuration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `protocolStart` timestamp NULL DEFAULT NULL,
  `protocolEnd` timestamp NULL DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` int DEFAULT NULL,
  `createTime` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updateTime` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `salt` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;

INSERT INTO `user` VALUES (1,'admin','admin@no-reply.com','70582cd1e915f2ce49de467195b9a5ea97a5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2024-12-13 02:34:44.344271','2024-12-13 02:34:44.344271','2024-12-12 18:34:44','AQjJlg==','2024-12-12 18:34:44');

UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `userId` int NOT NULL,
  `roleId` int NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `IDX_ab40a6f0cd7d3ebfcce082131f` (`userId`),
  KEY `IDX_dba55ed826ef26b5b22bd39409` (`roleId`),
  CONSTRAINT `FK_ab40a6f0cd7d3ebfcce082131fd` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_dba55ed826ef26b5b22bd39409b` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;

INSERT INTO `user_role` VALUES (1,1);

UNLOCK TABLES;

SET FOREIGN_KEY_CHECKS = 1;

COMMIT;

---- good luck with your nestjs app ----

-- MySQL dump 10.13  Distrib 5.5.36-34.2, for Linux (x86_64)
--
-- Host: localhost    Database: loki
-- ------------------------------------------------------
-- Server version	5.6.26-74.0-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cobar_server`
--

DROP TABLE IF EXISTS `cobar_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cobar_server` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cobar_ip` varchar(64) NOT NULL,
  `cluster` varchar(16) DEFAULT NULL,
  `cobar_adm_port` int(11) NOT NULL,
  `uptime` varchar(64) DEFAULT NULL,
  `used_memory` bigint(20) DEFAULT NULL,
  `total_memory` bigint(20) DEFAULT NULL,
  `max_memory` bigint(20) DEFAULT NULL,
  `reload_time` bigint(20) DEFAULT NULL,
  `rollback_time` bigint(20) DEFAULT NULL,
  `charset` varchar(16) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `last_change` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uni_cobar` (`cobar_ip`,`cobar_adm_port`)
) ENGINE=InnoDB AUTO_INCREMENT=16902476409078 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `codis_instance`
--

DROP TABLE IF EXISTS `codis_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codis_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `zk` varchar(8) CHARACTER SET latin1 NOT NULL,
  `zk_addr` varchar(128) CHARACTER SET latin1 DEFAULT NULL,
  `dashboard` varchar(128) CHARACTER SET latin1 DEFAULT NULL,
  `proxy` varchar(256) DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`zk`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collectors`
--

DROP TABLE IF EXISTS `collectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL,
  `node_id` int(11) NOT NULL,
  `conf` text NOT NULL,
  `ctime` datetime NOT NULL,
  `mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_collectors_node_id` (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `database`
--

DROP TABLE IF EXISTS `database`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pa` varchar(64) DEFAULT NULL,
  `schema` varchar(64) DEFAULT NULL,
  `product` varchar(64) DEFAULT NULL,
  `interface` varchar(32) DEFAULT '',
  `cluster` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datanode`
--

DROP TABLE IF EXISTS `datanode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datanode` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `datasource` varchar(128) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  `cobar_ip` varchar(64) DEFAULT NULL,
  `cobar_user_port` int(11) DEFAULT NULL,
  `cobar_adm_port` int(11) DEFAULT NULL,
  `cluster` varchar(16) NOT NULL,
  `last_change` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uni_cobar_kye` (`cobar_ip`,`datasource`,`cobar_adm_port`)
) ENGINE=InnoDB AUTO_INCREMENT=107829512 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datasource`
--

DROP TABLE IF EXISTS `datasource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datasource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `host` varchar(64) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `schema` varchar(64) DEFAULT NULL,
  `cobar_ip` varchar(64) DEFAULT NULL,
  `cobar_user_port` int(11) DEFAULT NULL,
  `cobar_adm_port` int(11) DEFAULT NULL,
  `cluster` varchar(16) NOT NULL,
  `last_change` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unix_cobar` (`cobar_ip`,`name`,`cobar_adm_port`),
  UNIQUE KEY `idx_uni_cobar_id` (`id`,`cobar_ip`,`name`,`cobar_adm_port`)
) ENGINE=InnoDB AUTO_INCREMENT=177944630 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deployment`
--

DROP TABLE IF EXISTS `deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deployment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `node_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `parameters` text NOT NULL,
  `ctime` datetime NOT NULL,
  `mtime` datetime NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9211482504638280672 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mysql_daily_stat`
--

DROP TABLE IF EXISTS `mysql_daily_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mysql_daily_stat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(64) DEFAULT NULL,
  `queries` bigint(20) DEFAULT NULL,
  `com_select` bigint(20) DEFAULT NULL,
  `com_write` bigint(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `host_date_idx` (`hostname`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=84920 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mysql_instances`
--

DROP TABLE IF EXISTS `mysql_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mysql_instances` (
  `host` varchar(64) DEFAULT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `datadir` varchar(128) DEFAULT NULL,
  `user` varchar(64) DEFAULT NULL,
  `version` varchar(32) DEFAULT NULL,
  `masterhost` varchar(64) DEFAULT NULL,
  `masterip` varchar(15) DEFAULT NULL,
  `masterport` int(11) DEFAULT NULL,
  `slaves` varchar(1024) DEFAULT NULL,
  `dbs` varchar(1024) DEFAULT NULL,
  `last_change` datetime NOT NULL,
  PRIMARY KEY (`ip`,`port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mysql_instances_cluster`
--

DROP TABLE IF EXISTS `mysql_instances_cluster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mysql_instances_cluster` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(64) DEFAULT NULL,
  `schema` varchar(64) DEFAULT NULL,
  `flags` int(11) DEFAULT NULL COMMENT '0:Preonline, -1:Not use, 1:Online, -2:Debug',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_config`
--

DROP TABLE IF EXISTS `node_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_docker`
--

DROP TABLE IF EXISTS `node_docker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_docker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `isDocker` tinyint(1) NOT NULL DEFAULT '0',
  `publishedPort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_servers`
--

DROP TABLE IF EXISTS `node_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `server_id` int(11) DEFAULT NULL,
  `offline` tinyint(1) NOT NULL DEFAULT '0',
  `traffic_ratio` decimal(4,3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_info_unique_index` (`server_id`,`node_id`),
  KEY `ix_node_servers_offline` (`offline`),
  CONSTRAINT `node_servers_ibfk_1` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53902 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_upstream`
--

DROP TABLE IF EXISTS `node_upstream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_upstream` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `port` int(11) NOT NULL DEFAULT '8080',
  `ip_hash` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `target_filename` varchar(100) NOT NULL,
  `branch` varchar(50) NOT NULL,
  `idc` varchar(50) NOT NULL,
  `ctime` datetime NOT NULL,
  `url` varchar(300) NOT NULL,
  `md5` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_packages_name` (`name`),
  KEY `ix_packages_branch` (`branch`)
) ENGINE=InnoDB AUTO_INCREMENT=30984 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policys`
--

DROP TABLE IF EXISTS `policys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL,
  `node_id` int(11) NOT NULL,
  `is_in_use` tinyint(1) NOT NULL,
  `conf` text NOT NULL,
  `ctime` datetime NOT NULL,
  `mtime` datetime NOT NULL,
  `collector_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `collector_id` (`collector_id`),
  KEY `ix_policys_node_id` (`node_id`),
  CONSTRAINT `policys_ibfk_1` FOREIGN KEY (`collector_id`) REFERENCES `collectors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `privileges`
--

DROP TABLE IF EXISTS `privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `privilege_type` varchar(30) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `matrix` bigint(20) NOT NULL,
  `extra_info` varchar(300) DEFAULT NULL,
  `modifier` varchar(30) DEFAULT NULL,
  `ctime` datetime NOT NULL,
  `mtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_privilege` (`node_id`,`username`,`privilege_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1540 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `redis_instance`
--

DROP TABLE IF EXISTS `redis_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redis_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(64) NOT NULL,
  `port` varchar(80) DEFAULT NULL,
  `status` varchar(8) DEFAULT NULL,
  `master_port` varchar(8) DEFAULT NULL,
  `master_host` varchar(64) DEFAULT NULL,
  `cluster` varchar(64) DEFAULT NULL,
  `used_memory` varchar(32) DEFAULT NULL,
  `conf_maxmemory` varchar(32) DEFAULT NULL,
  `conf_dir` varchar(64) DEFAULT NULL,
  `conf_dbfilename` varchar(64) DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_host_port` (`host`,`port`)
) ENGINE=InnoDB AUTO_INCREMENT=1192 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(50) NOT NULL,
  `hostname` varchar(50) NOT NULL,
  `validity` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `ctime` datetime NOT NULL,
  `mtime` datetime DEFAULT NULL,
  `macs` varbinary(600) DEFAULT NULL,
  `private_ipv4s` varbinary(400) DEFAULT NULL,
  `public_ipv4s` varbinary(400) DEFAULT NULL,
  `s_info` text,
  `vm_host_id` int(11) DEFAULT NULL,
  `vm_name` varchar(40) DEFAULT NULL,
  `idc` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`),
  KEY `servers_ifbk_1` (`vm_host_id`),
  CONSTRAINT `servers_ifbk_1` FOREIGN KEY (`vm_host_id`) REFERENCES `servers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11016 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `node_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `parameters` text NOT NULL,
  `ctime` datetime NOT NULL,
  `mtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_unique_index` (`name`,`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2084 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trackurl`
--

DROP TABLE IF EXISTS `trackurl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackurl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `domain` varchar(50) NOT NULL,
  `path` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trackurl_unique_index` (`domain`,`path`),
  KEY `ix_trackurl_product_id` (`product_id`),
  KEY `ix_trackurl_service_id` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=726 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userauth`
--

DROP TABLE IF EXISTS `userauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `schema` varchar(64) NOT NULL,
  `expire_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `xdual`
--

DROP TABLE IF EXISTS `xdual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xdual` (
  `x` timestamp NOT NULL DEFAULT '1986-08-14 15:00:00',
  `id` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-07  2:03:46

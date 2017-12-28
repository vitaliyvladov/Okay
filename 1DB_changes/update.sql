DROP TABLE IF EXISTS `mi_executed_migration`;
CREATE TABLE `mi_executed_migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

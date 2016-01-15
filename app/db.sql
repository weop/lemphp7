# ************************************************************
# running vagrant provision inserts this sql dump to localdb
# ************************************************************

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

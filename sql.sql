
CREATE TABLE `supernatural` (
  `identifier` varchar(50) DEFAULT NULL,
  `class` varchar(5000) DEFAULT NULL,
  `mana` INT DEFAULT 0,
  `role` int DEFAULT NULL,
  `transform` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

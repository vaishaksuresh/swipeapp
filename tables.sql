/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
DROP TABLE IF EXISTS ccacswipe.ccac_registered_users;
CREATE TABLE `ccac_registered_users` (
  `student_id` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `major` varchar(30) DEFAULT NULL,
  `year_in_college` varchar(30) DEFAULT NULL,
  `area_of_interest` varchar(50) DEFAULT NULL,
  `subscribed_to_newsletter` tinyint(1) DEFAULT NULL,
  `signup_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update_mode` varchar(10) DEFAULT NULL,
  `total_login_count` int(11) DEFAULT '0',
  PRIMARY KEY (`student_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Holds the details who have registered to the swipe applicati';


/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

DROP TABLE IF EXISTS ccacswipe.login_activity;
CREATE TABLE `login_activity` (
  `student_id` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `major` varchar(30) DEFAULT NULL,
  `year_in_college` varchar(30) DEFAULT NULL,
  `area_of_interest` varchar(50) DEFAULT NULL,
  `subscribed_to_newsletter` tinyint(1) DEFAULT NULL,
  `signup_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update_mode` varchar(10) DEFAULT NULL,
  `total_login_count` int(11) DEFAULT '0',
  PRIMARY KEY (`student_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Holds the details who have registered to the swipe applicati';
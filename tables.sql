# --------------------------------------------------------
# Host:                         130.65.61.97
# Database:                     ccacswipe
# Server version:               5.1.56-community
# Server OS:                    Win32
# HeidiSQL version:             5.0.0.3272
# Date/time:                    2013-01-16 13:21:16
# --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

# Dumping structure for table ccacswipe.ccac_registered_users
CREATE TABLE IF NOT EXISTS `ccac_registered_users` (
  `student_id` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `major` varchar(30) DEFAULT NULL,
  `year_in_college` varchar(30) DEFAULT NULL,
  `area_of_interest` varchar(50) DEFAULT NULL,
  `subscribed_to_newsletter` tinyint(1) DEFAULT NULL,
  `signup_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update_mode` varchar(10) DEFAULT NULL,
  `total_login_count` int(11) DEFAULT '0',
  `isactive` tinyint(1) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Holds the details who have registered to the swipe applicati';

# Dumping data for table ccacswipe.ccac_registered_users: 1 rows
/*!40000 ALTER TABLE `ccac_registered_users` DISABLE KEYS */;
INSERT INTO `ccac_registered_users` (`student_id`, `email`, `name`, `phone_number`, `major`, `year_in_college`, `area_of_interest`, `subscribed_to_newsletter`, `signup_date`, `last_login_date`, `last_update_date`, `last_update_mode`, `total_login_count`, `isactive`) VALUES ('008646222', 'vaishak.suresh@gmail.com', 'Vaishak Suresh', '4085084744', 'Software Engineering', 'Graduate Student', NULL, 1, '2013-01-14 14:05:24', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0, 0);
/*!40000 ALTER TABLE `ccac_registered_users` ENABLE KEYS */;


# Dumping structure for table ccacswipe.login_activity
CREATE TABLE IF NOT EXISTS `login_activity` (
  `activity_id` int(10) NOT NULL AUTO_INCREMENT,
  `student_id` int(10) NOT NULL,
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `login_mode` varchar(10) NOT NULL,
  `client_details` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Dumping data for table ccacswipe.login_activity: 0 rows
/*!40000 ALTER TABLE `login_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_activity` ENABLE KEYS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

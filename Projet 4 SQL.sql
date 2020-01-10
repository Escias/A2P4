#Exercice 1
CREATE DATABASE projet4 CHARACTER SET 'utf8' #créer la base de données

#Exercice 2
CREATE USER 'jimmy'@'localhost';
SET PASSWORD FOR 'jimmy'@'localhost' = PASSWORD ('hello');
GRANT ALL PRIVILEGES ON *.* TO 'jimmy'@'localhost' IDENTIFIED BY 'hello';
FLUSH PRIVILEGES;

#Exercice 3
CREATE TABLE personal_user (
  user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_lastname VARCHAR(10),
  user_firstname VARCHAR(10),
  user_mail VARCHAR(20),
  user_phone VARCHAR(15),
  user_adress VARCHAR(50),
  user_ZIP VARCHAR(10),
  user_type ENUM('admin','normal'),
  user_password VARCHAR(150),
  PRIMARY KEY (user_id)
);

CREATE TABLE room (
  room_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  room_name VARCHAR(20),
  room_user_id INT UNSIGNED,
  room_description TEXT,
  PRIMARY KEY (room_id) #clé primaire de la table
);
ALTER TABLE room #modifier la table
ADD FOREIGN KEY (room_user_id) REFERENCES personal_user(user_id); #ajouter une clé étrangère

CREATE TABLE food (
  food_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  food_room_id INT UNSIGNED,
  food_name VARCHAR(20),
  food_perempt DATETIME,
  food_quantity INT,
  PRIMARY KEY(food_id)
);
ALTER TABLE food
ADD FOREIGN KEY (food_room_id) REFERENCES room(room_id);

CREATE TABLE sensor (
  sensor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  sensor_name VARCHAR(50),
  sensor_room_id INT UNSIGNED,
  sensor_status ENUM('on','off'),
  sensor_interval INT,
  sensor_temp_min INT,
  sensor_temp_max INT,
  PRIMARY KEY (sensor_id)
);
ALTER TABLE sensor
ADD FOREIGN KEY (sensor_room_id) REFERENCES room(room_id);

CREATE TABLE datatemp (
  datatemp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  datatemp_sensor_id INT UNSIGNED,
  datatemp_temp VARCHAR(10),
  datatemp_time DATETIME,
  PRIMARY KEY (datatemp_id)
);
ALTER TABLE datatemp
ADD FOREIGN KEY (datatemp_sensor_id) REFERENCES sensor(sensor_id);

CREATE TABLE thermointel (
  thermo_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  thermo_room_id INT UNSIGNED,
  thermo_name VARCHAR(50),
  thermo_id_1 INT UNSIGNED,
  thermo_id_2 INT UNSIGNED,
  thermo_temp_target INT,
  thermo_status ENUM('inactif','chaud','froid'),
  PRIMARY KEY (thermo_id)
);
ALTER TABLE thermointel
ADD FOREIGN KEY (thermo_room_id) REFERENCES room(room_id);
ALTER TABLE thermointel
ADD FOREIGN KEY (thermo_id_1) REFERENCES sensor(sensor_id);
ALTER TABLE thermointel
ADD FOREIGN KEY (thermo_id_2) REFERENCES sensor(sensor_id);

CREATE TABLE ampconnect (
  amp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  amp_name VARCHAR(30),
  amp_room_id INT UNSIGNED,
  amp_status ENUM('scheduled','on','off'),
  amp_color VARCHAR(20),
  amp_time_on TIME,
  amp_time_off TIME,
  PRIMARY KEY (amp_id)
);
ALTER TABLE ampconnect
ADD FOREIGN KEY (amp_room_id) REFERENCES room(room_id);

CREATE TABLE datamp (
  datamp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  datamp_amp_id INT UNSIGNED,
  datamp_action ENUM('allumer','éteindre'),
  datamp_datetime DATETIME,
  PRIMARY KEY (datamp_id)
);
ALTER TABLE datamp
ADD FOREIGN KEY (datamp_amp_id) REFERENCES ampconnect(amp_id);

CREATE TABLE caminstall (
  cam_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  cam_name VARCHAR(30),
  cam_room_id INT UNSIGNED,
  cam_status ENUM('on','off'),
  cam_dist VARCHAR(10),
  cam_time_begin DATE,
  cam_time_end DATE,
  PRIMARY KEY (cam_id)
);
ALTER TABLE caminstall
ADD FOREIGN KEY (cam_room_id) REFERENCES room(room_id);

CREATE TABLE photo (
  photo_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  photo_cam_id INT UNSIGNED,
  photo_date DATETIME,
  photo_image VARCHAR(50),
  PRIMARY KEY (photo_id)
);
ALTER TABLE photo
ADD FOREIGN KEY (photo_cam_id) REFERENCES caminstall(cam_id);

#Exercice 4
INSERT INTO personal_user
VALUES (1, 'Lai', 'Jimmy', 'jimmyl@projet.com', '0612131415', '100 boulevard du projet', '12345', 'admin', 'ascrgn91'),
      (2, 'Nicod', 'Clément', 'clementn@projet.com', '0616171819', '102 boulevard du projet', '12345', 'admin', 'azsxft56'),
      (3, 'Yao', 'Emmanuel', 'yao@projet.com', '0707070707', '102 boulevard du projet', '12345', 'normal', 'azerty123'),
      (4, 'Moi', 'Boo', 'moiboo@projet.com', '0708070707', '102 boulevard du projet', '12345', 'normal', 'AZERTY'),
      (5, 'Toi', 'Role', 'rolet@projet.com', '0709070707', '102 boulevard du projet', '12345', 'normal', 'QWXscdaze'),
      (6, 'Zut', 'Wawawa', 'wawawa@projet.com', '0606060606', '100 boulevard du projet', '12345', 'normal', '264ZEdc5'),
      (7, 'Rin', 'Blabla', 'rinbla@projet.com', '0607060606', '100 boulevard du projet', '12345', 'normal', 'star123'),
      (8, 'San', 'Min', 'minsan@projet.com', '0608060606', '100 boulevard du projet', '12345', 'normal', 'nyaa98')

#Exercice 5
INSERT INTO room
VALUES (1, 'cuisine 1', '3', 'Réservé aux femmes'),
      (2, 'salon 1', '2', 'flemmard devant la TV'),
      (3, 'chambre 1', '4', 'salle pour dormir (et plus si affinité)'),
      (4, 'salle de bain 1', '5', 'lavez-vous'),
      (5, 'cuisine 2', '7', 'préparer de la bonne nourriture'),
      (6, 'salon 2', '1', 'devant un écran'),
      (7, 'chambre 2', '8', 'salle pour dormir (et plus si affinité)'),
      (8, 'salle de bain 2', '6', 'restez propre'),
      (9, 'cave à vin', '1', 'conservation du vin'),
      (10, 'chambre froide', '7', 'réserve de provision')

#Exercice 6
INSERT INTO food
VALUES  (1, '1', "Pâte", '2020-11-21 10:30:00', '4'),
       (2, '1', "Canard", '2019-11-23 05:20:00', '2'),
       (3, '5', "Riz", '2020-05-15 21:50:00', '2'),
       (4, '1', "Dinde", '2019-11-25 10:46:00', '9'),
       (5, '10', "Jambon", '2019-11-27 18:56:00', '2'),
       (6, '1', "Tomate", '2019-11-22 13:35:00', '4'),
       (7, '5', "Salade", '2019-11-22 12:30:00', '6'),
       (8, '1', "Oignon", '2019-11-30 20:00:00', '2'),
       (9, '2', "Pomme", '2019-11-27 00:00:00', '5'),
       (10, '5', "Flocon D'avoine", '2020-01-13 09:10:00', '1'),
       (11, '1', "Yaourt", '2019-11-25 14:13:00', '6'),
       (12, '1', "Citron", '2019-12-21 15:00:00', '2'),
       (13, '5', "Pizza", '2020-05-07 17:00:00', '3'),
       (14, '1', "Flan", '2019-11-30 19:34:00', '6'),
       (15, '1', "comcombre", '2019-12-02 20:00:00', '3'),
       (16, '5', "Mozzarela", '2019-11-29 23:00:00', '1'),
       (17, '1', "oeuf", '2019-12-10 17:00:00', '15'),
       (18, '5', "Lait", '2019-12-02 15:00:00', '1'),
       (19, '6', "Jus", '2019-12-25 13:00:00', '2'),
       (20, '5', "Crème anglaise", '2020-02-19 11:00:00', '1'),
       (21, '9', "Vin", '2023-01-23 03:00:00', '3'),
       (22, '1', "Cordon bleu", '2019-12-18 02:00:00', '4'),
       (23, '10', "Poulet", '2019-11-28 06:00:00', '2'),
       (24, '10', "Steack", '2019-11-25 09:00:00', '5'),
       (25, '2', "Raisin", '2019-11-27 10:00:00', '2')


#Exercice 7
INSERT INTO sensor
VALUES(1, 'capteur cuisine - pièce', '1', 'on', '3600', '15', '40'),
     (2, 'capture cuisine - frigo', '1', 'off', '3600', '0', '7'),
     (3, 'capteur cuisine - hotte', '1', 'on', '3600', '15', '90'),
     (4, 'capteur salon - pièce', '2', 'off', '3600', '15', '35'),
     (5, 'capteur salon - fenêtre', '2', 'on', '3600', '10', '40'),
     (6, 'capteur salon - pièce', '2', 'on', '3600', '15', '35'),
     (7, 'capteur chambre - pièce', '3', 'off', '3600', '15', '35'),
     (8, 'capteur chambre - fenêtre', '3', 'on', '3600', '10', '40'),
     (9, 'capteur chambre - pièce', '3', 'on', '3600', '15', '35'),
     (10, 'capteur salle de bain - pièce', '4', 'on', '3600', '15', '50'),
     (11, 'capteur salle de bain - eau douche/bain', '4', 'off', '3600', '10', '45'),
     (12, 'capteur salle de bain - eau lavabo', '4', 'on', '3600', '3', '25'),
     (13, 'capteur cuisine - hotte', '5', 'on', '3600', '15', '90'),
     (14, 'capture cuisine - frigo', '5', 'on', '3600', '0', '12'),
     (15, 'capteur salon - pièce', '6', 'off', '3600', '15', '35'),
     (16, 'capteur salon - fenêtre', '6', 'off', '3600', '10', '40'),
     (17, 'capteur chambre - pièce', '7', 'off', '3600','15', '35'),
     (18, 'capteur chambre - fenêtre', '7', 'on', '3600', '10', '40'),
     (19, 'capteur salle de bain - pièce', '8', 'on', '3600', '15', '50'),
     (20, 'capteur salle de bain - eau douche/bain', '8', 'off', '3600', '10', '45'),
     (21, 'capteur cave à vin - entrée pièce', '9', 'on', '3600','10', '14'),
     (22, 'capteur cave à vin - fond pièce', '9', 'off', '3600', '10', '14'),
     (23, 'capteur chambre froide - positif', '10', 'off', '3600', '0', '4'),
     (24, 'capteur chambre froide - négatif', '10', 'on', '3600', '-30', '-18')

#Exercice 8
INSERT INTO datatemp
VALUES (1, '1', '17', '2019-11-15 10:00:00'),
      (2, '1', '17', '2019-11-15 11:00:00'),
      (3, '1', '23', '2019-11-15 12:00:00'),
      (4, '1', '25', '2019-11-15 13:00:00'),
      (5, '1', '21', '2019-11-15 14:00:00'),
      (6, '2', NULL, NULL),
      (7, '2', NULL, NULL),
      (8, '2', NULL, NULL),
      (9, '2', NULL, NULL),
      (10, '2', NULL, NULL),
      (11, '3', '18', '2019-11-15 10:00:00'),
      (12, '3', '27', '2019-11-15 11:00:00'),
      (13, '3', '37', '2019-11-15 12:00:00'),
      (14, '3', '23', '2019-11-15 13:00:00'),
      (15, '3', '20', '2019-11-15 14:00:00'),
      (16, '4', NULL, NULL),
      (17, '4', NULL, NULL),
      (18, '4', NULL, NULL),
      (19, '4', NULL, NULL),
      (20, '4', NULL, NULL),
      (21, '5', '14', '2019-11-15 10:00:00'),
      (22, '5', '13', '2019-11-15 11:00:00'),
      (23, '5', '13', '2019-11-15 12:00:00'),
      (24, '5', '15', '2019-11-15 13:00:00'),
      (25, '5', '14', '2019-11-15 14:00:00'),
      (26, '6', '18', '2019-11-15 10:00:00'),
      (27, '6', '18', '2019-11-15 11:00:00'),
      (28, '6', '19', '2019-11-15 12:00:00'),
      (29, '6', '20', '2019-11-15 13:00:00'),
      (30, '6', '20', '2019-11-15 14:00:00'),
      (31, '7', NULL, NULL),
      (32, '7', NULL, NULL),
      (33, '7', NULL, NULL),
      (34, '7', NULL, NULL),
      (35, '7', NULL, NULL),
      (36, '8', '14', '2019-11-15 10:00:00'),
      (37, '8', '13', '2019-11-15 11:00:00'),
      (38, '8', '13', '2019-11-15 12:00:00'),
      (39, '8', '15', '2019-11-15 13:00:00'),
      (40, '8', '16', '2019-11-15 14:00:00'),
      (41, '9', '18', '2019-11-15 10:00:00'),
      (42, '9', '18', '2019-11-15 11:00:00'),
      (43, '9', '19', '2019-11-15 12:00:00'),
      (44, '9', '20', '2019-11-15 13:00:00'),
      (45, '9', '20', '2019-11-15 14:00:00'),
      (46, '10', '16', '2019-11-15 10:00:00'),
      (47, '10', '16', '2019-11-15 11:00:00'),
      (48, '10', '17', '2019-11-15 12:00:00'),
      (49, '10', '16', '2019-11-15 13:00:00'),
      (50, '10', '15', '2019-11-15 14:00:00'),
      (51, '11', '0', '2019-11-15 10:00:00'),
      (52, '11', '0', '2019-11-15 11:00:00'),
      (53, '11', '0', '2019-11-15 12:00:00'),
      (54, '11', '0', '2019-11-15 13:00:00'),
      (55, '11', '0', '2019-11-15 14:00:00'),
      (56, '12', '4', '2019-11-15 10:00:00'),
      (57, '12', '4', '2019-11-15 11:00:00'),
      (58, '12', '10', '2019-11-15 12:00:00'),
      (59, '12', '8', '2019-11-15 13:00:00'),
      (60, '12', '4', '2019-11-15 14:00:00'),
      (61, '13', '16', '2019-11-15 10:00:00'),
      (62, '13', '16', '2019-11-15 11:00:00'),
      (63, '13', '407', '2019-11-15 12:00:00'),
      (64, '14', '17', '2019-11-15 10:00:00'),
      (65, '14', '18', '2019-11-15 11:00:00'),
      (66, '14', '30', '2019-11-15 12:00:00'),
      (67, '15', NULL, NULL),
      (68, '15', NULL, NULL),
      (69, '15', NULL, NULL),
      (70, '16', NULL, NULL),
      (71, '16', NULL, NULL),
      (72, '16', NULL, NULL),
      (73, '17', NULL, NULL),
      (74, '17', NULL, NULL),
      (75, '17', NULL, NULL),
      (76, '18', '17', '2019-11-15 10:00:00'),
      (77, '18', '18', '2019-11-15 11:00:00'),
      (78, '18', '25', '2019-11-15 12:00:00'),
      (79, '19', '15', '2019-11-15 10:00:00'),
      (80, '19', '16', '2019-11-15 11:00:00'),
      (81, '19', '20', '2019-11-15 12:00:00'),
      (82, '20', NULL, NULL),
      (83, '20', NULL, NULL),
      (84, '20', NULL, NULL),
      (85, '21', '11', '2019-11-15 10:00:00'),
      (86, '21', '12', '2019-11-15 11:00:00'),
      (87, '21', '13', '2019-11-15 12:00:00'),
      (88, '22', NULL, NULL),
      (89, '22', NULL, NULL),
      (90, '22', NULL, NULL),
      (91, '23', NULL, NULL),
      (92, '23', NULL, NULL),
      (93, '23', NULL, NULL),
      (94, '24', '-25', '2019-11-15 10:00:00'),
      (95, '24', '-25', '2019-11-15 11:00:00'),
      (96, '24', '-23', '2019-11-15 12:00:00')

#Exercice 9
INSERT INTO ampconnect
VALUES(1, 'ampoule cuisine', '1', 'on', 'white', '19:30:00', '21:30:00'),
     (2, 'ampoule salon 1', '2', 'on', 'warm_white', '19:30:00', '00:00:00'),
     (3, 'ampoule chambre', '3', 'on', 'warm_white', '21:00:00', '23:30:00'),
     (4, 'ampoule salle de bain', '4', 'scheduled', 'white', '22:00:00', '23:30:00'),
     (5, 'ampoule salon 2', '2', 'off', 'warm_white', '08:00:00', '10:00:00'),
     (6, 'lumière cuisine', '5', 'on', 'warm_white', '20:30:00', '22:00:00'),
     (7, 'lumière salon', '6', 'scheduled', 'warm_white', '19:30:00', '00:00:00'),
     (8, 'lumière chambre', '7', 'off', 'white', '21:30:00', '23:00:00'),
     (9, 'lumière salle de bain', '8', 'on', 'white', '22:30:00', '00:00:00')

#Exercice 10
INSERT INTO datamp
VALUES (1, '1', 'allumer', '2019-11-18 19:30:00'),
      (2, '1', 'éteindre', '2019-11-18 21:30:00'),
      (3, '1', 'allumer', '2019-11-19 19:30:00'),
      (4, '2', 'éteindre', '2019-11-18 00:00:00'),
      (5, '2', 'allumer', '2019-11-19 19:30:00'),
      (6, '2', 'éteindre', '2019-11-19 00:00:00'),
      (7, '3', 'éteindre', '2019-11-18 23:30:00'),
      (8, '3', 'allumer', '2019-11-19 21:00:00'),
      (9, '3', 'éteindre', '2019-11-19 23:30:00'),
      (10, '4', 'éteindre', '2019-11-18 23:30:00'),
      (11, '4', 'allumer', '2019-11-19 22:00:00'),
      (12, '4', 'éteindre', '2019-11-19 23:30:00'),
      (13, '5', NULL, NULL),
      (14, '5', NULL, NULL),
      (15, '5', NULL, NULL),
      (16, '6', 'allumer', '2019-11-18 20:30:00'),
      (17, '6', 'éteindre', '2019-11-18 22:00:00'),
      (18, '6', 'allumer', '2019-11-19 20:30:00'),
      (19, '6', 'éteindre', '2019-11-19 22:00:00'),
      (20, '7', NULL, NULL),
      (21, '7', NULL, NULL),
      (22, '7', NULL, NULL),
      (23, '7', NULL, NULL),
      (24, '8', 'allumer', '2019-11-18 21:30:00'),
      (25, '8', 'éteindre', '2019-11-18 23:00:00'),
      (26, '8', 'allumer', '2019-11-19 21:30:00'),
      (27, '8', 'éteindre', '2019-11-19 23:00:00'),
      (28, '9', 'allumer', '2019-11-18 22:30:00'),
      (29, '9', 'éteindre', '2019-11-18 00:00:00'),
      (30, '9', 'allumer', '2019-11-19 22:30:00'),
      (31, '9', 'éteindre', '2019-11-19 00:00:00')

#Exercice 11
INSERT INTO caminstall
VALUES(1, 'caméra salon', '2', 'off', '10', '2019-12-23', '2020-01-03'),
     (2, 'camera cuisine 1', '1', 'on', '5', '2019-12-23', '2020-01-03'),
       (3, 'caméra cuisine 2', '5', 'off', '5', '2019-12-23', '2020-01-03'),
       (4, 'caméra salon', '6', 'on', '10', '2019-12-23', '2020-01-03'),
       (5, 'caméra cave', '9', 'off', '5', '2019-12-23', '2020-01-03'),
       (6, 'caméra entrée chambre froide', '10', 'on', '5', '2019-12-23', '2020-01-03')

#Exercice 12
INSERT INTO photo
VALUES(1, '1', '2019-11-20 00:00:00','C:\User\Moi\Image'),
     (2, '1', '2019-11-23 00:00:00','C:\User\Moi\Image'),
     (3, '1', '2019-11-25 00:00:00','C:\User\Moi\Image'),
     (4, '1', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (5, '2', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (6, '2', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (7, '2', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (8, '2', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (9, '3', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (10, '3', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (11, '3', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (12, '3', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (13, '3', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (14, '4', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (15, '4', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (16, '4', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (17, '4', '2019-12-30 00:00:00','C:\User\Moi\Image'),
     (18, '4', '2019-12-30 00:00:00','C:\User\Moi\Image')

#Exercice 13
SELECT user_id, user_mail, user_password
FROM personal_user
WHERE 'jimmyl@projet.com' = personal_user.user_mail AND 'ascrgn91' = personal_user.user_password;

#Exercice 14
SELECT room_name, room_description
FROM room
WHERE room_user_id = 1
ORDER BY room_name ASC;

#Exercice 15
SELECT food_name, food_perempt
FROM food
WHERE food_perempt BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 10 DAY) AND food_room_id = 1
ORDER BY food_perempt ASC;

#Exercice 16
SELECT sensor_name, room_name, sensor_status, sensor_temp_min, sensor_temp_max, sensor_interval
FROM sensor as S
RIGHT JOIN room as R
ON S.sensor_room_id = R.room_id
WHERE R.room_id = 1
ORDER BY room_name, sensor_name ASC;

#Exercice 17
SELECT room_name, sensor_name, datatemp_temp, datatemp_time
FROM room as R
LEFT JOIN sensor as S
ON R.room_id = S.sensor_room_id
LEFT JOIN datatemp as D
ON D.datatemp_sensor_id = S.sensor_id
WHERE R.room_id = 1
ORDER BY room_name, sensor_name, datatemp_time ASC;

#Exercice 18
SELECT room_name, sensor_name, datatemp_time, datatemp_temp
FROM room as R
LEFT JOIN sensor as S
ON R.room_id = S.sensor_room_id
LEFT JOIN datatemp as D
ON D.datatemp_sensor_id = S.sensor_id
WHERE room_name = 'cuisine' AND datatemp_temp IS NOT NULL
ORDER BY datatemp_temp ASC LIMIT 1;

#Exercice 19
SELECT amp_name, amp_color, room_name
FROM ampconnect as A
LEFT JOIN room as R
ON A.amp_room_id = R.room_id
WHERE amp_status = 'on'
ORDER BY room_name;

#Exercice 20
SELECT room_name, amp_name, AVG(datamp_action) as moy
FROM ampconnect as A
LEFT JOIN room as R
ON A.amp_room_id = R.room_id
LEFT JOIN datamp as D
ON D.datamp_amp_id = A.amp_id
WHERE R.room_id = 1
GROUP BY amp_name
ORDER BY moy ASC;

#Exercice 21
SELECT amp_name, amp_time_off, datamp_datetime, amp_status, (SELECT TIMEDIFF(amp_time_off, CAST(datamp_datetime AS TIME))) as durée_allumage
FROM ampconnect as A
LEFT JOIN datamp as D
 ON A.amp_id=D.datamp_amp_id
LEFT JOIN room as R
 ON D.datamp_amp_id=R.room_id
WHERE room_id = 1 AND datamp_action = 'allumer'
GROUP BY amp_name, amp_time_off, datamp_datetime, amp_status ASC;

#Exercice 22
SELECT *
FROM caminstall
WHERE cam_name = 'caméra salon';

#Exercice 23
SELECT *
FROM photo as P
LEFT JOIN caminstall as C
ON C.cam_id = P.photo_cam_id
WHERE C.cam_id = 1 AND photo_date BETWEEN '2019-12-23 00:00:00' AND '2019-12-30 00:00:00';

#Exercice 24
SELECT DISTINCT room_name, sensor_name, (SELECT COUNT(A.sensor_id) FROM sensor as A LEFT JOIN room as B ON A.sensor_room_id = B.room_id WHERE B.room_user_id = P.user_id GROUP BY room_id LIMIT 1) as sensor_number,
      (SELECT COUNT(D.datatemp_id) FROM datatemp as D LEFT JOIN sensor as E ON D.datatemp_sensor_id = E.sensor_id LEFT JOIN room as F ON F.room_user_id = E.sensor_room_id WHERE F.room_user_id = P.user_id AND datatemp_temp IS NOT NULL GROUP BY room_id LIMIT 1) as acqui_sens,
      (SELECT COUNT(H.amp_status) FROM ampconnect as H LEFT JOIN room as I ON H.amp_room_id = I.room_id WHERE I.room_user_id = P.user_id GROUP BY room_id LIMIT 1) as amp_number,
      (SELECT COUNT(K.datamp_action) FROM datamp as K LEFT JOIN ampconnect as L ON K.datamp_amp_id = L.amp_id LEFT JOIN room as M ON L.amp_room_id = M.room_id WHERE M.room_user_id = P.user_id AND K.datamp_action = 'allumer' GROUP BY room_id LIMIT 1) as all_number,
      (SELECT COUNT(X.datamp_action) FROM datamp as X LEFT JOIN ampconnect as Y ON X.datamp_amp_id = Y.amp_id LEFT JOIN room as Z ON Y.amp_room_id = Z.room_id WHERE Z.room_user_id = P.user_id AND X.datamp_action = 'éteindre' GROUP BY room_id LIMIT 1) as ete_number,
      (SELECT COUNT(F.food_id) FROM food as F LEFT JOIN room as T ON T.room_id = F.food_room_id WHERE T.room_user_id = P.user_id GROUP BY room_id LIMIT 1) as food_number
FROM personal_user as P
LEFT JOIN room as R ON R.room_user_id = P.user_id
LEFT JOIN sensor as S ON S.sensor_room_id = R.room_id
WHERE user_id = 3
ORDER BY room_name, sensor_name;


#Exercice 25
INSERT INTO thermointel
VALUES(1, 1, 'thermo cuisine 1', 1, 3, 24, 'inactif'),
     (2, 2, 'thermo salon 1', 4, 6, 24, 'chaud'),
     (3, 3, 'thermo chambre 1', 7, 9, 24, 'chaud'),
     (4, 4, 'thermo salle de bain 1', 10, NULL, 24, 'inactif'),
     (5, 5, 'thermos cuisine 2', 13, NULL, 24, 'chaud'),
     (6, 6, 'thermos salon 2', 15, NULL, 24, 'inactif'),
     (7, 7, 'thermos chambre 2', 17, NULL, 24, 'froid'),
     (8, 8, 'thermos salle de bain 2', 19, NULL, 24, 'chaud'),
     (9, 9, 'thermos cave', 21, 22, 12, 'inactif'),
     (10, 10, 'thermos chambre froide', 23, 24, -5, 'froid')

#Exercice 26
SELECT A.cam_id,cam_name, COUNT(A.photo_date) as nbr_photo
FROM
(SELECT C.cam_id, cam_name, photo_date
FROM caminstall as C
LEFT JOIN photo as P
 ON C.cam_id=P.photo_id
WHERE photo_date >= '2019-11-12 00:00:00' AND photo_date <= NOW()
GROUP BY cam_id) as A
GROUP BY cam_id;

#Exercice 27
SET @temp_moy = (SELECT (AVG(thermo_id_1)+ AVG(thermo_id_2))/2 FROM thermointel);
SET @lasttime = (SELECT (MAX(datatemp_time))FROM datatemp);
SELECT thermo_name, thermo_temp_target, thermo_status, @lasttime, (
    SELECT datatemp_temp
    FROM datatemp as D
    LEFT JOIN sensor as S
    	ON D.datatemp_sensor_id = S.sensor_id
    WHERE S.sensor_id = T.thermo_id_1
    ORDER BY datatemp_time DESC LIMIT 1
) as capteur1, (
    SELECT datatemp_temp
    FROM datatemp as D
    LEFT JOIN sensor as S
    	ON D.datatemp_sensor_id = S.sensor_id
    WHERE S.sensor_id = T.thermo_id_2
    ORDER BY datatemp_time DESC LIMIT 1
) as capteur2,
(SELECT sensor_name FROM sensor as S WHERE S.sensor_id = T.thermo_id_1) as nom_1,
(SELECT sensor_name FROM sensor as S WHERE S.sensor_id = T.thermo_id_2) as nom_2
FROM thermointel as T
LEFT JOIN sensor as S
 ON T.thermo_name=S.sensor_name
LEFT JOIN datatemp as D
 ON S.sensor_id=D.datatemp_sensor_id
WHERE thermo_temp_target!=@temp_moy
ORDER BY @lasttime;

#Exercice 28
SET @test = ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 1) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 1))/2;
SELECT thermo_name, thermo_temp_target, ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 1) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 1))/2 as moy1,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 2) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 2))/2) as diff2,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 3) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 3))/2) as diff3,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 4) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 4))/2) as diff4,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 5) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 5))/2) as diff5,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 6) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 6))/2) as diff6,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 7) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 7))/2) as diff7,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 8) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 8))/2) as diff8,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 9) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 9))/2) as diff9,
(@test - ((SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_1 AND datatemp_temp IS NOT NULL AND thermo_id = 10) + (SELECT AVG(datatemp_temp) FROM datatemp LEFT JOIN sensor ON datatemp.datatemp_sensor_id = sensor.sensor_id RIGHT JOIN thermointel ON sensor.sensor_id = thermointel.thermo_id WHERE thermo_id_2 AND datatemp_temp IS NOT NULL AND thermo_id = 10))/2) as diff10
FROM thermointel
WHERE thermo_id = 1;

#Exercice 29
SELECT room_id, room_name, COUNT(sensor_id), AVG(datatemp_temp)
FROM room as R
LEFT JOIN sensor as S
ON S.sensor_room_id = R.room_id
LEFT JOIN datatemp as D
ON D.datatemp_sensor_id = S.sensor_id
WHERE datatemp_time <= DATE_ADD(NOW(), INTERVAL -7 DAY)
GROUP BY room_id;

#Exercice 30
SELECT food_name, food_perempt, DATEDIFF(food_perempt, NOW()) as rest
FROM food
ORDER BY rest DESC;

#Exercice 31
ALTER TABLE food
ADD food_open DATETIME
UPDATE food
SET food_open = '2019-11-21 00:00:00' WHERE food_id = 1
SET food_open = '2019-11-21 00:00:00' WHERE food_id = 2
SET food_open = '2019-11-21 02:00:00' WHERE food_id = 3
SET food_open = '2019-11-21 02:00:00' WHERE food_id = 4
SET food_open = '2019-11-21 03:00:00' WHERE food_id = 5
SET food_open = '2019-11-21 03:00:00' WHERE food_id = 6
SET food_open = '2019-11-21 03:00:00' WHERE food_id = 7
SET food_open = '2019-11-21 07:00:00' WHERE food_id = 8
SET food_open = '2019-11-21 07:00:00' WHERE food_id = 9
SET food_open = '2019-11-21 08:00:00' WHERE food_id = 10
SET food_open = '2019-11-21 08:00:00' WHERE food_id = 11
SET food_open = '2019-11-21 08:00:00' WHERE food_id = 12
SET food_open = '2019-11-21 09:00:00' WHERE food_id = 13
SET food_open = '2019-11-21 09:00:00' WHERE food_id = 14
SET food_open = '2019-11-21 10:00:00' WHERE food_id = 15
SET food_open = '2019-11-21 10:00:00' WHERE food_id = 16
SET food_open = '2019-11-21 11:00:00' WHERE food_id = 17
SET food_open = '2019-11-21 12:00:00' WHERE food_id = 18
SET food_open = '2019-11-21 12:00:00' WHERE food_id = 19
SET food_open = '2019-11-21 12:00:00' WHERE food_id = 20
SET food_open = '2019-11-21 12:00:00' WHERE food_id = 21
SET food_open = '2019-11-21 13:00:00' WHERE food_id = 22
SET food_open = '2019-11-21 14:00:00' WHERE food_id = 23
SET food_open = '2019-11-21 16:00:00' WHERE food_id = 24
SET food_open = '2019-11-21 17:00:00' WHERE food_id = 25

ALTER TABLE food
ADD food_perempt_open DATETIME
UPDATE food
SET food_perempt_open = '2020-11-21' WHERE food_id = 1
SET food_perempt_open = '2019-11-23' WHERE food_id = 2
SET food_perempt_open = '2020-03-29' WHERE food_id = 3
SET food_perempt_open = '2019-11-23' WHERE food_id = 4
SET food_perempt_open = '2019-11-25' WHERE food_id = 5
SET food_perempt_open = '2019-11-22' WHERE food_id = 6
SET food_perempt_open = '2019-11-22' WHERE food_id = 7
SET food_perempt_open = '2019-11-28' WHERE food_id = 8
SET food_perempt_open = '2019-11-24' WHERE food_id = 9
SET food_perempt_open = '2020-01-03' WHERE food_id = 10
SET food_perempt_open = '2019-11-22' WHERE food_id = 11
SET food_perempt_open = '2019-12-04' WHERE food_id = 12
SET food_perempt_open = '2020-01-13' WHERE food_id = 13
SET food_perempt_open = '2019-11-28' WHERE food_id = 14
SET food_perempt_open = '2019-11-29' WHERE food_id = 15
SET food_perempt_open = '2019-11-23' WHERE food_id = 16
SET food_perempt_open = '2019-12-10' WHERE food_id = 17
SET food_perempt_open = '2019-11-27' WHERE food_id = 18
SET food_perempt_open = '2019-12-20' WHERE food_id = 19
SET food_perempt_open = '2020-01-13' WHERE food_id = 20
SET food_perempt_open = '2023-01-23' WHERE food_id = 21
SET food_perempt_open = '2019-12-01' WHERE food_id = 22
SET food_perempt_open = '2019-11-27' WHERE food_id = 23
SET food_perempt_open = '2019-11-23' WHERE food_id = 24
SET food_perempt_open = '2019-11-25' WHERE food_id = 25

SELECT food_name, food_perempt, food_open, food_perempt_open, TIMEDIFF(food_perempt, food_perempt_open)
FROM food
WHERE food_perempt <= DATE_ADD(NOW(), INTERVAL -2 DAY) AND food_open < NOW()
ORDER BY DATEDIFF(food_perempt, food_open) ASC;

#Exercice 32
SELECT amp_id, amp_name, room_name, amp_color, (SELECT COUNT(datamp_action) WHERE datamp_action='allumer') as nombre_allumage
FROM datamp as D
LEFT JOIN ampconnect as A
ON A.amp_id = D.datamp_amp_id
LEFT JOIN room as R
ON R.room_id = A.amp_room_id
GROUP BY amp_id;

#Exercice 33


#Exercice 34
SELECT COUNT(food_id) as nombre, '2019-11-21 00:00:00' as DEBUT, '2019-11-21 01:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 00:00:00' AND '2019-11-21 01:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 02:00:00' as DEBUT, '2019-11-21 03:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 02:00:00' AND '2019-11-21 03:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 04:00:00' as DEBUT, '2019-11-21 05:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 04:00:00' AND '2019-11-21 05:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 06:00:00' as DEBUT, '2019-11-21 07:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 06:00:00' AND '2019-11-21 07:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 08:00:00' as DEBUT, '2019-11-21 09:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 08:00:00' AND '2019-11-21 09:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 10:00:00' as DEBUT, '2019-11-21 11:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 10:00:00' AND '2019-11-21 11:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 12:00:00' as DEBUT, '2019-11-21 13:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 12:00:00' AND '2019-11-21 13:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 14:00:00' as DEBUT, '2019-11-21 15:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 14:00:00' AND '2019-11-21 15:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 16:00:00' as DEBUT, '2019-11-21 17:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 16:00:00' AND '2019-11-21 17:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 18:00:00' as DEBUT, '2019-11-21 19:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 18:00:00' AND '2019-11-21 19:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 20:00:00' as DEBUT, '2019-11-21 21:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 20:00:00' AND '2019-11-21 21:59:59'
UNION
SELECT COUNT(food_id) as nombre, '2019-11-21 22:00:00' as DEBUT, '2019-11-21 23:59:59' as FIN
FROM food
WHERE food_open BETWEEN '2019-11-21 22:00:00' AND '2019-11-21 23:59:59'
ORDER BY nombre DESC LIMIT 1;











#ESSAIE 34
SET @debut = '2019-11-21 00:00:00';
SET @fin = '2019-11-22 00:00:00';
SELECT COUNT(food_id), '2019-11-21 00:00:00' as DEBUT, '2019-11-21 23:59:59' as FIN, food_open
FROM food
WHERE @fin >= DATE_ADD(@debut, INTERVAL 2 HOUR);

SELECT COUNT(food_id), temps
FROM (SELECT *, CASE WHEN food_open BETWEEN '2019-11-21 00:00:00' AND '2019-11-21 01:59:59'
                    WHEN food_open BETWEEN '2019-11-21 02:00:00' AND '2019-11-21 03:59:59'
                    WHEN food_open BETWEEN '2019-11-21 04:00:00' AND '2019-11-21 05:59:59'
                    WHEN food_open BETWEEN '2019-11-21 06:00:00' AND '2019-11-21 07:59:59'
                    WHEN food_open BETWEEN '2019-11-21 08:00:00' AND '2019-11-21 09:59:59'
                    WHEN food_open BETWEEN '2019-11-21 10:00:00' AND '2019-11-21 11:59:59'
                    WHEN food_open BETWEEN '2019-11-21 12:00:00' AND '2019-11-21 13:59:59'
                    WHEN food_open BETWEEN '2019-11-21 14:00:00' AND '2019-11-21 15:59:59'
                    WHEN food_open BETWEEN '2019-11-21 16:00:00' AND '2019-11-21 17:59:59'
                    WHEN food_open BETWEEN '2019-11-21 18:00:00' AND '2019-11-21 19:59:59'
                    WHEN food_open BETWEEN '2019-11-21 20:00:00' AND '2019-11-21 21:59:59'
                    WHEN food_open BETWEEN '2019-11-21 22:00:00' AND '2019-11-21 23:59:59'
                    END AS temps
FROM food) as temps
GROUP BY temps;

#ESSAIE 32
SELECT amp_id, amp_name, room_name, amp_color, COUNT(datamp_action) as nombre_allumage, AVG(datamp_action) as moy_allumage
FROM datamp as D
LEFT JOIN ampconnect as A
ON A.amp_id = D.datamp_amp_id
LEFT JOIN room as R
ON R.room_id = A.amp_room_id
WHERE datamp_action = 'allumer'
GROUP BY amp_id;


#EXERCICE 32, 33
#Erreur 21 (plusieurs valeurs)
#Erreur 28 (NULL)
#34 (optimisé)

sudo mysql -u root
use mysql;
update user set plugin='' where User='root';
flush privileges;
exit;

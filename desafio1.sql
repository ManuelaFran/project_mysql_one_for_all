DROP DATABASE IF EXISTS SpotifyClone;

CREATE DATABASE IF NOT EXISTS SpotifyClone;

CREATE TABLE SpotifyClone.artist(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE SpotifyClone.album(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    album_name VARCHAR(100) NOT NULL,
    release_year YEAR NOT NULL,
    artist_id INT NOT NULL,
  FOREIGN KEY (artist_id) REFERENCES SpotifyClone.artist(id)
) ENGINE = InnoDB;

CREATE TABLE SpotifyClone.signature_plan(
	  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    plan_value DECIMAL(10,2) NOT NULL DEFAULT 0.00
) ENGINE = InnoDB;

CREATE TABLE SpotifyClone.users(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    signature_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    signature_plan_id INT NOT NULL,
  FOREIGN KEY (signature_plan_id) REFERENCES SpotifyClone.signature_plan(id)
) ENGINE = InnoDB;

CREATE TABLE SpotifyClone.following_artists(
	  artist_id INT NOT NULL,
    users_id INT NOT NULL,
  PRIMARY KEY (artist_id,users_id),
  FOREIGN KEY (artist_id) REFERENCES SpotifyClone.artist(id),
  FOREIGN KEY (users_id) REFERENCES SpotifyClone.users(id)
) ENGINE = InnoDB;

CREATE TABLE SpotifyClone.songs(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    song_name VARCHAR(100) NOT NULL,
    song_length_in_seconds INT NOT NULL,
    album_id INT NOT NULL,
  FOREIGN KEY (album_id) REFERENCES SpotifyClone.album(id)
) ENGINE = InnoDB;

CREATE TABLE SpotifyClone.playback_history(
	  songs_id INT NOT NULL,
    users_id INT NOT NULL,
    reproduction_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PRIMARY KEY (songs_id,users_id),
  FOREIGN KEY (songs_id) REFERENCES SpotifyClone.songs(id),
  FOREIGN KEY (users_id) REFERENCES SpotifyClone.users(id)
) ENGINE = InnoDB;

INSERT INTO SpotifyClone.artist (artist_name)
  VALUES ('Beyoncé'),
         ('Queen'),
         ('Elis Regina'),
         ('Baco Exu do Blues'),
         ('Blind Guardian'),
         ('Nina Simone');

INSERT INTO SpotifyClone.album (album_name, artist_id, release_year)
  VALUES ('Renaissance',1, '2022'),
         ('Jazz',2, '1978'),
         ('Hot Space',2, '1982'),
         ('Falso Brilhante',3, '1998'),
         ('Vento de Maio',3, '2001'),
         ('QVVJFA?',4, '2003'),
         ('Somewhere Far Beyond',5, '2007'),
         ('I Put A Spell On You',6, '2012');

INSERT INTO SpotifyClone.signature_plan (plan_name, plan_value)
  VALUES ('gratuito',0),
         ('familiar',7.99),
         ('universitário',5.99),
         ('pessoal',6.99);

INSERT INTO SpotifyClone.users (username, age, signature_plan_id, signature_date)
  VALUES ('Barbara Liskov',82, 1,'2019-10-20'),
         ('Robert Cecil Martin',58, 1,'2017-01-06'),
         ('Ada Lovelace',37, 2,'2017-12-30'),
         ('Martin Fowler',46, 2,'2017-01-17'),
         ('Sandi Metz',58, 2,'2018-04-29'),
         ('Paulo Freire',19, 3,'2018-02-14'),
         ('Bell Hooks',26, 3,'2018-01-05'),
         ('Christopher Alexander',85, 4,'2019-06-05'),
         ('Judith Butler',45, 4,'2020-05-13'),
         ('Jorge Amado',58, 4,'2017-02-17');

INSERT INTO SpotifyClone.following_artists (users_id, artist_id)
  VALUES (1, 1),
         (1, 2),
         (1, 3),
         (2, 1),
         (2, 3),
         (3, 2),
         (4, 4),
         (5, 5),
         (5, 6),
         (6, 6),
         (6, 1),
         (7, 6),
         (9, 3),
         (10, 2);

INSERT INTO SpotifyClone.songs (song_name, album_id, song_length_in_seconds)
  VALUES ('BREAK MY SOUL', 1 , 279),
         ('VIRGO’S GROOVE',1, 369),
         ('ALIEN SUPERSTAR',1, 116),
         ('Don’t Stop Me Now',2, 203),
         ('Under Pressure', 3 , 152),
         ('Como Nossos Pais',4, 105),
         ('O Medo de Amar é o Medo de Ser Livre',5, 207),
         ('Samba em Paris',6, 267),
         ('The Bard’s Song',7, 244),
         ('Feeling Good',8, 100);

INSERT INTO SpotifyClone.playback_history (users_id, songs_id, reproduction_date) 
  VALUES  (1, 8, "2022-02-28 10:45:55"),
          (1, 2, "2020-05-02 05:30:35"),
          (1, 10, "2020-03-06 11:22:33"),
          (2, 10, "2022-08-05 08:05:17"),
          (2, 7, "2020-01-02 07:40:33"),
          (3, 10, "2020-11-13 16:55:13"),
          (3, 2, "2020-12-05 18:38:30"),
          (4, 8, "2021-08-15 17:10:10"),
          (5, 8, "2022-01-09 01:44:33"),
          (5, 5, "2020-08-06 15:23:43"),
          (6, 7, "2017-01-24 00:31:17"),
          (6, 1, "2017-10-12 12:35:20"),
          (7, 4, "2011-12-15 22:30:49"),
          (8, 4, "2012-03-17 14:56:41"),
          (9, 9, "2022-02-24 21:14:22"),
          (10, 3, "2015-12-13 08:30:22");
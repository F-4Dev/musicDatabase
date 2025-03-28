DROP DATABASE IF EXISTS streamingdb;
CREATE DATABASE IF NOT EXISTS streamingdb;
USE streamingdb;

CREATE TABLE tbl_library (
    pk_id_library VARCHAR(255) NOT NULL,
    -- addd on delete ._.
    PRIMARY KEY (pk_id_library),
    pathToLibrary VARCHAR(255)
) ENGINE = InnoDB;

CREATE TABLE tbl_album (
    pk_album_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (pk_album_id),
    album_name VARCHAR(255) NOT NULL DEFAULT "unbekannt",
    fk_id_library VARCHAR(255) NOT NULL,
    FOREIGN KEY (fk_id_library) REFERENCES tbl_library (pk_id_library)
) ENGINE = InnoDB;

CREATE TABLE tbl_song (
    pk_song_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (pk_song_id),
    song_name VARCHAR(255),
    pathToSong VARCHAR(255),
    dateAdded DATE,
    fk_album_id INT NOT NULL,
    FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id)
) ENGINE = InnoDB;

CREATE TABLE tbl_artist (
    pk_artist_id INT NOT NULL AUTO_INCREMENT,
    artist_name VARCHAR(255),
    PRIMARY KEY (pk_artist_id)
) ENGINE = InnoDB;

CREATE TABLE tbl_artist_album (
    fk_song_id INT NOT NULL,
    FOREIGN KEY (fk_song_id) REFERENCES tbl_song (pk_song_id),
    fk_artist_id INT NOT NULL,
    FOREIGN KEY (fk_artist_id) REFERENCES tbl_artist (pk_artist_id),
    PRIMARY KEY (fk_song_id, fk_artist_id)
) ENGINE = InnoDB;

CREATE TABLE tbl_genre (
    pk_genre VARCHAR(255) NOT NULL,
    PRIMARY KEY (pk_genre)
) ENGINE = InnoDB;

CREATE TABLE tbl_album_genre (
    fk_album_id INT NOT NULL,
    FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id),
    fk_genre VARCHAR(255) NOT NULL,
    FOREIGN KEY (fk_genre) REFERENCES tbl_genre (pk_genre),
    PRIMARY KEY (fk_album_id, fk_genre)
) ENGINE = InnoDB;

CREATE TABLE tbl_user (
    pk_username VARCHAR(255) NOT NULL,
    PRIMARY KEY (pk_username)
) ENGINE = InnoDB;

CREATE TABLE tbl_album_favorite (
    fk_username VARCHAR(255) NOT NULL,
    FOREIGN KEY (fk_username) REFERENCES tbl_user (pk_username),
    fk_album_id INT NOT NULL,
    FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id),
    PRIMARY KEY (fk_username, fk_album_id)
) ENGINE = InnoDB;

CREATE TABLE tbl_song_userdata (
    fk_username VARCHAR(255) NOT NULL,
    FOREIGN KEY (fk_username) REFERENCES tbl_user (pk_username),
    fk_song_id INT NOT NULL,
    FOREIGN KEY (fk_song_id) REFERENCES tbl_song (pk_song_id),
    PRIMARY KEY (fk_username, fk_song_id)
) ENGINE = InnoDB;


-- DATA IMPORTS --
-- Import data into tbl_album
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_album.csv' INTO
TABLE tbl_album FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_song
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_song.csv' INTO
TABLE tbl_song FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_artist
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_artist.csv' INTO
TABLE tbl_artist FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_genre
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_genre.csv' INTO
TABLE tbl_genre FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_artist_album
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_artist_album.csv' INTO
TABLE tbl_artist_album FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_song_genre
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_album_genre.csv' INTO
TABLE tbl_album_genre FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_user
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_user.csv' INTO
TABLE tbl_user FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_album_favorite
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_album_favorite.csv' INTO
TABLE tbl_album_favorite FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Import data into tbl_song_userdata
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_song_userdata.csv' INTO
TABLE tbl_song_userdata FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;


-- USER MANAGEMENT --
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
INSERT INTO tbl_user (pk_username) VALUES ('username');
INSERT INTO tbl_song_userdata (fk_username, fk_song_id) VALUES ('username', 1);  -- Assuming song ID 1 is a favorite
INSERT INTO tbl_song_userdata (fk_username, fk_song_id) VALUES ('username', 2);  -- Assuming song ID 2 is another favorite


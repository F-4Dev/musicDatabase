DROP DATABASE IF EXISTS streamingdb;
CREATE DATABASE IF NOT EXISTS streamingdb;
USE streamingdb;

CREATE TABLE tbl_library (
    pk_id_library INT NOT NULL AUTO_INCREMENT,
    library_name VARCHAR(255) NOT NULL DEFAULT "unbekannt",
    PRIMARY KEY (pk_id_library),
    pathToLibrary VARCHAR(255)
) ENGINE = InnoDB;

CREATE TABLE tbl_album (
    pk_album_id INT NOT NULL AUTO_INCREMENT,
    album_name VARCHAR(255) NOT NULL DEFAULT "unbekannt",
    fk_id_library INT NOT NULL,
    PRIMARY KEY (pk_album_id),
    FOREIGN KEY (fk_id_library) REFERENCES tbl_library (pk_id_library) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE tbl_song (
    pk_song_id INT NOT NULL AUTO_INCREMENT,
    song_name VARCHAR(255) NOT NULL DEFAULT "unbekannt",
    pathToSong VARCHAR(255),
    dateAdded DATE,
    fk_album_id INT NOT NULL,
    PRIMARY KEY (pk_song_id),
    FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE tbl_artist (
    pk_artist_id INT NOT NULL AUTO_INCREMENT,
    artist_name VARCHAR(255) NOT NULL DEFAULT "unbekannter Kunstler",
    PRIMARY KEY (pk_artist_id)
) ENGINE = InnoDB;

CREATE TABLE tbl_artist_album (
    fk_album_id INT NOT NULL,
    fk_artist_id INT NOT NULL,
    PRIMARY KEY (fk_album_id, fk_artist_id),
    FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id) ON DELETE CASCADE,
    FOREIGN KEY (fk_artist_id) REFERENCES tbl_artist (pk_artist_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE tbl_genre (
    pk_genre VARCHAR(255) NOT NULL,
    PRIMARY KEY (pk_genre)
) ENGINE = InnoDB;

CREATE TABLE tbl_album_genre (
    fk_album_id INT NOT NULL,
    fk_genre VARCHAR(255) NOT NULL,
    PRIMARY KEY (fk_album_id, fk_genre),
    FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id) ON DELETE CASCADE,
    FOREIGN KEY (fk_genre) REFERENCES tbl_genre (pk_genre) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE tbl_user (
    pk_username VARCHAR(255) NOT NULL,
    PRIMARY KEY (pk_username)
) ENGINE = InnoDB;

CREATE TABLE tbl_album_favorite (
    fk_username VARCHAR(255) NOT NULL,
    fk_album_id INT NOT NULL,
    PRIMARY KEY (fk_username, fk_album_id),
    FOREIGN KEY (fk_username) REFERENCES tbl_user (pk_username) ON DELETE CASCADE,
    FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE tbl_song_userdata (
    fk_username VARCHAR(255) NOT NULL,
    fk_song_id INT NOT NULL,
    PRIMARY KEY (fk_username, fk_song_id),
    FOREIGN KEY (fk_username) REFERENCES tbl_user (pk_username) ON DELETE CASCADE,
    FOREIGN KEY (fk_song_id) REFERENCES tbl_song (pk_song_id) ON DELETE CASCADE
) ENGINE = InnoDB;

-- DATA IMPORTS --
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_library.csv' 
INTO TABLE tbl_library 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_album.csv' 
INTO TABLE tbl_album 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_song.csv' 
INTO TABLE tbl_song 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_artist.csv' 
INTO TABLE tbl_artist 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_artist_album.csv' 
INTO TABLE tbl_artist_album 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_genre.csv' 
INTO TABLE tbl_genre 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_album_genre.csv' 
INTO TABLE tbl_album_genre 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_user.csv' 
INTO TABLE tbl_user 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_album_favorite.csv' 
INTO TABLE tbl_album_favorite 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/f4/Documents/!Schule/DABA/musicDatabase/data/tbl_song_userdata.csv' 
INTO TABLE tbl_song_userdata 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES;

-- USER MANAGEMENT --
CREATE USER IF NOT EXISTS 'user1'@'localhost' IDENTIFIED BY 'psw1';
CREATE USER IF NOT EXISTS 'user2'@'localhost' IDENTIFIED BY 'psw2';
CREATE USER IF NOT EXISTS 'user3'@'localhost' IDENTIFIED BY 'psw2';

GRANT SELECT, INSERT, UPDATE, DELETE ON streamingdb.* TO 'user1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON streamingdb.* TO 'user2'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON streamingdb.* TO 'user3'@'localhost';

FLUSH PRIVILEGES;


-- ABGFRAGEN --
DROP VIEW IF EXISTS view_show_album_data;
CREATE VIEW view_show_album_data AS
    SELECT 
        tbl_album.album_name AS album,
        tbl_song.song_name AS song, 
        tbl_artist.artist_name AS artist 
    FROM 
        tbl_album 
    INNER JOIN 
        tbl_song ON tbl_album.pk_album_id = tbl_song.fk_album_id 
    INNER JOIN 
        tbl_artist_album ON tbl_album.pk_album_id = tbl_artist_album.fk_album_id 
    INNER JOIN 
        tbl_artist ON tbl_artist_album.fk_artist_id = tbl_artist.pk_artist_id;

-- TRIGGER --
CREATE TABLE tbl_log_song_duplicates (
    pk_log_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(pk_log_id),
    song_name VARCHAR(255),
    album_name VARCHAR(255),
    artist_name VARCHAR(255),
    verantwortlicher_benutzer VARCHAR(255),
    timestamp_insert TIMESTAMP
) ENGINE = InnoDB;

-- Dieser Trigger verhindert das einfuegen von Songs in ein Album, weleche den selben Namen
-- und den selben Artist haben, und fuegt die Daten in die eine log Tabelle ein.

DELIMITER //
-- erstelle einen Trigger, der vor dem einfuegen in die Tabelle tbl_song ausgefuehrt wird
CREATE TRIGGER trg_log_insertion_to_album
BEFORE INSERT 
ON tbl_song
FOR EACH ROW 
BEGIN
    -- ueberpruefe, ob ein Song mit dem gleichen namen und album-id bereits vorhanden ist
    IF (
        SELECT COUNT(*)
        FROM tbl_song
        WHERE song_name = NEW.song_name
        AND fk_album_id = NEW.fk_album_id
    ) > 0
    THEN
        -- wenn ein Duplikat gefunden wird, logge die Informationen in tbl_log_song_duplicates
        INSERT INTO tbl_log_song_duplicates (song_name, album_name, artist_name, verantwortlicher_benutzer, timestamp_insert)
        VALUES (
            NEW.song_name,  -- Name des neuen Songs
            (SELECT album_name FROM tbl_album WHERE pk_album_id = NEW.fk_album_id),  -- Albumname basierend auf der Album-ID
            (SELECT artist_name FROM tbl_artist 
             INNER JOIN tbl_artist_album ON tbl_artist.pk_artist_id = tbl_artist_album.fk_artist_id
             WHERE tbl_artist_album.fk_album_id = NEW.fk_album_id
             LIMIT 1),  -- kuenstlername des ersten Kuenstlers, der mit dem Album verknuepft ist
            CURRENT_USER(),  -- der Benutzer, der die Einfuegung vornimmt
            NOW()  -- aktueller zeitpunkt mit datum und uhrzeit
        );
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_remove_duplicates
AFTER INSERT 
ON tbl_song
FOR EACH ROW 
BEGIN
    -- Check if a song with the same name and album ID already exists
    IF (
        SELECT COUNT(*)
        FROM tbl_song
        WHERE song_name = NEW.song_name
        AND fk_album_id = NEW.fk_album_id
    ) > 0 THEN
        -- Delete the existing song with the same name and album ID
        DELETE FROM tbl_song 
        WHERE song_name = NEW.song_name
        AND fk_album_id = NEW.fk_album_id;
    END IF;
END //

DELIMITER ;


-- teste einfuegen von song mit gleichem namen
INSERT INTO tbl_song(song_name,pathToSong,dateAdded,fk_album_id)
VALUES ('Song zehn','/music/song1.mp3','2023-01-05',1);


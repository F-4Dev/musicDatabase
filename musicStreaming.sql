DROP DATABASE IF EXISTS 'streamingdb'
CREATE DATABASE IF NOT EXISTS 'streamingdb'
USE 'streamingdb'

CREATE TABLE tbl_library (
    pk_id_library VARCHAR(255) NOT NULL, -- addd on delete ._.
        PRIMARY KEY(pk_id_library),
    pathToLibrary VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE tbl_album (
    pk_album_id INT NOT NULL AUTO_INCREMENT,
        PRIMARY KEY(pk_album_id),
    album_name VARCHAR(255) NOT NULL DEFAULT unbekannt,
    fk_id_library VARCHAR(255) NOT NULL,
        FOREIGN KEY(fk_id_library) REFERENCES tbl_library(pk_id_library)
) ENGINE=InnoDB;

CREATE TABLE tbl_song (
    pk_song_id INT NOT NULL AUTO_INCREMENT,
        PRIMARY KEY(pk_song_id),
    song_name VARCHAR(255),
    pathToSong VARCHAR(255),
    dateAdded DATE,
    fk_album_id INT NOT NULL,
        FOREIGN KEY(fk_album_id) REFERENCES tbl_album(pk_album_id)
) ENGINE=InnoDB;

CREATE TABLE tbl_artist (
    pk_artist_id INT NOT NULL AUTO_INCREMENT,
    artist_name VARCHAR(255),
        PRIMARY KEY(pk_artist_id)
) ENGINE=InnoDB;

CREATE TABLE tbl_artist_album (
    fk_song_id INT NOT NULL,
        PRIMARY KEY(fk_song_id),
        FOREIGN KEY(fk_song_id) REFERENCES tbl_song(pk_song_id),
    fk_artist_id INT NOT NULL,
        PRIMARY KEY(fk_artist_id),
        FOREIGN KEY(fk_artist_id) REFERENCES tbl_artist(pk_artist_id)
) ENGINE=InnoDB;

CREATE TABLE tbl_genre (
    pk_genre VARCHAR(255),
        PRIMARY KEY(pk_genre)
) ENGINE=InnoDB;

CREATE TABLE tbl_song_genre (
    fk_song_id INT NOT NULL,
        PRIMARY KEY(fk_song_id),
        FOREIGN KEY(fk_song_id) REFERENCES tbl_song(pk_song_id),
    fk_genre INT NOT NULL,
        PRIMARY KEY(fk_genre),
        FOREIGN KEY(fk_genre) REFERENCES tbl_genre(pk_genre)
) ENGINE=InnoDB;

CREATE TABLE tbl_user (
    pk_username VARCHAR(255) NOT NULL,
        PRIMARY KEY(pk_username)
) ENGINE=InnoDB;

CREATE TABLE tbl_album_favorite (
    fk_username VARCHAR(255) NOT NULL,
        PRIMARY KEY(fk_username),
        FOREIGN KEY(fk_username) REFERENCES tbl_user(pk_username),    
    fk_album_id INT NOR NULL,
        PRIMARY KEY(fk_album_id),
        FOREIGN KEY(fk_album_id) REFERENCES tbl_album(pk_album_id)
) ENGINE=InnoDB;

CREATE TABLE tbl_song_userdata (
    fk_username VARCHAR(255) NOT NULL,
        PRIMARY KEY(fk_username),
        FOREIGN KEY(fk_username) REFERENCES tbl_user(pk_username),
    fk_song_id INT NOR NULL,
        PRIMARY KEY(fk_song_id),
        FOREIGN KEY(fk_song_id) REFERENCES tbl_album(pk_song_id)    
) ENGINE=InnoDB;
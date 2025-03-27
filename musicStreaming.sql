DROP DATABASE IF EXISTS 'streamingdb'
CREATE DATABASE IF NOT EXISTS 'streamingdb'
USE 'streamingdb'

CREATE TABLE tbl_library (
    pk_id_library ENUM("Musik", "Videos") NOT NULL, -- addd on delete ._.
    pathToLibrary VARCHAR(255)
    PRIMARY KEY(pk_id_library)
) ENGINE=InnoDB;

CREATE TABLE tbl_artist (
    pk_artist_id INT NOT NULL AUTO_INCREMENT,
    artist_name VARCHAR(255),
    PRIMARY KEY(pk_artist_id)
)
DROP DATABASE IF EXISTS musicdbv1;
CREATE DATABASE IF NOT EXISTS musicdbv1 DEFAULT CHARSET=UTF8;

USE musicdbv1;

CREATE TABLE tbl_library (
  pk_id_library INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk_id_library)
);

CREATE TABLE tbl_genre (
  pk_genre VARCHAR(100) NOT NULL,
  PRIMARY KEY (pk_genre)
);

CREATE TABLE tbl_artist (
  pk_artist_id INT NOT NULL AUTO_INCREMENT,
  artist_name VARCHAR(100) NOT NULL,
  fk_id_library INT NOT NULL,
  PRIMARY KEY (pk_artist_id),
  FOREIGN KEY (fk_id_library) REFERENCES tbl_library (pk_id_library)
);

CREATE TABLE tbl_album (
  pk_album_id INT NOT NULL AUTO_INCREMENT,
  album_name VARCHAR(100) NOT NULL,
  fk_artist_id INT NOT NULL,
  PRIMARY KEY (pk_album_id),
  FOREIGN KEY (fk_artist_id) REFERENCES tbl_artist (pk_artist_id)
);

CREATE TABLE tbl_song (
  pk_song_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (pk_song_id)
);

CREATE TABLE tbl_album_song (
  fk_album_id INT NOT NULL,
  fk_song_id INT NOT NULL,
  PRIMARY KEY (fk_album_id, fk_song_id),
  FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id),
  FOREIGN KEY (fk_song_id) REFERENCES tbl_song (pk_song_id)
);

CREATE TABLE tbl_artist_album (
  fk_artist_id INT NOT NULL,
  fk_album_id INT NOT NULL,
  PRIMARY KEY (fk_artist_id, fk_album_id),
  FOREIGN KEY (fk_artist_id) REFERENCES tbl_artist (pk_artist_id),
  FOREIGN KEY (fk_album_id) REFERENCES tbl_album (pk_album_id)
);

CREATE TABLE tbl_song_genre (
  fk_song_id INT NOT NULL,
  fk_genre VARCHAR(100) NOT NULL,
  PRIMARY KEY (fk_song_id, fk_genre),
  FOREIGN KEY (fk_song_id) REFERENCES tbl_song (pk_song_id),
  FOREIGN KEY (fk_genre) REFERENCES tbl_genre (pk_genre)
);


-- Logs:
CREATE TABLE error_log (
  pk_error_id INT NOT NULL AUTO_INCREMENT,
  error_message VARCHAR(255) NOT NULL,
  error_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (pk_error_id)
);


DELIMITER //

CREATE TRIGGER prevent_duplicate_song
BEFORE INSERT ON tbl_song
FOR EACH ROW
BEGIN
    DECLARE song_count INT;
    SELECT COUNT(*) INTO song_count FROM tbl_song WHERE name = NEW.name;
    IF song_count > 0 THEN
        -- Insert the error message into the error_log table
        INSERT INTO error_log (error_message) 
        VALUES (CONCAT('Duplicate song name: ', NEW.name, ' at ', NOW()));
        
        -- Raise an error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate song name is not allowed';
    END IF;
END;

//

DELIMITER ;

-- Insert data into tbl_library
INSERT INTO tbl_library (pk_id_library) VALUES (1);
INSERT INTO tbl_library (pk_id_library) VALUES (2);

-- Insert data into tbl_genre
INSERT INTO tbl_genre (pk_genre) VALUES ('Rock');
INSERT INTO tbl_genre (pk_genre) VALUES ('Pop');
INSERT INTO tbl_genre (pk_genre) VALUES ('Jazz');
INSERT INTO tbl_genre (pk_genre) VALUES ('Classical');
INSERT INTO tbl_genre (pk_genre) VALUES ('Blues');

-- Insert data into tbl_artist
INSERT INTO tbl_artist (artist_name, fk_id_library) VALUES ('The Beatles', 1);
INSERT INTO tbl_artist (artist_name, fk_id_library) VALUES ('Adele', 1);
INSERT INTO tbl_artist (artist_name, fk_id_library) VALUES ('Miles Davis', 2);
INSERT INTO tbl_artist (artist_name, fk_id_library) VALUES ('Beethoven', 2);
INSERT INTO tbl_artist (artist_name, fk_id_library) VALUES ('B.B. King', 1);

-- Insert data into tbl_album
INSERT INTO tbl_album (album_name, fk_artist_id) VALUES ('Abbey Road', 1);
INSERT INTO tbl_album (album_name, fk_artist_id) VALUES ('25', 2);
INSERT INTO tbl_album (album_name, fk_artist_id) VALUES ('Kind of Blue', 3);
INSERT INTO tbl_album (album_name, fk_artist_id) VALUES ('Symphony No. 5', 4);
INSERT INTO tbl_album (album_name, fk_artist_id) VALUES ('Live at the Regal', 5);

-- Insert data into tbl_song
INSERT INTO tbl_song (name) VALUES ('Come Together');          -- Song ID 1
INSERT INTO tbl_song (name) VALUES ('Someone Like You');      -- Song ID 2
INSERT INTO tbl_song (name) VALUES ('So What');               -- Song ID 3
INSERT INTO tbl_song (name) VALUES ('Symphony No. 5 in C Minor'); -- Song ID 4
INSERT INTO tbl_song (name) VALUES ('The Thrill Is Gone');    -- Song ID 5
INSERT INTO tbl_song (name) VALUES ('Hey Jude');              -- Song ID 6

-- Insert data into tbl_album_song (Many-to-Many Relationship)
INSERT INTO tbl_album_song (fk_album_id, fk_song_id) VALUES (1, 1); -- Abbey Road, Come Together
INSERT INTO tbl_album_song (fk_album_id, fk_song_id) VALUES (2, 2); -- 25, Someone Like You
INSERT INTO tbl_album_song (fk_album_id, fk_song_id) VALUES (3, 3); -- Kind of Blue, So What
INSERT INTO tbl_album_song (fk_album_id, fk_song_id) VALUES (4, 4); -- Symphony No. 5, Symphony No. 5 in C Minor
INSERT INTO tbl_album_song (fk_album_id, fk_song_id) VALUES (5, 5); -- Live at the Regal, The Thrill Is Gone
INSERT INTO tbl_album_song (fk_album_id, fk_song_id) VALUES (1, 6); -- Abbey Road, Hey Jude
INSERT INTO tbl_album_song (fk_album_id, fk_song_id) VALUES (2, 6); -- 25, Hey Jude

-- Insert data into tbl_artist_album (Many-to-Many Relationship)
INSERT INTO tbl_artist_album (fk_artist_id, fk_album_id) VALUES (1, 1); -- The Beatles, Abbey Road
INSERT INTO tbl_artist_album (fk_artist_id, fk_album_id) VALUES (2, 2); -- Adele, 25
INSERT INTO tbl_artist_album (fk_artist_id, fk_album_id) VALUES (3, 3); -- Miles Davis, Kind of Blue
INSERT INTO tbl_artist_album (fk_artist_id, fk_album_id) VALUES (4, 4); -- Beethoven, Symphony No. 5
INSERT INTO tbl_artist_album (fk_artist_id, fk_album_id) VALUES (5, 5); -- B.B. King, Live at the Regal

--- Insert data into tbl_song_genre (Many-to-Many Relationship)
INSERT INTO tbl_song_genre (fk_song_id, fk_genre) VALUES (1, 'Rock');      -- Come Together
INSERT INTO tbl_song_genre (fk_song_id, fk_genre) VALUES (2, 'Pop');       -- Someone Like You
INSERT INTO tbl_song_genre (fk_song_id, fk_genre) VALUES (3, 'Jazz');      -- So What
INSERT INTO tbl_song_genre (fk_song_id, fk_genre) VALUES (4, 'Classical'); -- Symphony No. 5 in C Minor
INSERT INTO tbl_song_genre (fk_song_id, fk_genre) VALUES (5, 'Blues');     -- The Thrill Is Gone
INSERT INTO tbl_song_genre (fk_song_id, fk_genre) VALUES (6, 'Rock');      -- Hey Jude
INSERT INTO tbl_song_genre (fk_song_id, fk_genre) VALUES (6, 'Pop');       -- Hey Jude

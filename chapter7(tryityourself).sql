CREATE TABLE albums (
 album_id bigserial,
 album_catalog_code varchar(100),
 album_title text NOT NULL,
 album_artist text NOT NULL,
 album_release_date date,
 album_genre varchar(40),
 album_description text,
 CONSTRAINT album_id_key PRIMARY KEY (album_id),
 CONSTRAINT album_release_unique UNIQUE (album_title, album_release_date)
);

CREATE TABLE songs (
 song_id bigserial,
 song_title text NOT NULL,
 song_artist text NOT NULL,
 album_id bigint REFERENCES albums(album_id),
 CONSTRAINT song_id_key PRIMARY KEY (song_id),
 CONSTRAINT song_title_unique UNIQUE (song_title)
);
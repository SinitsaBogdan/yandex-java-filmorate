-- DROP TABLE
DROP TABLE IF EXISTS TOTAL_FILM_DIRECTOR CASCADE;
DROP TABLE IF EXISTS TOTAL_FILM_LIKE CASCADE;
DROP TABLE IF EXISTS TOTAL_GENRE_FILM CASCADE;
DROP TABLE IF EXISTS TOTAL_USER_FRIENDS CASCADE;
DROP TABLE IF EXISTS TOTAL_LIKE_REVIEWS CASCADE;
DROP TABLE IF EXISTS ROSTER_MPA CASCADE;
DROP TABLE IF EXISTS ROSTER_GENRE CASCADE;
DROP TABLE IF EXISTS EVENTS CASCADE;
DROP TABLE IF EXISTS DIRECTORS CASCADE;
DROP TABLE IF EXISTS REVIEWS CASCADE;
DROP TABLE IF EXISTS FILMS CASCADE;
DROP TABLE IF EXISTS USERS CASCADE;

-- CREATE TABLES
CREATE TABLE IF NOT EXISTS ROSTER_MPA (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    description VARCHAR NOT NULL,
    CONSTRAINT UC_ROSTER_MPA_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS ROSTER_GENRE (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT UC_ROSTER_GENRE_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS USERS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birthday DATE NOT NULL,
    login VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    CONSTRAINT UC_USERS_LOGIN UNIQUE (login),
    CONSTRAINT UC_USERS_EMAIL UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS FILMS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    mpa_id INTEGER REFERENCES ROSTER_MPA (id) ON DELETE SET NULL,
    rate INTEGER DEFAULT 0,
    name VARCHAR(40) NOT NULL,
    description VARCHAR(200) NOT NULL DEFAULT '',
    release_date DATE NOT NULL,
    duration INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS EVENTS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY,
    timestamp timestamp,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    type VARCHAR(10),
    operation VARCHAR(10),
    entity_id INTEGER,
    PRIMARY KEY (id, type, entity_id)
);

CREATE TABLE IF NOT EXISTS DIRECTORS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS REVIEWS (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    content VARCHAR(200) NOT NULL,
    is_positive BIT NOT NULL,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    film_id INTEGER REFERENCES FILMS (id) ON DELETE CASCADE,
    useful INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS TOTAL_FILM_LIKE (
    film_id INTEGER REFERENCES FILMS (id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, user_id)
);

CREATE TABLE IF NOT EXISTS TOTAL_GENRE_FILM (
    film_id INTEGER NOT NULL REFERENCES FILMS (id) ON DELETE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES ROSTER_GENRE (id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, genre_id)
);

CREATE TABLE IF NOT EXISTS TOTAL_USER_FRIENDS (
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    friend_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    status VARCHAR(20),
    PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE IF NOT EXISTS TOTAL_LIKE_REVIEWS (
	review_id INTEGER REFERENCES REVIEWS (id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES USERS (id) ON DELETE CASCADE,
    is_positive BIT NOT NULL,
    PRIMARY KEY (review_id, user_id)
);

CREATE TABLE IF NOT EXISTS TOTAL_FILM_DIRECTOR (
    film_id INTEGER REFERENCES FILMS (id) ON DELETE CASCADE,
    director_id INTEGER REFERENCES DIRECTORS (id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, director_id)
);
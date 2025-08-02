DROP DATABASE IF EXISTS mylibrary;
CREATE DATABASE IF NOT EXISTS mylibrary;
USE mylibrary;

-- Authors table
CREATE TABLE IF NOT EXISTS Authors ( 
    auno INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    birthdate DATETIME
);

-- Publishers table
CREATE TABLE IF NOT EXISTS Publishers ( 
    pubno INT PRIMARY KEY AUTO_INCREMENT,
    pubname VARCHAR(100),
    pubcity VARCHAR(100),
    pubcountry VARCHAR(100),
    birthdate DATETIME
);

-- Books table with FK to Publishers and ON DELETE CASCADE (optional)
CREATE TABLE IF NOT EXISTS Books ( 
    bookno INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    subtitle VARCHAR(100),
    language VARCHAR(20),
    pubno INT,
    CONSTRAINT fk1_books FOREIGN KEY (pubno)
        REFERENCES Publishers (pubno)
        ON DELETE CASCADE
);

-- Editions table (FK to Books)
CREATE TABLE IF NOT EXISTS Editions (
    edno INT PRIMARY KEY AUTO_INCREMENT,
    bookno INT,
    month INT,
    year INT,
    CONSTRAINT fk1_editions FOREIGN KEY (bookno)
        REFERENCES Books(bookno)
        ON DELETE CASCADE
);

-- Junction table BooksAuthors with ON DELETE CASCADE on both FKs
CREATE TABLE IF NOT EXISTS BooksAuthors (  
    bookno INT,
    auno INT,
    PRIMARY KEY (bookno, auno),
    CONSTRAINT fk1_booksauthors FOREIGN KEY (bookno) REFERENCES Books (bookno) ON DELETE CASCADE,
    CONSTRAINT fk2_booksauthors FOREIGN KEY (auno) REFERENCES Authors (auno) ON DELETE CASCADE
);

-- Insert sample data

INSERT INTO Publishers (pubname)
VALUES ('Wrox');
SET @pubno = LAST_INSERT_ID();

INSERT INTO Books (title, language, pubno)
VALUES ('Professional C#', 'English', @pubno);
SET @bookno = LAST_INSERT_ID();

INSERT INTO Authors (firstname, lastname, city, country, birthdate) 
VALUES ('Christian', 'Nagel', 'San Francisco', 'USA', '1970-12-24');
SET @auno1 = LAST_INSERT_ID();

INSERT INTO Authors (firstname, lastname, city, country, birthdate)
VALUES ('Bill', 'Evjen', 'San Francisco', 'USA', '1980-12-20');
SET @auno2 = LAST_INSERT_ID();

INSERT INTO Authors (firstname, lastname, city, country, birthdate)
VALUES ('Jay', 'Glynn', 'San Francisco', 'USA', '1975-11-24');
SET @auno3 = LAST_INSERT_ID();

INSERT INTO BooksAuthors (bookno, auno)
VALUES 
    (@bookno, @auno1),
    (@bookno, @auno2),
    (@bookno, @auno3);

-- Example delete that cascades automatically
DELETE FROM Authors WHERE firstname = 'Bill';

-- Verify results
SELECT * FROM Authors;
SELECT * FROM BooksAuthors;

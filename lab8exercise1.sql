 DROP DATABASE IF EXISTS  mylibrary;

CREATE DATABASE mylibrary;
USE mylibrary;
CREATE TABLE authors(
auno INT PRIMARY KEY AUTO_INCREMENT,
firstname VARCHAR(100),
lastname VARCHAR(100),
city VARCHAR(100),
country VARCHAR(100),
birthdate date


);

CREATE TABLE publishers(
pubno INT PRIMARY KEY AUTO_INCREMENT,
pubname VARCHAR(100),
pubcity VARCHAR(100),
pubcountry VARCHAR(100) 
);




CREATE TABLE books(
bookno INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100),
subtitle VARCHAR(100),
language VARCHAR(100),
pubno INT,
FOREIGN KEY (pubno) REFERENCES publishers(pubno)

);

CREATE TABLE booksauthors(
bookno INT,
auno INT,
PRIMARY KEY (bookno,auno),
FOREIGN KEY (bookno) REFERENCES books(bookno),
FOREIGN KEY (auno) REFERENCES authors(auno)


);


CREATE TABLE editions(
edno INT PRIMARY KEY AUTO_INCREMENT,
bookno INT,
month TINYINT CHECK (month BETWEEN  1 AND 12),
 year YEAR ,

FOREIGN KEY (bookno) REFERENCES books(bookno)


);


INSERT INTO publishers(pubname,pubcity,pubcountry)
VALUES('Wrox','San Fransisco','USA');
set @pub_id = LAST_INSERT_ID();

INSERT INTO books(title,subtitle,language,pubno)
VALUES('Professional c#',NULL,'English',@pub_id);
SET @book_id = LAST_INSERT_ID();

 INSERT INTO authors(firstname,lastname,city,country,birthdate)
VALUES('Christian','Nagel','San Fransisco','USA','1970-12-24');
set @a1 = LAST_INSERT_ID();

 INSERT INTO authors(firstname,lastname,city,country,birthdate)
VALUES('Bill','Evyen','San Fransisco','USA','1980-12-24');
set @a2 = LAST_INSERT_ID();

 INSERT INTO authors(firstname,lastname,city,country,birthdate)
VALUES('Jay','Glynn','San Fransisco','USA','1975-01-24');
set @a3 = LAST_INSERT_ID();

INSERT INTO booksauthors (bookno,auno) VALUES(@book_id,@a1);
INSERT INTO booksauthors (bookno,auno) VALUES(@book_id,@a2);
INSERT INTO booksauthors (bookno,auno) VALUES(@book_id,@a3);


#exercise3
SELECT b.title,a.firstname,a.lastname
FROM books b
JOIN booksauthors ba  on b.bookno = ba.bookno
JOIN authors a on ba.auno = a.auno;

#Exercise4
DELETE FROM authors WHERE firstname = 'bill' AND lastname = 'Evjen';

#Exercise05
ALTER TABLE books add pubdate DATE ;
ALTER TABLE authors add preferred_language VARCHAR(50);
#Exerise06
ALTER TABLE authors
MODIFY preferred_language VARCHAR(50) DEFAULT 'English';

#Exercise07
ALTER TABLE authors
CHANGE preferred_language lang_pref VARCHAR(50) DEFAULT 'English';

#Exercise08
ALTER TABLE authors
MODIFY lang_pref  VARCHAR(2) DEFAULT 'EN';

#Exercise09
DROP TABLE publishers;

-- --------------------------------------------------
-- STEP 1: Create the database and select it
-- --------------------------------------------------
CREATE DATABASE mylibrary;
USE mylibrary;

-- --------------------------------------------------
-- STEP 2: Create tables in correct order
-- --------------------------------------------------

-- Publisher table
CREATE TABLE Publisher (
  PublisherID INT AUTO_INCREMENT PRIMARY KEY,  -- unique ID for each publisher
  PublisherName VARCHAR(100) NOT NULL          -- publisher name
);

-- Language table
CREATE TABLE Language (
  LanguageID INT AUTO_INCREMENT PRIMARY KEY,   -- unique ID for each language
  LanguageName VARCHAR(50) NOT NULL            -- e.g. English, Dutch
);

-- Book table (references Publisher + Language)
CREATE TABLE Book (
  BookID INT AUTO_INCREMENT PRIMARY KEY,       -- unique ID for each book
  Title VARCHAR(200) NOT NULL,                 -- title of the book
  PublisherID INT,                             -- FK → Publisher
  LanguageID INT,                              -- FK → Language
  FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
    ON DELETE RESTRICT ON UPDATE RESTRICT,     -- cannot delete/update Publisher if Book still references it
  FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Address table for Authors
CREATE TABLE Address (
  AddressID INT AUTO_INCREMENT PRIMARY KEY,    -- unique ID
  City VARCHAR(100),
  Country VARCHAR(100)
);

-- Author table (references Address)
CREATE TABLE Author (
  AuthorID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  BirthDate DATE,
  AddressID INT,
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Junction table Book ↔ Author (many-to-many)
CREATE TABLE BookAuthor (
  BookID INT,
  AuthorID INT,
  PRIMARY KEY (BookID, AuthorID),              -- composite key
  FOREIGN KEY (BookID) REFERENCES Book(BookID)
    ON DELETE CASCADE ON UPDATE CASCADE,       -- if book is deleted, links are removed
  FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------
-- STEP 3: Insert the data
-- --------------------------------------------------

-- Publisher
INSERT INTO Publisher (PublisherName) VALUES ('Wrox');
SET @pubID = LAST_INSERT_ID();

-- Language
INSERT INTO Language (LanguageName) VALUES ('English');
SET @langID = LAST_INSERT_ID();

-- Book
INSERT INTO Book (Title, PublisherID, LanguageID)
VALUES ('Professional C#', @pubID, @langID);
SET @bookID = LAST_INSERT_ID();

-- Address
INSERT INTO Address (City, Country) VALUES ('San Francisco', 'USA');
SET @addrID = LAST_INSERT_ID();

-- Authors
INSERT INTO Author (FirstName, LastName, BirthDate, AddressID)
VALUES ('Christian','Nagel','1970-12-24', @addrID);
SET @a1 = LAST_INSERT_ID();

INSERT INTO Author (FirstName, LastName, BirthDate, AddressID)
VALUES ('Bill','Evjen','1980-12-20', @addrID);
SET @a2 = LAST_INSERT_ID();

INSERT INTO Author (FirstName, LastName, BirthDate, AddressID)
VALUES ('Jay','Glynn','1975-01-24', @addrID);
SET @a3 = LAST_INSERT_ID();

-- Link authors to book
INSERT INTO BookAuthor (BookID, AuthorID) VALUES
(@bookID, @a1),
(@bookID, @a2),
(@bookID, @a3);

-- --------------------------------------------------
-- STEP 4: Overview query (Books + Authors + Publisher + Language)
-- --------------------------------------------------
SELECT b.Title,
       CONCAT(a.FirstName, ' ', a.LastName) AS Author,
       p.PublisherName,
       l.LanguageName
FROM Book b
JOIN BookAuthor ba ON b.BookID = ba.BookID   -- connects books to authors
JOIN Author a ON ba.AuthorID = a.AuthorID    -- fetches author names
JOIN Publisher p ON b.PublisherID = p.PublisherID
JOIN Language l ON b.LanguageID = l.LanguageID
ORDER BY b.Title, a.LastName;

-- EXPLANATION:
-- This query produces the required "overview of the books with the authors
-- and the publisher’s details, sorted by book and author."
-- Example output:
-- Title            | Author           | Publisher | Language
-- Professional C#  | Bill Evjen       | Wrox      | English
-- Professional C#  | Christian Nagel  | Wrox      | English
-- Professional C#  | Jay Glynn        | Wrox      | English

-- What if we forgot the BookAuthor join?
-- Then each book would only link to ONE publisher and ONE language,
-- but we would LOSE the many-to-many connection to multiple authors.
-- Result would only show books once, without authors.
-- => That’s why BookAuthor is crucial.

-- --------------------------------------------------
-- STEP 5: Try deleting an Author
-- --------------------------------------------------
DELETE FROM Author WHERE FirstName = 'Bill' AND LastName = 'Evjen';
-- Observation: If BookAuthor has ON DELETE CASCADE → Bill’s link to the book is removed automatically.
-- If ON DELETE RESTRICT → the delete fails, because Author is still referenced in BookAuthor.

-- --------------------------------------------------
-- STEP 6–8: ALTER TABLE examples
-- --------------------------------------------------

-- Add pubdate to Book
ALTER TABLE Book ADD pubdate DATE;

-- Add preferred_language to Author
ALTER TABLE Author ADD preferred_language VARCHAR(50);

-- Set default value
ALTER TABLE Author ALTER preferred_language SET DEFAULT 'English';

-- Rename column
ALTER TABLE Author CHANGE preferred_language lang_pref VARCHAR(50);

-- Change datatype + default
ALTER TABLE Author MODIFY lang_pref VARCHAR(2) DEFAULT 'EN';

-- --------------------------------------------------
-- STEP 9: Drop Publisher
-- --------------------------------------------------
DROP TABLE Publisher;
-- Observation: This fails because Book still references Publisher.
-- To drop Publisher, first drop Book or remove the foreign key.

-- --------------------------------------------------
-- STEP 10: Reverse Engineer to EERD
-- --------------------------------------------------
-- In MySQL Workbench:
-- Database → Reverse Engineer
-- Select schema = mylibrary
-- Select all tables → Execute
-- Workbench generates an EER Diagram with relationships

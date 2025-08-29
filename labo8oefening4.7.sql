-- ----------------------------------------------------
-- Reset the database (delete if exists, then recreate)
-- ----------------------------------------------------
DROP DATABASE IF EXISTS ConcertHall;
CREATE DATABASE ConcertHall;
USE ConcertHall;

-- ----------------------------------------------------
-- Customer table
-- Stores customer information
-- Email is UNIQUE so no two customers can use the same address
-- ----------------------------------------------------
CREATE TABLE Customer(
    CustomerId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(200) NOT NULL,
    Address VARCHAR(200),
    EmailAddress VARCHAR(200) UNIQUE,
    TelePhoneNumber VARCHAR(20)
);

-- ----------------------------------------------------
-- Newsletter table
-- Stores newsletters customers can subscribe to
-- ----------------------------------------------------
CREATE TABLE NewsLetter(
    NewsletterID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Description TEXT
);

-- ----------------------------------------------------
-- CustomerNewsletter junction table
-- Many-to-many relationship between Customer and Newsletter
-- Composite PK (CustomerID, NewsletterID) ensures:
--   - one customer cannot subscribe twice to the same newsletter
-- ON DELETE CASCADE:
--   - if a customer is deleted → all their subscriptions are deleted
--   - if a newsletter is deleted → all its customer links are deleted
-- ----------------------------------------------------
CREATE TABLE CustomerNewsLetter(
   CustomerID INT NOT NULL,
   NewsLetterID INT NOT NULL,
   PRIMARY KEY (CustomerID, NewsletterID),
   FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
     ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY (NewsletterID) REFERENCES Newsletter(NewsletterID)
     ON DELETE CASCADE ON UPDATE CASCADE
);

-- ----------------------------------------------------
-- Event table
-- Stores all concerts/events
-- EventType = ENUM so we can distinguish 'Concert' vs 'Other'
-- ----------------------------------------------------
CREATE TABLE Event(
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(200) NOT NULL,
    EventDATE DATE NOT NULL,
    EventTime TIME NOT NULL,
    Location VARCHAR(200),
    Price DECIMAL(10,2),
    EventType ENUM('Concert','Other') DEFAULT 'Concert'
);

-- ----------------------------------------------------
-- Ticket table
-- Connects Customer ↔ Event
-- ON DELETE CASCADE:
--   - if a customer is deleted → their tickets are deleted
--   - if an event is deleted → all tickets for that event are deleted
-- ----------------------------------------------------
CREATE TABLE Ticket(
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    EventID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
        ON DELETE CASCADE ON UPDATE CASCADE
);



# Data Management Repository

A comprehensive collection of database management exercises, SQL scripts, and documentation for learning database design, normalization, and SQL programming.

## 📚 Overview

This repository contains practical exercises and examples covering various aspects of data management, including:
- SQL query exercises
- Database design and normalization
- Entity-Relationship Diagrams (ERD)
- Database creation and management
- Real-world database scenarios

## 🗂️ Repository Structure

### 📁 Lab Exercises
The repository is organized by lab sessions, each focusing on specific database concepts:

#### **Lab 1-5: Basic SQL Queries**
- `lab1.sql` - Basic SELECT queries with concatenation and filtering
- `lab2.sql` - Advanced SELECT queries with JOINs and aggregations
- `lab3.sql` - Complex queries with subqueries and grouping
- `lab4demo.sql`, `lab4herhaling.sql`, `lab4pascal.sql` - Database creation and table management
- `lab5.sql` - Data manipulation and constraints

#### **Lab 6: Database Documentation**
- `lab6datamanagementcorrect.docx` - Corrected lab documentation
- `lab6datamanegement.docx` - Original lab documentation

#### **Lab 7: Entity-Relationship Modeling**
- `lab7diagram.drawio` - Main ERD diagram
- `lab7oefening*.drawio` - Various ERD exercises (10 different exercises)
- `labo7oefening*.drawio` - Additional ERD practice files

#### **Lab 8: Database Design and Normalization**
- `lab8exercise1.sql` - Library database design (Publisher, Book, Author relationships)
- `lab8exercise2.sql` - Additional database design exercise
- `lab8exercise3retry.mwb` - MySQL Workbench file for exercise 3
- `lab8exercise4.sql` - Database normalization exercise
- `lab8exercise5.sql` - Advanced database design
- `lab8exercise6.sql` - Complex relationships exercise
- `lab8oefening3.md` - Detailed explanation of sensor/actuator database design
- `lab84.4 Sportsclubuitleg` - Sports club database explanation

#### **Lab 9: Advanced Database Concepts**
- `lab9exercise1.sql` - Advanced SQL queries
- `lab9oefening2.md` - School enrollment database design tutorial
- `lab9oefening2.drawio` - ERD for school enrollment system
- `lab9oefening4.sql` - Final database exercise

### 📁 Sample Databases
- `adventureworks.sql` - Microsoft AdventureWorks sample database
- `northwind-data.sql` - Northwind sample database
- `dump_salesDB.sql` - Sales database dump
- `demo1.sql`, `demo2.sql` - Demonstration scripts

### 📁 Documentation and Diagrams
- `*.drawio` files - Entity-Relationship Diagrams created with Draw.io
- `*.md` files - Detailed explanations and tutorials
- `*.png` files - Screenshots and visual aids
- `*.pdf` files - Annotated database dumps

### 📁 Additional Files
- `schooldb_afegwerkt.xlsx` - Excel file with school database data
- `demolab8.mwb` - MySQL Workbench model file

## 🛠️ Technologies Used

- **MySQL** - Primary database management system
- **MySQL Workbench** - Database design and modeling tool
- **Draw.io** - Entity-Relationship Diagram creation
- **SQL** - Database query language
- **Excel** - Data preparation and analysis

## 📖 Key Learning Objectives

### Database Design Principles
- **Normalization** (1NF, 2NF, 3NF)
- **Entity-Relationship Modeling**
- **Foreign Key Relationships**
- **Many-to-Many Relationships**
- **Database Constraints**

### SQL Programming
- **SELECT queries** with various clauses
- **JOIN operations** (INNER, LEFT, RIGHT)
- **Aggregate functions** (COUNT, SUM, AVG, etc.)
- **Subqueries and nested queries**
- **Data manipulation** (INSERT, UPDATE, DELETE)
- **Database creation and table management**

### Real-World Applications
- **Library Management System**
- **School Enrollment System**
- **Sales Database**
- **Sensor/Actuator Monitoring System**
- **Sports Club Management**

## 🚀 Getting Started

### Prerequisites
- MySQL Server installed
- MySQL Workbench (optional, for visual modeling)
- Draw.io account (for ERD creation)

### Setup Instructions
1. Clone this repository
2. Install MySQL Server if not already installed
3. Open MySQL Workbench or MySQL command line client
4. Execute the SQL files in order (lab1.sql, lab2.sql, etc.)

### Running Exercises
```bash
# Example: Run lab 1 exercises
mysql -u your_username -p < lab1.sql

# Or open in MySQL Workbench and execute
```

## 📝 Exercise Examples

### Basic SQL Query (Lab 1)
```sql
-- Exercise 1: Product information with concatenation
SELECT ProductNumber, ProductName, PricePerUnit, Stock,
       CONCAT(Stock, ' pieces') AS StockDisplay,
       CONCAT(PricePerUnit * Stock, '€') AS StockValue 
FROM tblproducts;
```

### Database Design (Lab 8)
```sql
-- Library database with proper relationships
CREATE TABLE Publisher (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL
);

CREATE TABLE Book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    PublisherID INT,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);
```

## 🎯 Best Practices Demonstrated

1. **Database-First Approach** - Create database structure before application code
2. **Proper Naming Conventions** - Clear, descriptive table and column names
3. **Foreign Key Constraints** - Maintain referential integrity
4. **Normalization** - Eliminate data redundancy
5. **Documentation** - Comprehensive explanations for each exercise
6. **Step-by-Step Learning** - Progressive complexity from basic to advanced

## 📚 Additional Resources

- **MySQL Documentation**: https://dev.mysql.com/doc/
- **Draw.io**: https://app.diagrams.net/
- **Database Design Tutorials**: Various .md files in this repository

## 🤝 Contributing

This repository serves as a learning resource for database management. Feel free to:
- Add new exercises
- Improve existing documentation
- Fix any errors in SQL scripts
- Add more detailed explanations

## 📄 License

This repository is for educational purposes. All exercises and examples are designed to help students learn database management concepts.

---

**Note**: This repository contains educational materials for learning database management concepts. Each lab builds upon previous knowledge, so it's recommended to work through the exercises in order.

# 2.2 School enrollments and interests

Yes! Dit is een **klassieke databank-voorbereidingsoefening** die je stap-voor-stap oplost.

Ik leg je de **workflow** uit zoals je die in de praktijk moet doen:

---

## 🔹 Stappenplan oplossing oefening 2.2 (School enrollments and interests)

### **Stap 1. Begrijp het probleem**

We hebben:

- **Student** (met link naar education, en via many-to-many naar domain/interests)
- **Education** (opleidingen)
- **Domain** (domeinen/interesses, zoals AI, IoT, Web, …)
- **StudentDomain** (koppel/intermediaire tabel om many-to-many relatie te realiseren)

👉 Een **student** → hoort bij **één education**

👉 Een **student** ↔ kan meerdere **domains** hebben (en omgekeerd).

---

### **Stap 2. ERD tekenen (optioneel, maar slim!)**

In Draw.io of Workbench:

- **Education** (PK = EducationID)
    - Name
    - Description
    - City
- **Student** (PK = StudentNumber)
    - FullName
    - Gender
    - DateOfBirth
    - Password
    - FK: EducationID → Education
- **Domain** (PK = DomainID)
    - Category
    - Name
    - Description
- **StudentDomain** (PK = combinatie StudentNumber + DomainID)
    - FK: StudentNumber → Student
    - FK: DomainID → Domain je kan anders domain en student niet zomaar met elkaar verbinden tussenbrug.

---

### **Stap 3. Database maken in MySQL**

```sql
CREATE DATABASE schooldb3;
USE schooldb3;

CREATE TABLE Education (
    EducationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    City VARCHAR(100)
);

CREATE TABLE Student (
    StudentNumber INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Gender ENUM('M','F') NOT NULL,
    DateOfBirth DATE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    EducationID INT,
    FOREIGN KEY (EducationID) REFERENCES Education(EducationID)
);

CREATE TABLE Domain (
    DomainID INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(50),
    Name VARCHAR(100) NOT NULL,
    Description TEXT
);

CREATE TABLE StudentDomain (
    StudentNumber INT,
    DomainID INT,
    PRIMARY KEY (StudentNumber, DomainID),
    FOREIGN KEY (StudentNumber) REFERENCES Student(StudentNumber),
    FOREIGN KEY (DomainID) REFERENCES Domain(DomainID)
);

```

---

### **Stap 4. Reverse Engineering**

In MySQL Workbench → **Database → Reverse Engineer**.

Dan krijg je automatisch je **EERD**.

---

### **Stap 5. Excel voorbereiden**

Dit is **de tricky stap**:

1. Open Excel bestand **schooldb_start.xlsx**.
2. Ga naar **Educations** tab:
    - Voeg een kolom `EducationID` toe.
    - Vul oplopend (1,2,3,…) → dit wordt de PK.
    - Kopieer dit naar MySQL → tabel Education. dit is niet perse waar voor de education tab moet je niks doen daar zit alles al goed. je gaat in de eerste tabblad de kolommen een ander kleur geven NameCategoryDescriptionFull nameBirthdateGenderPassword name category description oranje en fullname birthdate gender password name een ander kleur bij domein moet je zo als in je tabel nog een id domain maken autoincrement in mysqlworkbench en dat dan te kopieren en plakken in mysqlworkbench view  vergeet niet duplicaties te filteren bij student moet je dit sleecteren studentnumber is voor auto increment hier ga je ook birthdate in goed formaat omzetten om de code te vinden ga je een vlookup moeten doen de kolom die je nodig hebt zet je altijd als tweede kolom om. zo te kunnen retourneren tweede kolom in andere sheet met deze formule =VLOOKUP(A2;Enrollments!$A$2:$B$77;2;FALSE) avnit student and domains ga je dan de onderstaande kolommen splitten en plaatsen in andere tabellen. uiteindelijk ga je voor je  studentdomain je voor domainid en studentnumber vooraan zetten en dan. kan je zo vlook up gaan doen en zo je waarden plakken en kopieren let op meeste van deze kolommen moet je duplicaten verwijderen domain id kan trouwens maar waarden van 1 tot 14 aannemen =VLOOKUP(Table15[@Name];Domains!A:B;2;FALSE) =VLOOKUP(Table15[@[Full name]];Students!$A$2:$B$87;2;FALSE) voor je code in de students tab moet je filteren zodat je de null waarden op het einde hebt of de waarden voor die niks heeft gevonden zodat je die eruit kan halen. bijvoorbeeld student education omdat je education wilt retourneren.
    
    | Student | Education |
    | --- | --- |
    | Ifeoma Norman | DAE |
    | Elaine Fowler | DAE |
    | Uma P. Poole | DAE |
    | Camilla Hull | DAE |
    
    | StudentNumber |  | Birthdate | Gender | Password | code |
    | --- | --- | --- | --- | --- | --- |
    
    | iddomain |  | Category | Description |
    | --- | --- | --- | --- |
3. Ga naar **Students and domains** tab:
    - Gebruik **Gegevens → Geavanceerd filter → Alleen unieke records** om een lijst met **unieke studenten** te krijgen.
    - Kopieer deze naar een nieuw tabblad “Students”.
    - Voeg een kolom `StudentNumber` toe (1,2,3,…).
    - Voeg kolom `EducationID` toe met een **VLOOKUP** naar de juiste opleiding.
    - Kopieer dit naar MySQL → tabel Student.
4. Voor **domains**:
    - Zelfde aanpak: filter unieke records → nieuw tabblad “Domains”.
    - Voeg `DomainID` toe (1,2,3,…).
    - Kopieer dit naar MySQL → tabel Domain.
5. Voor **StudentDomain**:
    - Gebruik de originele “Students and domains” sheet.
    - Zet er enkel `StudentNumber` + `DomainID` in (via VLOOKUP naar je nieuwe tabs).
    - Kopieer dit naar MySQL → tabel StudentDomain.

---

### **Stap 6. Testen**

Check relaties:

```sql
SELECT s.FullName, d.Name AS Domain
FROM Student s
JOIN StudentDomain sd ON s.StudentNumber = sd.StudentNumber
JOIN Domain d ON sd.DomainID = d.DomainID;

```

Check educations:

```sql
SELECT s.FullName, e.Name AS Education
FROM Student s
JOIN Education e ON s.EducationID = e.EducationID;

```

---

### **Stap 7. Indienen**

- **Dump** (structuur + data):
    
    `mysqldump -u root -p schooldb3 > dump_schooldb.sql`
    
- **EERD**: save als `schooldb.mwb`
- **Excel**: met toegevoegde ID-kolommen en opgeschoonde data.

---

✅ Daarmee heb je het hele proces rond:

- Excel opschonen
- DB schema ontwerpen
- Data normaliseren (3NF-achtig)
- Relaties aanmaken in MySQL
- Data importeren

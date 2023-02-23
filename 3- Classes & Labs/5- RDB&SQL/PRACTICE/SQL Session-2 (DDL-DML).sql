CREATE DATABASE LibraryDB
GO

USE LibraryDB
GO

--create schema

CREATE SCHEMA Person
GO
CREATE SCHEMA Book
GO

--CREATE TABLES

--create Book.Book table
CREATE TABLE [Book].[Book](
	[Book_ID] INT PRIMARY KEY NOT NULL,
	[Book_Name] [NVARCHAR](100) NOT NULL,
	[Author_ID] INT NOT NULL,
	[Publisher_ID] INT NOT NULL);

--create Book.Author table
CREATE TABLE [Book].[Author](
	[Author_ID] INT,
	[Author_FirstName] NVARCHAR(50) NOT NULL,
	[Author_LastName] NVARCHAR(50) NOT NULL);

--create Book.Publisher Table
CREATE TABLE [Book].[Publisher](
	[Publisher_ID] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Publisher_Name] NVARCHAR(100) NULL);

--create Person.Person table
CREATE TABLE [Person].[Person](
	[SSN] BIGINT PRIMARY KEY NOT NULL,
	[Person_FirstName] NVARCHAR(50) NULL,
	[Person_LastName] NVARCHAR(50) NULL);

--create Person.Loan table
CREATE TABLE [Person].[Loan](
	[SSN] BIGINT NOT NULL,
	[Book_ID] INT NOT NULL,
	PRIMARY KEY ([SSN], [Book_ID]));

--create Person.Person_Phone table
CREATE TABLE [Person].[Person_Phone](
	[Phone_Number] BIGINT PRIMARY KEY NOT NULL,
	[SSN] BIGINT NOT NULL REFERENCES [Person].[Person]);

--create Person.Person_Mail table
CREATE TABLE [Person].[Person_Mail](
	[Mail_ID] INT PRIMARY KEY IDENTITY(1,1),
	[Mail] NVARCHAR(MAX) NOT NULL,
	[SSN] BIGINT UNIQUE NOT NULL,
	CONSTRAINT FK_SSNum FOREIGN KEY (SSN) REFERENCES Person.Person(SSN));


--////////////////////////////////////////////////////////////////
-- INSERT
--*************************************

SELECT * FROM Person.Person

INSERT INTO Person.Person ([SSN], [Person_FirstName], [Person_LastName])
	VALUES (12345678911, N'Zehra', N'Tekin')  --N=national character

INSERT INTO Person.Person ([Person_LastName], [SSN], [Person_FirstName])
	VALUES (N'Doðan', 98765432199, N'Eylem') 

INSERT INTO Person.Person ([SSN], [Person_FirstName])
	VALUES (74185296377, N'Kerem')


--It's not mandatory to use column names / INTO is optional

INSERT Person.Person VALUES (36925814733, N'Mert', N'Yetiþ')

INSERT Person.Person VALUES (45678912344, N'Esra', NULL)

SELECT * FROM Person.Person

INSERT Person.Person VALUES (65498732100, N'Ali', N'Tekin')
INSERT Person.Person VALUES (25836914722, N'Metin', N'Sakin')

--primary key values must be unique
INSERT INTO Person.Person (SSN, Person_FirstName, Person_LastName) --ERROR
	VALUES (12345678911, N'Tarýk', N'Kutlu')

--data types must be compatible
INSERT INTO Person.Person (SSN, Person_FirstName, Person_LastName) --ERROR
	VALUES ('NO RECORD', N'Tarýk', N'Kutlu')

----------------------------------------------

SELECT * FROM Person.Person_Mail

INSERT INTO Person.Person_Mail (Mail, SSN) 
	VALUES (N'zehtek@gmail.com', 12345678911),
		   (N'eydogan@hotmail.com', 98765432199),
		   (N'meyet@gmail.com', 36925814733)

--foreign key constraint
SELECT * FROM Person.Person

INSERT INTO Person.Person_Mail (Mail, SSN) 
	VALUES (N'ahm@gmail.com', 11111111111)  --ERROR

--IDENTITY constraint
INSERT INTO Person.Person_Mail (Mail_ID, Mail, SSN) 
	VALUES (10, N'takutlu@gmail.com', 46056688505) --ERROR


---------------------------
-- SELECT INTO

SELECT *
INTO Person.Person_2
FROM Person.Person

SELECT * FROM Person.Person_2

--insert with SELECT statement
INSERT Person.Person_2 (SSN, Person_FirstName, Person_LastName)
SELECT * FROM Person.Person WHERE Person_FirstName LIKE 'M%';

SELECT * FROM Person.Person_2


---------------------------
-- DEFAULT (insert default values)

INSERT Book.Publisher
DEFAULT VALUES

SELECT * FROM Book.Publisher


--////////////////////////////////////////////////////////////////
-- UPDATE
--*************************************

SELECT * FROM Person.Person_2

UPDATE Person.Person_2
SET Person_FirstName='Default_Value'

UPDATE Person.Person_2
SET Person_FirstName='Zehra'
WHERE SSN=12345678911


--////////////////////////////////////////////////////////////////
-- DELETE
--*************************************

--identity constraint
SELECT * FROM Book.Publisher

INSERT Book.Publisher 
VALUES (N'Ýþ Bankasý Kültür Yayýncýlýk'), (N'Can Yayýncýlýk'), (N'Ýletiþim Yayýncýlýk')

DELETE FROM Book.Publisher

INSERT Book.Publisher 
VALUES (N'Ýletiþim')


----------

SELECT * FROM Person.Person_2

DELETE FROM Person.Person_2
WHERE SSN=36925814733


--////////////////////////////////////////////////////////////////
-- DROP - TRUNCATE
--*************************************

DROP TABLE [Person].[Person_2]

DROP TABLE [Person].[Person]  --error, foreign key constraint


SELECT * FROM [Person].[Person_Mail]
SELECT * FROM [Book].[Publisher]

TRUNCATE TABLE [Person].[Person_Mail]
TRUNCATE TABLE [Book].[Publisher]


--////////////////////////////////////////////////////////////////
-- ALTER
--*************************************

--ADD KEY CONSTRAINTS

ALTER TABLE Book.Book 
ADD CONSTRAINT FK_Publisher FOREIGN KEY (Publisher_ID) REFERENCES Book.Publisher (Publisher_ID)

ALTER TABLE Book.Book 
ADD CONSTRAINT FK_Author FOREIGN KEY (Author_ID) REFERENCES Book.Author (Author_ID)  --ERROR

ALTER TABLE Book.Author 
ADD CONSTRAINT pk_author PRIMARY KEY (Author_ID)  --ERROR

ALTER TABLE Book.Author 
ALTER COLUMN Author_ID INT NOT NULL

ALTER TABLE Book.Author 
ADD CONSTRAINT pk_author PRIMARY KEY (Author_ID)

ALTER TABLE Book.Book 
ADD CONSTRAINT FK_Author FOREIGN KEY (Author_ID) REFERENCES Book.Author (Author_ID)


----------------
--Person.Loan Table

ALTER TABLE Person.Loan 
ADD CONSTRAINT FK_PERSON FOREIGN KEY (SSN) REFERENCES Person.Person (SSN)
ON UPDATE NO ACTION --default
ON DELETE NO ACTION --default

ALTER TABLE Person.Loan 
ADD CONSTRAINT FK_book FOREIGN KEY (Book_ID) REFERENCES Book.Book (Book_ID)
ON UPDATE NO ACTION --default
ON DELETE CASCADE


--ADD CHECK CONSTRAINTS
ALTER TABLE Person.Person 
ADD CONSTRAINT ck_PersonID Check (LEN(SSN)=11)

SELECT * FROM Person.Person;

INSERT Person.Person VALUES(12345678, N'Tarýk', N'Kutlu')

ALTER TABLE Person.Person
DROP CONSTRAINT ck_PersonID;



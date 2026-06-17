USE master;
GO

-- Reset database state
IF DB_ID('MediaLibrary_DB') IS NOT NULL
BEGIN
    ALTER DATABASE MediaLibrary_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MediaLibrary_DB;
END
GO

CREATE DATABASE MediaLibrary_DB;
GO

USE MediaLibrary_DB;
GO

-- Dimension tables
CREATE TABLE Director (
    DirectorID INT IDENTITY(1,1) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Director PRIMARY KEY (DirectorID)
);
GO

CREATE TABLE Star (
    StarID INT IDENTITY(1,1) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Star PRIMARY KEY (StarID)
);
GO

CREATE TABLE Genre (
    GenreID INT IDENTITY(1,1) NOT NULL,
    GenreDescription VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Genre PRIMARY KEY (GenreID)
);
GO

CREATE TABLE Producer (
    ProducerID INT IDENTITY(1,1) NOT NULL,
    FirstName VARCHAR(50) NULL,
    LastName VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Producer PRIMARY KEY (ProducerID)
);
GO

-- Main Movie table
CREATE TABLE Movie (
    MovieID INT IDENTITY(1,1) NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Rating FLOAT NOT NULL,
    DirectorID INT NOT NULL,
    StarID INT NOT NULL,
    GenreID INT NOT NULL,
    ProducerID INT NOT NULL,
    CONSTRAINT PK_Movie PRIMARY KEY (MovieID)
);
GO

-- Foreign Keys
ALTER TABLE Movie
ADD CONSTRAINT FK_Movie_Director FOREIGN KEY (DirectorID) REFERENCES Director(DirectorID);
GO

ALTER TABLE Movie
ADD CONSTRAINT FK_Movie_Star FOREIGN KEY (StarID) REFERENCES Star(StarID);
GO

ALTER TABLE Movie
ADD CONSTRAINT FK_Movie_Genre FOREIGN KEY (GenreID) REFERENCES Genre(GenreID);
GO

ALTER TABLE Movie
ADD CONSTRAINT FK_Movie_Producer FOREIGN KEY (ProducerID) REFERENCES Producer(ProducerID);
GO
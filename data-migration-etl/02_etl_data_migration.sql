USE MediaLibrary_DB;
GO

-- Clear existing data and reset identity sequences
DELETE FROM Movie;
DELETE FROM Director;
DELETE FROM Star;
DELETE FROM Genre;
DELETE FROM Producer;

DBCC CHECKIDENT ('Movie', RESEED, 0);
DBCC CHECKIDENT ('Director', RESEED, 0);
DBCC CHECKIDENT ('Star', RESEED, 0);
DBCC CHECKIDENT ('Genre', RESEED, 0);
DBCC CHECKIDENT ('Producer', RESEED, 0);
GO

-- Extract distinct records from staging area into dimensions
INSERT INTO Director (FirstName, LastName)
SELECT DISTINCT Director_FirstName, Director_LastName
FROM Movies_Import_Temp
WHERE Director_LastName IS NOT NULL;

INSERT INTO Star (FirstName, LastName)
SELECT DISTINCT Star_FirstName, Star_LastName
FROM Movies_Import_Temp
WHERE Star_LastName IS NOT NULL;

INSERT INTO Genre (GenreDescription)
SELECT DISTINCT Genre
FROM Movies_Import_Temp
WHERE Genre IS NOT NULL;

INSERT INTO Producer (FirstName, LastName)
SELECT DISTINCT Producer_FirstName, Producer_LastName
FROM Movies_Import_Temp
WHERE Producer_LastName IS NOT NULL;
GO
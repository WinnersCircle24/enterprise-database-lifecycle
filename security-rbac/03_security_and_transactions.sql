USE MediaLibrary_DB;
GO

-- Reporting view for abstracted data access
CREATE VIEW vw_MovieMasterList AS
SELECT 
    m.Title,
    m.Rating,
    d.FirstName + ' ' + d.LastName AS Director,
    s.FirstName + ' ' + s.LastName AS LeadStar,
    g.GenreDescription AS Genre
FROM Movie m
JOIN Director d ON m.DirectorID = d.DirectorID
JOIN Star s ON m.StarID = s.StarID
JOIN Genre g ON m.GenreID = g.GenreID;
GO

-- Transactional insert for new genres
CREATE PROCEDURE sp_InsertSecureGenre
    @NewGenreName VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF EXISTS (SELECT 1 FROM Genre WHERE GenreDescription = @NewGenreName)
        BEGIN
            ;THROW 50001, 'Genre already exists in the system.', 1;
        END

        INSERT INTO Genre (GenreDescription)
        VALUES (@NewGenreName);

        COMMIT TRANSACTION;
        PRINT 'Transaction Committed Successfully.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        PRINT 'Transaction Failed and Rolled Back.';
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Security roles and permissions setup
CREATE ROLE ReportAuditor;
CREATE ROLE DataEntryClerk;
GO

-- Auditor permissions
GRANT SELECT ON vw_MovieMasterList TO ReportAuditor;
DENY SELECT ON Movie TO ReportAuditor; 

-- Clerk permissions
GRANT EXECUTE ON sp_InsertSecureGenre TO DataEntryClerk;
DENY INSERT ON Genre TO DataEntryClerk;
GO
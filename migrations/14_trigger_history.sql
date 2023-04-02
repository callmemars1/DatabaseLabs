CREATE OR ALTER TRIGGER trg_TeachersHistoryTrigger
    ON Teachers
    AFTER INSERT, UPDATE, DELETE
    AS
BEGIN
    DECLARE @Action varchar(1) =
        CASE
            WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
                THEN 'U'
            WHEN EXISTS(SELECT * FROM inserted)
                THEN 'I'
            WHEN EXISTS(SELECT * FROM deleted)
                THEN 'D'
            ELSE
                NULL --Unknown
            END;

    IF OBJECT_ID(N'TeachersHistory', N'U') IS NULL
        BEGIN
            CREATE TABLE TeachersHistory
            (
                TeacherId  INT,
                FirstName  NVARCHAR(100),
                SecondName NVARCHAR(100),
                Patronymic NVARCHAR(100),
                Action     VARCHAR(1),
                ActionDate DATETIME
            )
        END;
    WITH InsertedUpdatedDeleted AS (SELECT Id, FirstName, SecondName, Patronymic
                                    FROM inserted
                                    UNION
                                    SELECT Id, FirstName, SecondName, Patronymic
                                    FROM deleted)
    
    INSERT INTO TeachersHistory (TeacherId, FirstName, SecondName, Patronymic, Action, ActionDate)
    SELECT Id, FirstName, SecondName, Patronymic, @Action, GETDATE()
    FROM InsertedUpdatedDeleted
END
CREATE OR ALTER TRIGGER trg_TeachersInsertUpdate
    ON Teachers
    INSTEAD OF INSERT, UPDATE
    AS
BEGIN
    IF EXISTS(SELECT * FROM inserted WHERE FirstName IS NULL OR FirstName = '')
        RAISERROR ('Cannot insert or update teacher with empty or null first name', 16, 1)

    IF EXISTS(SELECT * FROM inserted)
        INSERT INTO Teachers (FirstName, SecondName, Patronymic, DepartmentId)
        SELECT FirstName, SecondName, Patronymic, DepartmentId
        FROM inserted;
    ELSE
        UPDATE t
        SET t.FirstName    = i.FirstName,
            t.SecondName   = i.SecondName,
            t.Patronymic   = i.Patronymic,
            t.DepartmentId = i.DepartmentId
        FROM Teachers t
                 JOIN inserted i ON t.Id = i.Id;
END

GO

CREATE OR ALTER TRIGGER trg_DeleteEmptyBuildingInsteadOf
    ON Buildings
    INSTEAD OF DELETE
    AS
BEGIN
    IF EXISTS(SELECT *
              FROM Classrooms C
              WHERE C.BuildingId IN (SELECT d.Id FROM deleted d))
        RAISERROR ('Cannot remove building if classrooms exists', 16, 1)

    DELETE
    FROM Buildings
    WHERE Id IN (SELECT d.Id FROM deleted d)
END
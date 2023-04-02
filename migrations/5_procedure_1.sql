CREATE OR ALTER PROCEDURE CREATE_TEACHER @firstName NVARCHAR(100),
                                         @secondName NVARCHAR(100),
                                         @patronymic NVARCHAR(100),
                                         @departmentName NVARCHAR(120),
                                         @facultyName NVARCHAR(120)
AS
BEGIN
    DECLARE @facultyId TABLE
                       (
                           Id INT
                       )
    DECLARE @departmentId TABLE
                          (
                              Id INT
                          )

    INSERT INTO @facultyID SELECT TOP 1 F.Id FROM Faculties F WHERE F.Name = @facultyName
    INSERT INTO @departmentId SELECT TOP 1 D.Id FROM Departments D WHERE D.Name = @departmentName

    IF NOT EXISTS(SELECT * FROM @facultyId)
        INSERT INTO Faculties (Name)
        OUTPUT inserted.Id INTO @facultyId
        VALUES (@facultyName)

    IF NOT EXISTS(SELECT * FROM @departmentId)
        INSERT INTO Departments (Name, FacultyId)
        OUTPUT inserted.Id INTO @departmentId
        SELECT TOP 1 @departmentName, Id
        FROM @facultyId

    INSERT INTO Teachers (DepartmentId, FirstName, SecondName, Patronymic)
    SELECT TOP 1 d.Id, @firstName, @secondName, @patronymic
    FROM @departmentId d
END;
GO;
CREATE OR ALTER PROCEDURE UPDATE_FACULTY_STATISTICS
AS
BEGIN
    IF OBJECT_ID('tempdb..##FacultyStatistics') IS NULL
        BEGIN
            CREATE TABLE ##FacultyStatistics
            (
                FacultyId     INT NOT NULL PRIMARY KEY,
                GroupsCount   INT NOT NULL,
                TeachersCount INT NOT NULL,
                LessonsCount  INT NOT NULL
            )
        END

    EXEC ('CREATE OR ALTER VIEW GetStatisticsForFaculties AS
            (
            SELECT F.Id, COUNT(DISTINCT G.Id) AS GC, COUNT(DISTINCT T.Id) AS TC, COUNT(DISTINCT LG.LessonID) AS LC
            FROM Faculties F
                     INNER JOIN Groups G on F.Id = G.FacultyId
                     INNER JOIN Departments D on F.Id = D.FacultyId
                     INNER JOIN Teachers T on D.Id = T.DepartmentId
                     INNER JOIN LessonGroup LG on G.Id = LG.GroupID
            GROUP BY F.Id)')

    INSERT INTO ##FacultyStatistics (FacultyId, GroupsCount, TeachersCount, LessonsCount)
    SELECT *
    FROM GetStatisticsForFaculties SFF
    WHERE NOT EXISTS(
            SELECT FacultyId
            FROM ##FacultyStatistics
            WHERE SFF.Id = FacultyId)

    UPDATE ##FacultyStatistics
    SET GroupsCount=SFF.GC,
        TeachersCount=SFF.TC,
        LessonsCount=SFF.LC
    FROM GetStatisticsForFaculties SFF
    WHERE FacultyId = SFF.Id

END

GO

EXEC UPDATE_FACULTY_STATISTICS
GO
SELECT *
FROM tempdb.##FacultyStatistics
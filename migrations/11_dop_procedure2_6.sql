-- while
CREATE OR ALTER PROCEDURE NORMALIZE_LESSONS_COUNT_FOR_GROUP(@groupId INT, @normalLessonsCount INT)
AS
BEGIN
    WHILE (SELECT COUNT(DISTINCT LG.LessonID)
           FROM Groups G
                    INNER JOIN LessonGroup LG on G.Id = LG.GroupID
           WHERE G.Id = @groupId) > @normalLessonsCount
        BEGIN
            DELETE
            FROM Lessons
            WHERE Id = (SELECT TOP 1 Id
                        FROM Lessons L
                                 INNER JOIN LessonGroup LG on L.Id = LG.LessonID
                        WHERE LG.GroupID = @groupId)
        END
END


-- goto
/*CREATE OR ALTER PROCEDURE NORMALIZE_LESSONS_COUNT_FOR_GROUP(@groupId INT, @normalLessonsCount INT)
AS
BEGIN
    IF ((SELECT COUNT(DISTINCT LG.LessonID)
         FROM Groups G
                  INNER JOIN LessonGroup LG on G.Id = LG.GroupID
         WHERE G.Id = @groupId) <= @normalLessonsCount)
        RETURN

    DeleteLesson:
    DELETE
    FROM Lessons
    WHERE Id = (SELECT TOP 1 Id
                FROM Lessons L
                         INNER JOIN LessonGroup LG on L.Id = LG.LessonID
                WHERE LG.GroupID = @groupId)

    IF (SELECT COUNT(DISTINCT LG.LessonID)
        FROM Groups G
                 INNER JOIN LessonGroup LG on G.Id = LG.GroupID
        WHERE G.Id = @groupId) > @normalLessonsCount
        GOTO DeleteLesson
END
*/
GO

EXEC NORMALIZE_LESSONS_COUNT_FOR_GROUP 3, 0
SELECT COUNT(DISTINCT LG.LessonID) AS LessonsCount
FROM Groups G
         INNER JOIN LessonGroup LG on G.Id = LG.GroupID
WHERE G.Id = 3
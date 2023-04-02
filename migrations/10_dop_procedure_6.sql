-- case
-- waitfor

CREATE OR ALTER FUNCTION HOW_MANY_LESSONS_GROUP_HAVE_AT_DAY(@groupId INT, @dayId INT)
    RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @result NVARCHAR(255) = null
    ;WITH GroupLessonsToday AS (SELECT COUNT(DISTINCT L.Id) AS LessonsCount
                               FROM Lessons L
                                        INNER JOIN LessonGroup LG on L.Id = LG.LessonID
                               WHERE LG.GroupID = @groupId
                                 AND L.Day = @dayId)

    SELECT @result = (SELECT TOP 1 LessonText =
                                 CASE GLT.LessonsCount
                                     WHEN 6 THEN N'Шесть пар'
                                     WHEN 5 THEN N'Пять пар'
                                     WHEN 4 THEN N'Четыре пары'
                                     WHEN 3 THEN N'Три пары'
                                     WHEN 2 THEN N'Две пары'
                                     WHEN 1 THEN N'Одна пара'
                                     WHEN 0 THEN N'Нет занятий'
                                     ELSE N'Ошибка!'
                                     END
                      FROM GroupLessonsToday GLT)
    RETURN @result
END

GO
WAITFOR DELAY '00:00:05'
GO

SELECT Id, [dbo].[HOW_MANY_LESSONS_GROUP_HAVE_AT_DAY](Id, 3) AS LessonsCount
FROM Groups
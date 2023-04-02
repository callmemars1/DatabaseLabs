CREATE OR ALTER FUNCTION GET_GROUPS_WITH_LESS_THEN_3_PAIRS_PER_DAY()
    RETURNS TABLE
AS
    RETURN (SELECT GroupId
            FROM (SELECT G.Id AS GroupId, COUNT(*) AS LessonsCount
                  FROM Lessons
                           INNER JOIN LessonGroup LG on Lessons.Id = LG.LessonID
                           INNER JOIN Groups G on G.Id = LG.GroupID
                  GROUP BY Day, G.Id) AS LessonsPerDayForGroupCTE
            GROUP BY GroupId
            HAVING AVG(CAST(LessonsCount AS FLOAT)) < 3)
GO

SELECT * FROM GetGroupsWithLessThen3PairsPerDay()
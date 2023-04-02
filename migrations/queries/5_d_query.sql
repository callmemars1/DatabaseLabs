-- д) группы, у которых в среднем менее 3-х пар в день;


WITH LessonsPerDayForGroupCTE AS (SELECT Day, G.Name AS GroupName, COUNT(*) AS LessonsCount
                                  FROM Lessons
                                           INNER JOIN LessonGroup LG on Lessons.Id = LG.LessonID
                                           INNER JOIN Groups G on G.Id = LG.GroupID
                                  GROUP BY Day, G.Id, G.Name)

SELECT GroupName, AVG(CAST(LessonsCount AS FLOAT)) AS AverageLessonsPerDay FROM LessonsPerDayForGroupCTE
GROUP BY GroupName
HAVING AVG(CAST(LessonsCount AS FLOAT)) < 3

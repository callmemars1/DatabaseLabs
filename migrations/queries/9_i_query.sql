-- и) преподавателей, ведущих занятия в максимальном количестве групп.

WITH GroupsPerTeacherCTE AS (SELECT T.Id, T.SecondName, COUNT(DISTINCT LG.GroupID) AS GroupsCount
                             FROM Teachers T
                                      INNER JOIN LessonTeacher LT on T.Id = LT.TeacherID
                                      INNER JOIN LessonGroup LG on LT.LessonID = LG.LessonID
                             GROUP BY T.Id, T.SecondName)

SELECT GPTCTE.SecondName, GPTCTE.GroupsCount FROM GroupsPerTeacherCTE GPTCTE
WHERE GPTCTE.GroupsCount = (SELECT MAX(GPTCNNested.GroupsCount) FROM GroupsPerTeacherCTE GPTCNNested)

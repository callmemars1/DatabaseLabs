-- е) преподавателей, ведущих более трех различных дисциплин;

SELECT T.SecondName, COUNT(DISTINCT DisciplineId) AS DisciplineCount
FROM Teachers T
         LEFT JOIN LessonTeacher LT on T.Id = LT.TeacherID
         LEFT JOIN Lessons L on L.Id = LT.LessonID
GROUP BY T.Id, T.SecondName
HAVING COUNT(DISTINCT DisciplineId) >= 3;
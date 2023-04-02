-- г) количество дисциплин для каждого преподавателя;

SELECT T.SecondName, COUNT(DISTINCT DisciplineId) AS DisciplinesCount
FROM Lessons L
         LEFT JOIN LessonTeacher LT on L.Id = LT.LessonID
         LEFT JOIN Teachers T on LT.TeacherID = T.Id
GROUP BY T.Id, T.SecondName
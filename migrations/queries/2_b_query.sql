-- б) преподавателей, ведущих как Базы данных, так и Логическое программирование;

WITH TeachersWithLessonInfoCTE AS (SELECT t.Id         AS TeacherId,
                                          t.SecondName AS TeacherSecondName,
                                          d.Name       AS DisciplineName
                                   FROM Teachers t
                                            JOIN LessonTeacher lt ON t.Id = lt.TeacherID
                                            JOIN Lessons l ON lt.LessonID = l.Id
                                            JOIN Disciplines d ON l.DisciplineId = d.Id)

SELECT DISTINCT TWL1.TeacherId, TWL1.TeacherSecondName
FROM TeachersWithLessonInfoCTE TWL1,
     TeachersWithLessonInfoCTE TWL2
WHERE TWL1.TeacherId = TWL2.TeacherId
  AND (TWL1.DisciplineName = 'Logic Programming' AND TWL2.DisciplineName = 'Databases')
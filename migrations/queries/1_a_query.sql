-- а) преподавателей, ведущих Базы данных на различных факультетах;

WITH TeachersWithLessonInfoCTE AS (SELECT t.Id         AS TeacherId,
                                          t.SecondName AS TeacherSecondName,
                                          d.Name       AS DisciplineName,
                                          g.FacultyId
                                   FROM Teachers t
                                            JOIN LessonTeacher lt ON t.Id = lt.TeacherID
                                            JOIN Lessons l ON lt.LessonID = l.Id
                                            JOIN Disciplines d ON l.DisciplineId = d.Id
                                            JOIN LessonGroup lg ON l.Id = lg.LessonID
                                            JOIN Groups g ON lg.GroupID = g.Id
                                            JOIN Faculties f ON g.FacultyId = f.Id)

SELECT DISTINCT TWL1.TeacherId, TWL1.TeacherSecondName
FROM TeachersWithLessonInfoCTE TWL1,
     TeachersWithLessonInfoCTE TWL2
WHERE TWL1.TeacherId = TWL2.TeacherId
  AND (TWL1.DisciplineName = 'Databases' AND TWL2.DisciplineName = 'Databases')
  AND (TWL1.FacultyId <> TWL2.FacultyId)


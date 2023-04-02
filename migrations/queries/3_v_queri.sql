-- в) преподавателей, которые ведут более двух видов занятий по одной дисциплине;

WITH TeachersWithLessonInfoCTE AS (SELECT t.Id         AS TeacherId,
                                          t.SecondName AS TeacherSecondName,
                                          LT2.Id       AS LessonTypeId,
                                          l.DisciplineId
                                   FROM Teachers t
                                            JOIN LessonTeacher lt ON t.Id = lt.TeacherID
                                            JOIN Lessons l ON lt.LessonID = l.Id
                                            JOIN LessonTypes LT2 on l.LessonTypeId = LT2.Id)

SELECT DISTINCT TWL1.TeacherId, TWL1.TeacherSecondName
FROM TeachersWithLessonInfoCTE TWL1,
     TeachersWithLessonInfoCTE TWL2
WHERE TWL1.TeacherId = TWL2.TeacherId
  AND TWL1.DisciplineId = TWL2.DisciplineId
  AND TWL1.LessonTypeId <> TWL2.LessonTypeId
-- з) преподавателей, ведущих все виды занятий;

/*SELECT T.SecondName
FROM Teachers T
         INNER JOIN LessonTeacher LT on T.Id = LT.TeacherID
         INNER JOIN Lessons L on L.Id = LT.LessonID
GROUP BY T.Id, T.SecondName
HAVING COUNT(DISTINCT L.LessonTypeId) = (SELECT COUNT(*)
                                         FROM LessonTypes)*/

/*SELECT DISTINCT L.LessonTypeId
FROM Teachers T
         INNER JOIN LessonTeacher LT on T.Id = LT.TeacherID
         INNER JOIN Lessons L on L.Id = LT.LessonID

INTERSECT

SELECT Id
FROM LessonTypes
*/
/*SELECT T.Id
FROM Teachers T
WHERE NOT EXISTS(SELECT Id
                 FROM LessonTypes
                 
                 EXCEPT

                 SELECT DISTINCT L.LessonTypeId
                 FROM Lessons L
                          INNER JOIN LessonTeacher LT on L.Id = LT.LessonID
                 WHERE LT.TeacherID = T.Id)*/

/*select distinct ДФ.Ф from ДФ where not exists
    (select * from Д4Ф where not exists
            (select * from ДФ ДФ1
             where ДФ1.Ф = ДФ.Ф and
                     ДФ1.Д = Д4Ф.Д))*/

WITH TeacherLessonType AS (SELECT T.Id AS TeacherId, T.SecondName AS TeachersSecondName, L.LessonTypeId
                           FROM Teachers T
                                    INNER JOIN LessonTeacher LT on T.Id = LT.TeacherID
                                    INNER JOIN Lessons L on L.Id = LT.LessonID
                           GROUP BY T.Id, T.SecondName, L.LessonTypeId)

SELECT DISTINCT TLT.TeachersSecondName
FROM TeacherLessonType TLT
WHERE NOT EXISTS(
        SELECT *
        FROM LessonTypes LT
        WHERE NOT EXISTS(
                SELECT *
                FROM TeacherLessonType TLTNested
                WHERE TLTNested.TeacherId = TLT.TeacherId
                  AND TLTNested.LessonTypeId = LT.Id
            )
    )
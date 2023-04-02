-- ж) преподавателей, которые ведут занятия только на старших курсах;

SELECT T.SecondName
FROM Teachers T
WHERE NOT EXISTS(
    SELECT * FROM Groups G
    INNER JOIN LessonGroup LG on G.Id = LG.GroupID
    INNER JOIN LessonTeacher LT on LG.LessonID = LT.LessonID
    WHERE LT.TeacherID = T.Id AND G.Course < 3
)
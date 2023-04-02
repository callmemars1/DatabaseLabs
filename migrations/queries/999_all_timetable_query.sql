SELECT L.Id, L.Day, L.SerialNumber, T.SecondName, D.Name, LType.Name, G.Name, F.Name
FROM Lessons L
         INNER JOIN Disciplines D on D.Id = L.DisciplineId
         INNER JOIN LessonTypes LType on LType.Id = L.LessonTypeId
         INNER JOIN LessonTeacher LT on L.Id = LT.LessonID
         INNER JOIN Teachers T on T.Id = LT.TeacherID
         INNER JOIN LessonGroup LG on L.Id = LG.LessonID
         INNER JOIN Groups G on G.Id = LG.GroupID
         INNER JOIN Faculties F on F.Id = G.FacultyId
ORDER BY L.Day, L.SerialNumber

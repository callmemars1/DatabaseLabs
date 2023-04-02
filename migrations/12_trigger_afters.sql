CREATE OR ALTER TRIGGER trg_InsertLessons
    ON Lessons
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF EXISTS(
            SELECT *
            FROM Lessons l
                     JOIN inserted i ON l.Day = i.Day AND l.SerialNumber = i.SerialNumber
            WHERE l.ClassroomId = i.ClassroomId
              AND l.Id <> i.Id
        )
        RAISERROR ('Classroom is already assigned to another lesson at the same time', 16, 1)

    IF EXISTS(
            SELECT *
            FROM Lessons l
                     JOIN inserted i ON l.Day = i.Day AND l.SerialNumber = i.SerialNumber
                     JOIN LessonTeacher lt ON l.Id = lt.LessonID
                     JOIN LessonTeacher it ON i.Id = it.LessonID
            WHERE lt.TeacherID = it.TeacherID
              AND l.Id <> i.Id
        )
        RAISERROR ('Teacher is already assigned to another lesson at the same time', 16, 1)

    IF EXISTS(
            SELECT *
            FROM Lessons l
                     JOIN inserted i ON l.Day = i.Day AND l.SerialNumber = i.SerialNumber
                     JOIN LessonGroup lg ON l.Id = lg.LessonID
                     JOIN LessonGroup ig ON i.Id = ig.LessonID
            WHERE lg.GroupID = ig.GroupID
              AND l.Id <> i.Id
        )
        RAISERROR ('Group is already assigned to another lesson at the same time', 16, 1)
END;

GO

CREATE OR ALTER TRIGGER trg_DeleteEmptyBuilding
    ON Classrooms
    AFTER DELETE
    AS
BEGIN
    IF NOT EXISTS(SELECT *
                  FROM Classrooms C
                           INNER JOIN deleted d ON C.Id = d.Id
                  WHERE C.BuildingId = d.BuildingId)
        BEGIN
            DELETE
            FROM Buildings
            WHERE EXISTS(SELECT *
                         FROM deleted d
                         WHERE d.BuildingId = Buildings.Id)
        END
END